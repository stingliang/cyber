# CMake required version
cmake_minimum_required(VERSION 3.15)

# set project name and version
project(hyper VERSION 0.1.0 LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 17)

# Requirements of compiler
set(REQUIRED_COMPILER_VERSION 9.4)
if (NOT (CMAKE_CXX_COMPILER_VERSION VERSION_GREATER ${REQUIRED_COMPILER_VERSION}
        OR CMAKE_CXX_COMPILER_VERSION VERSION_EQUAL ${REQUIRED_COMPILER_VERSION}))
    message(FATAL_ERROR
            "${PROJECT_NAME} requires g++ ${REQUIRED_COMPILER_VERSION} or greater."
            "Current is ${CMAKE_CXX_COMPILER_VERSION}")
endif ()

# add cmake module path
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

# get basic info
include(BuildInfo)
create_build_info()

# add 3rdparty module
include(Options)
include(ProjectBoost)
print_config()

# add sub directory
include_directories(${PROJECT_SOURCE_DIR})

add_subdirectory(main)

# enable test
if(TESTS)
    enable_testing()
    add_subdirectory(test)
endif()

# enable tools
if(TOOLS)
    add_subdirectory(tools)
endif ()
