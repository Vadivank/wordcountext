cmake_minimum_required(VERSION 3.16)

project(wordcountext VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_FLAGS_RELEASE "-O0")

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/arch")


find_package(QT NAMES Qt5 COMPONENTS Core Quick Svg REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick Svg REQUIRED)

list (APPEND _QML_IMPORT_PATHS ${CMAKE_SOURCE_DIR}/qml)
set (QML_IMPORT_PATH ${_QML_IMPORT_PATHS} CACHE STRING "Path used to locate CMake modules by Qt Creator" FORCE)
set (QML2_IMPORT_PATH ${_QML_IMPORT_PATHS} CACHE STRING "Path used to locate CMake modules by Qt Creator" FORCE)



set(OTHER_FILES ${PROJECT_SOURCE_DIR}/readme.md)

set(PROJECT_SOURCES
  resources/resource.qrc

  qml/qml.qrc

  entrypoint/main.cpp

  entrypoint/qmlprovider.h
  entrypoint/qmlprovider.cpp

  datamodel/datamodel.h
  datamodel/datamodel.cpp

  datamodel/datareceiver.h
  datamodel/datareceiver.cpp
)


add_executable(${PROJECT_NAME} ${PROJECT_SOURCES} ${OTHER_FILES})

if(CMAKE_BUILD_TYPE STREQUAL "Release")
  set_property(TARGET ${PROJECT_NAME} PROPERTY WIN32_EXECUTABLE TRUE)
endif()

target_include_directories(${PROJECT_NAME}
  PUBLIC
    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Svg
    Qt${QT_VERSION_MAJOR}::Quick
    ${PROJECT_SOURCE_DIR}
    ${PROJECT_SOURCE_DIR}/datamodel
    ${PROJECT_SOURCE_DIR}/entrypoint
    ${PROJECT_SOURCE_DIR}/qml
    ${PROJECT_SOURCE_DIR}/resources
)

target_link_libraries(${PROJECT_NAME}
  PUBLIC
    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Quick
    Qt${QT_VERSION_MAJOR}::Svg
)



list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
include(cmake/Install.cmake)
include(cmake/DoxygenSetup.cmake)