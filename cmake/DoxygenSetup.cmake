# For more information about Doxygen see https://www.doxygen.nl/manual/index.html

# It is necessary to use CMake version not lower than 3.9
find_package(Doxygen
OPTIONAL_COMPONENTS dot mscgen dia
)

if (${DOXYGEN_FOUND})

# What kind of docs to generate
set(DOXYGEN_GENERATE_HTML       YES)
set(DOXYGEN_HTML_OUTPUT "${CMAKE_SOURCE_DIR}/dochtml")
set(DOXYGEN_GENERATE_LATEX      NO)
set(DOXYGEN_USE_PDFLATEX        NO)

set(DOXYGEN_GENERATE_DOCBOOK    NO)
set(DOXYGEN_GENERATE_MAN        NO)
set(DOXYGEN_GENERATE_RTF        NO)
set(DOXYGEN_GENERATE_XML        NO)

# Shown setups
# set(DOXYGEN_EXTRACT_ALL         YES)
set(DOXYGEN_SHOW_HEADERFILE     YES)
set(DOXYGEN_SHOW_INCLUDE_FILES  YES)
set(DOXYGEN_EXTRACT_PRIVATE     NO)
set(DOXYGEN_INTERNAL_DOCS       YES)

set(DOXYGEN_USE_MDFILE_AS_MAINPAGE  "readme.md")

# List excluded files
set(DOXYGEN_EXCLUDE_PATTERNS 
    */.git/*
    */.svn/*
    */.hg/*
    */CMakeFiles/*
    */_CPack_Packages/*
    DartConfiguration.tcl
    CMakeLists.txt
    CMakeCache.txt
    ${CMAKE_PROJECT_NAME}_autogen
)

#[[ Main calling Doxygen command within CMake with signature:
    
    doxygen_add_docs(targetName
        [filesOrDirs...]
        [ALL]
        [USE_STAMP_FILE]
        [WORKING_DIRECTORY dir]
        [COMMENT comment]
        [CONFIG_FILE filename])
]]# 

doxygen_add_docs(
    doxygen
    ${PROJECT_SOURCE_DIR}
    COMMENT "Generate HTML pages"
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
)


endif()
