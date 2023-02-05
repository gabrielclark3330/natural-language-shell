cmake_minimum_required(VERSION 3.7 FATAL_ERROR)
project(api_library VERSION 1.0.0)

#target_include_directories(api_library -L/Users/gabrielclark/Documents/projects/natural-language-shell/frontend/natural_language_shell/cppCode/shellApi/openssl-master/include/openssl)
add_library(api_library SHARED api.cpp json.hpp httplib.h -L/Users/gabrielclark/Documents/projects/natural-language-shell/frontend/natural_language_shell/cppCode/shellApi/openssl-master/include/openssl/err.h.in)


