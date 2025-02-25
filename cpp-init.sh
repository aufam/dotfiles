#!/bin/bash

# C++ project initializer
# How to use:
# curl -s https://raw.githubusercontent.com/aufam/dotfiles/main/cpp-init.sh | bash -s -- $project_name $project_version $project_description

# Set the project name
PROJECT_NAME=$1
PROJECT_VERSION=$2
PROJECT_DESCRIPTION=$3

# Check if project name is provided
if [ -z "$PROJECT_NAME" ]; then
    echo "Usage: $0 <project_name> <project_version> <project_description>"
    exit 1
fi

# Check if project version is provided
if [ -z "$PROJECT_VERSION" ]; then
    PROJECT_VERSION=0.1.0
fi

# Create the project directory structure
mkdir -p $PROJECT_NAME/src
mkdir -p $PROJECT_NAME/cmake

# Include CPM
echo "Downloading CPM.cmake..."
wget -q -O $PROJECT_NAME/cmake/CPM.cmake https://github.com/cpm-cmake/CPM.cmake/releases/latest/download/get_cpm.cmake

# Check if CPM.cmake was successfully downloaded
if [ $? -ne 0 ]; then
    echo "Failed to download CPM.cmake. Check your internet connection."
    exit 1
fi

# Create a basic main.cpp file
cat <<EOL > $PROJECT_NAME/src/main.cpp
#include <fmt/format.h>

int main() {
    fmt::println("Hello world from {} v{}!", "$PROJECT_NAME", "$PROJECT_VERSION");
    return 0;
}
EOL

# Create a basic CMakeLists.txt file
cat <<EOL > $PROJECT_NAME/CMakeLists.txt
cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

# project settings
project($PROJECT_NAME
    VERSION     $PROJECT_VERSION
    DESCRIPTION "$PROJECT_DESCRIPTION"
)

# executable
file(GLOB_RECURSE SOURCES src/*)
add_executable($PROJECT_NAME \${SOURCES})

# external libraries
include(cmake/CPM.cmake)
CPMAddPackage("gh:aufam/delameta#main")
CPMAddPackage("gh:catchorg/Catch2@3.7.0")

target_link_libraries($PROJECT_NAME PRIVATE
    preprocessor
    fmt-header-only
    delameta
    Catch2
)

# warnings
target_compile_options($PROJECT_NAME PRIVATE
    -Wall
    -Wextra
    -pedantic
)

# install
install(
    TARGETS     $PROJECT_NAME
    DESTINATION \${CMAKE_INSTALL_BINDIR}
)

# cpack
set(CPACK_PACKAGE_NAME $PROJECT_NAME)
set(CPACK_PACKAGE_VERSION \${$(echo $PROJECT_NAME)_VERSION})
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY \${$(echo $PROJECT_NAME)_DESCRIPTIION})

set(CPACK_DEBIAN_PACKAGE_MAINTAINER $(whoami))
set(CPACK_DEBIAN_FILE_NAME DEB-DEFAULT)

include(CPack)

EOL

# Create basic .gitgnore
wget -q -O $PROJECT_NAME/.gitignore https://raw.githubusercontent.com/aufam/dotfiles/main/gitignore

# Init git
cd $PROJECT_NAME && git init --initial-branch=main

# Print success message
echo "C++ project '$PROJECT_NAME' has been initialized."
