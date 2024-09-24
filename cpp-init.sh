#!/bin/bash

# C++ project initializer
# How to use:
# curl -s https://raw.githubusercontent.com/aufam/dotfiles/main/cpp-init.sh | bash -s -- $project_name $optional_project_version

# Set the project name
PROJECT_NAME=$1
PROJECT_VERSION=$2

# Check if project name is provided
if [ -z "$PROJECT_NAME" ]; then
    echo "Usage: $0 <project_name>"
    exit 1
fi

# Check if project version is provided
if [ -z "$PROJECT_VERSION" ]; then
    PROJECT_VERSION=0.1.0
fi

# Generating $PROJECT_VERSION_DEFINITION
PROJECT_VERSION_DEFINITION="$(echo $PROJECT_NAME | tr '[:lower:]' '[:upper:]' | tr '-' '_')_VERSION"

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
    fmt::println("Hello world from {} v{}!", "$PROJECT_NAME", $PROJECT_VERSION_DEFINITION);
    return 0;
}
EOL

# Create a basic CMakeLists.txt file
cat <<EOL > $PROJECT_NAME/CMakeLists.txt
cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

# project settings
set($PROJECT_VERSION_DEFINITION "$PROJECT_VERSION")
project($PROJECT_NAME VERSION \${$PROJECT_VERSION_DEFINITION})
message(STATUS "Configuring $PROJECT_NAME v\${$PROJECT_VERSION_DEFINITION}...")

# executable
file(GLOB_RECURSE SOURCES src/*)
add_executable($PROJECT_NAME \${SOURCES})

# external libraries
include(cmake/CPM.cmake)
CPMAddPackage("gh:boostorg/preprocessor#boost-1.86.0")
CPMAddPackage("gh:fmtlib/fmt#11.0.2")
CPMAddPackage("gh:catchorg/Catch2@3.7.0")

target_link_libraries($PROJECT_NAME PRIVATE
    Boost::preprocessor
    fmt
    Catch2
)

# C/C++ standard
target_compile_features($PROJECT_NAME PRIVATE
    c_std_23
    cxx_std_23
)

# warnings
target_compile_options($PROJECT_NAME PRIVATE
    -Wall
    -Wextra
    -pedantic
)

# version
target_compile_definitions($PROJECT_NAME PUBLIC
    $PROJECT_VERSION_DEFINITION="\${$PROJECT_VERSION_DEFINITION}"
)
EOL

# Create basic .gitgnore
curl https://raw.githubusercontent.com/aufam/dotfiles/main/.gitignore -o $PROJECT_NAME/.gitignore

# Init git
cd $PROJECT_NAME && git init --initial-branch=main

# Print success message
echo "C++ project '$PROJECT_NAME' has been initialized."
