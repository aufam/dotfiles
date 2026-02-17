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
mkdir -p src
mkdir -p cmake

# Include CPM
echo "Downloading CPM.cmake..."
wget -q -O cmake/CPM.cmake https://github.com/cpm-cmake/CPM.cmake/releases/latest/download/get_cpm.cmake

# Check if CPM.cmake was successfully downloaded
if [ $? -ne 0 ]; then
	echo "Failed to download CPM.cmake."
	exit 1
fi

# Create a basic main.cpp file
cat <<EOL >src/main.cpp
#include <fmt/format.h>

int main() {
    fmt::println("Hello world from {} v{}!", "$PROJECT_NAME", "$PROJECT_VERSION");
    return 0;
}
EOL

# Create a basic CMakeLists.txt file
cat <<EOL >CMakeLists.txt
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

## String formatter using fmtlib
CPMAddPackage(
    NAME            fmt
    GIT_REPOSITORY  "https://github.com/fmtlib/fmt"
    GIT_TAG         11.2.0
    COMPONENTS      fmt
)

## Logging
CPMAddPackage(
    NAME            spdlog
    GIT_REPOSITORY  "https://github.com/gabime/spdlog"
    GIT_TAG         v1.15.3
    OPTIONS         "SPDLOG_FMT_EXTERNAL ON"
    COMPONENTS      spdlog
)

## JSON lib
CPMAddPackage(
    NAME            nlohmann_json
    URL             "https://github.com/nlohmann/json/releases/download/v3.12.0/json.tar.xz"
)

## toml lib
CPMAddPackage(
    NAME            tomlplusplus
    GIT_REPOSITORY  "https://github.com/marzer/tomlplusplus"
    GIT_TAG         v3.4.0
)

## Boost's struct reflection
CPMAddPackage(
    NAME            pfr
    GIT_REPOSITORY  "https://github.com/boostorg/pfr"
    GIT_TAG         boost-1.88.0
    OPTIONS         "BOOST_USE_MODULES OFF"
    COMPONENTS      Boost::pfr
)

## Enum reflection
CPMAddPackage(
    NAME            magic_enum
    GIT_REPOSITORY  "https://github.com/Neargye/magic_enum"
    GIT_TAG         v0.9.7
)

## Option parser
CPMAddPackage(
    NAME            CLI11
    GIT_REPOSITORY  "https://github.com/CLIUtils/CLI11"
    GIT_TAG         v2.6.1
)

## Tests using GoogleTest
CPMAddPackage(
    NAME            googletest
    GIT_REPOSITORY  "https://github.com/google/googletest"
    GIT_TAG         v1.15.2
    OPTIONS         "INSTALL_GTEST OFF"
    COMPONENTS      gtest_main
)

## benchmark
CPMAddPackage(
    NAME            benchmark
    GIT_REPOSITORY  "https://github.com/google/benchmark"
    GIT_TAG         v1.9.2
    OPTIONS         "BENCHMARK_ENABLE_INSTALL OFF" "BENCHMARK_INSTALL_DOCS OFF" "BENCHMARK_INSTALL_TOOLS OFF" "BENCHMARK_USE_BUNDLED_GTEST OFF"
    COMPONENTS      benchmark_main
)

target_link_libraries($PROJECT_NAME PRIVATE
    fmt
    spdlog
    nlohmann_json
    tomlplusplus::tomlplusplus
    Boost::pfr
    magic_enum
    CLI11
)

target_compile_features($PROJECT_NAME PRIVATE cxx_std_17)

# warnings
target_compile_options($PROJECT_NAME PRIVATE
    -Wall
    -Wextra
    -pedantic
)
EOL

# Create basic .gitgnore
wget -q -O .gitignore https://raw.githubusercontent.com/aufam/dotfiles/main/gitignore

# Init git
git init --initial-branch=main

# Print success message
echo "C++ project '$PROJECT_NAME' has been initialized."
