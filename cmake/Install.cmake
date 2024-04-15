set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_INCLUDE_CURRENT_BINARY_DIR ON)
set(INSTALL_RPATH_USE_LINK_PATH ON)

if(WIN32)
  set(CMAKE_PREFIX_PATH       "C:/Qt/Qt5.12.12/5.12.12/mingw73_64") # <<== WARNING!
  set(CMAKE_INSTALL_PREFIX    "${CMAKE_BINARY_DIR}/${PROJECT_NAME}-win")
  message("===>>> Windows settings loading OK")
elseif(UNIX)
  set(CMAKE_INSTALL_PREFIX    "${CMAKE_BINARY_DIR}/${PROJECT_NAME}-linux")
  message("===>>> Linux settings loading OK")
else()
  message("-- CMAKE_SYSTEM_INFO_FILE: ${CMAKE_SYSTEM_INFO_FILE}")
  message("-- CMAKE_SYSTEM_NAME:      ${CMAKE_SYSTEM_NAME}")
  message("-- CMAKE_SYSTEM_PROCESSOR: ${CMAKE_SYSTEM_PROCESSOR}")
  message("-- CMAKE_SYSTEM:           ${CMAKE_SYSTEM}")
  string (REGEX MATCH "\\.el[1-9]" os_version_suffix ${CMAKE_SYSTEM})
  message("-- os_version_suffix:      ${os_version_suffix}")
endif()

#########################################################
# Windows deploy
#########################################################

if(WIN32)

# Per https://doc.qt.io/qt-6/windows-deployment.html
# The windeployqt executable creates all the necessary folder tree
# "containing the Qt-related dependencies (libraries, QML imports,
# plugins, and translations) required to run the application from
# that folder".
find_program(WINDEPLOYQT_EXECUTABLE windeployqt HINTS "${QT5_BIN_DIR}")

# Per https://cmake.org/cmake/help/latest/command/add_executable.html
# "IMPORTED executables are useful for convenient reference from commands
# like add_custom_command()".
if(EXISTS ${WINDEPLOYQT_EXECUTABLE})
  add_executable(Qt5::windeployqt IMPORTED)
  set_target_properties(Qt5::windeployqt PROPERTIES IMPORTED_LOCATION ${WINDEPLOYQT_EXECUTABLE})
endif()

# Set windeployqt options for install Qt plugins only
if(TARGET Qt5::windeployqt)

  # First, execute windeployqt in a temporary directory after the build
  # to create the directory structure and files that Qt needs on Windows...
  add_custom_command(TARGET ${CMAKE_PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E remove_directory "${CMAKE_CURRENT_BINARY_DIR}/windeployqt"
    COMMAND Qt5::windeployqt
        --plugindir "${CMAKE_CURRENT_BINARY_DIR}/windeployqt"
        --qmldir "${CMAKE_CURRENT_SOURCE_DIR}/qml"
        --release
        --force
        --no-compiler-runtime
        # --no-libraries
        # --no-patchqt
        # --no-quick-import
        --no-translations
        --no-system-d3d-compiler
        --no-webkit2
        --no-angle
        --no-opengl-sw
        "$<TARGET_FILE_DIR:${CMAKE_PROJECT_NAME}>/$<TARGET_FILE_NAME:${CMAKE_PROJECT_NAME}>"
  )

  # ...then we copy that directory tree to
  # (a) the installation directory (when "make install" is run)
  # and
  # (b) the directory where we run the test executable (straight away)
  install(DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/windeployqt/" DESTINATION "${CMAKE_BINARY_DIR}/bin")

  add_custom_target(
    copy-runtime-files ALL
    COMMAND ${CMAKE_COMMAND} -E copy_directory "${CMAKE_BINARY_DIR}/windeployqt/" "${CMAKE_INSTALL_PREFIX}"
    DEPENDS ${CMAKE_PROJECT_NAME}
  )

endif() # if(TARGET Qt5::windeployqt)
endif() # if(WIN32)

# Windows-specific library linking
if(WIN32 AND MINGW)

include(InstallRequiredSystemLibraries)

# TODO: automate pass flags to CMake instead hardcode
# MinGW-specific flags:
#    -Wl,-subsystem,windows     - suppresses the output command window.
#    -Wl,-enable-stdcall-fixup  - If the link finds a symbol that it cannot resolve, it will attempt to do “fuzzy
#                                 linking” by looking for another defined symbol that differs only in the format of
#                                 the symbol name (cdecl vs stdcall) and will resolve that symbol by linking to the
#                                 match (and also print a warning).
#    -Wl,-enable-auto-import    - Do sophisticated linking of _symbol to __imp__symbol for DATA imports from DLLs, and
#                                 create the necessary thunking symbols when building the import libraries with those
#                                 DATA exports.
#    -Wl,-enable-runtime-pseudo-reloc - Fixes some of the problems that can occur with -enable-auto-import
#    -mthreads                  - specifies that MinGW-specific thread support is to be used
set_target_properties(${CMAKE_PROJECT_NAME}
  PROPERTIES
  LINK_FLAGS "-Wl,-enable-stdcall-fixup -Wl,-enable-auto-import -Wl,-enable-runtime-pseudo-reloc -mthreads -Wl,-subsystem,windows"
)


# TODO: automate library selection by CMake
set(RUNTIME_LIBS
  "${QT_DIR}/../../../bin/libstdc++-6.dll"
  "${QT_DIR}/../../../bin/libgcc_s_seh-1.dll"
  "${QT_DIR}/../../../bin/libwinpthread-1.dll"
)


# Copy runtime dependencies to build directory
add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy
    $<TARGET_RUNTIME_DLLS:${PROJECT_NAME}>
    $<TARGET_FILE_DIR:${PROJECT_NAME}>
    COMMAND_EXPAND_LISTS

  COMMAND ${CMAKE_COMMAND} -E copy
    ${RUNTIME_LIBS}
    $<TARGET_FILE_DIR:${PROJECT_NAME}>
)


# Copy runtime dependencies to install directory
install(FILES ${RUNTIME_LIBS} DESTINATION ${CMAKE_INSTALL_PREFIX})
install(DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/ DESTINATION ${CMAKE_INSTALL_PREFIX})
install(FILES $<TARGET_RUNTIME_DLLS:${PROJECT_NAME}> DESTINATION ${CMAKE_INSTALL_PREFIX})


# Install executable
install(TARGETS ${PROJECT_NAME}
        RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}
        COMPONENT ${RUNTIME_INSTALL_COMPONENT}
)

endif() # if(WIN32 AND MINGW)

if (UNIX)
install(TARGETS ${PROJECT_NAME} DESTINATION ${CMAKE_INSTALL_PREFIX})
endif()
