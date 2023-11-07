# get git hash
macro(get_git_hash _git_hash)
    find_package(Git QUIET)
    if(GIT_FOUND)
        execute_process(
                COMMAND ${GIT_EXECUTABLE} log -1 --pretty=format:%h
                OUTPUT_VARIABLE ${_git_hash}
                OUTPUT_STRIP_TRAILING_WHITESPACE
                ERROR_QUIET
                WORKING_DIRECTORY
                ${CMAKE_CURRENT_SOURCE_DIR}
                )
    endif()
endmacro()

# get git branch
macro(get_git_branch _git_branch)
    find_package(Git QUIET)
    if(GIT_FOUND)
        execute_process(
                COMMAND ${GIT_EXECUTABLE} symbolic-ref --short -q HEAD
                OUTPUT_VARIABLE ${_git_branch}
                OUTPUT_STRIP_TRAILING_WHITESPACE
                ERROR_QUIET
                WORKING_DIRECTORY
                ${CMAKE_CURRENT_SOURCE_DIR}
                )
    endif()
endmacro()

function(create_build_info)
    # Get git info
    set(GIT_HASH "")
    get_git_hash(GIT_HASH)
    # git_BRANCh
    set(GIT_BRANCH "")
    get_git_branch(GIT_BRANCH)
    # Generate header file containing useful build information
    add_custom_target(BuildInfo.h ALL
        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
        COMMAND ${CMAKE_COMMAND}
        -DBUILD_INFO_SOURCE_DIR="${CMAKE_SOURCE_DIR}"
        -DBUILD_INFO_DST_DIR="${PROJECT_BINARY_DIR}"
        -DSAMPLE_BUILDINFO_IN="${PROJECT_SOURCE_DIR}/cmake/templates/BuildInfo.h.in"
        -DSAMPLE_BUILD_TYPE="${CMAKE_BUILD_TYPE}"
        -DSAMPLE_BUILD_OS="${CMAKE_SYSTEM_NAME}"
        -DSAMPLE_BUILD_COMPILER="${CMAKE_CXX_COMPILER_ID}"
        -DSAMPLE_BUILD_COMPILER_VERSION="${CMAKE_CXX_COMPILER_VERSION}"
        -DSAMPLE_VERSION_SUFFIX="${VERSION_SUFFIX}"
        -DPROJECT_VERSION="${PROJECT_VERSION}"
        -DGIT_HASH="${GIT_HASH}"
        -DGIT_BRANCH="${GIT_BRANCH}"
        -DPROJECT_NAME="${PROJECT_NAME}"
        -P "${PROJECT_SOURCE_DIR}/cmake/scripts/buildinfo.cmake"
        )
    include_directories(BEFORE ${PROJECT_BINARY_DIR})
endfunction()
