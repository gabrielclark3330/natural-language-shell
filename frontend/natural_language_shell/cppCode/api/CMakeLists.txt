cmake_minimum_required(VERSION 3.10)

# specify the C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# set the project name
project(api)

# add the api.cpp file as the source file
set(API_SOURCES api.cpp)

# include the current directory as a search path for headers
include_directories(${CMAKE_CURRENT_SOURCE_DIR})

# set the target type to SHARED to create a DLL
set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)
add_library(api_lib SHARED ${API_SOURCES})

# link the openssl and crypto libraries
find_package(OpenSSL REQUIRED)
target_link_libraries(api_lib OpenSSL::SSL OpenSSL::Crypto)
