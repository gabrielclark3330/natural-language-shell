cmake_minimum_required(VERSION 3.7 FATAL_ERROR)
project(shell_api_library VERSION 1.0.0)

add_library(shell_api_library SHARED shellScriptRunner.cpp)

