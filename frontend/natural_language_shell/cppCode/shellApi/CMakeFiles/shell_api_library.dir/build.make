# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.24

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /opt/homebrew/Cellar/cmake/3.24.2/bin/cmake

# The command to remove a file.
RM = /opt/homebrew/Cellar/cmake/3.24.2/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/gabrielclark/Documents/projects/natural-language-shell/frontend/natural_language_shell/CppCode/shellApi

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/gabrielclark/Documents/projects/natural-language-shell/frontend/natural_language_shell/CppCode/shellApi

# Include any dependencies generated for this target.
include CMakeFiles/shell_api_library.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/shell_api_library.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/shell_api_library.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/shell_api_library.dir/flags.make

CMakeFiles/shell_api_library.dir/shellScriptRunner.cpp.o: CMakeFiles/shell_api_library.dir/flags.make
CMakeFiles/shell_api_library.dir/shellScriptRunner.cpp.o: shellScriptRunner.cpp
CMakeFiles/shell_api_library.dir/shellScriptRunner.cpp.o: CMakeFiles/shell_api_library.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/gabrielclark/Documents/projects/natural-language-shell/frontend/natural_language_shell/CppCode/shellApi/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/shell_api_library.dir/shellScriptRunner.cpp.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/shell_api_library.dir/shellScriptRunner.cpp.o -MF CMakeFiles/shell_api_library.dir/shellScriptRunner.cpp.o.d -o CMakeFiles/shell_api_library.dir/shellScriptRunner.cpp.o -c /Users/gabrielclark/Documents/projects/natural-language-shell/frontend/natural_language_shell/CppCode/shellApi/shellScriptRunner.cpp

CMakeFiles/shell_api_library.dir/shellScriptRunner.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/shell_api_library.dir/shellScriptRunner.cpp.i"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/gabrielclark/Documents/projects/natural-language-shell/frontend/natural_language_shell/CppCode/shellApi/shellScriptRunner.cpp > CMakeFiles/shell_api_library.dir/shellScriptRunner.cpp.i

CMakeFiles/shell_api_library.dir/shellScriptRunner.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/shell_api_library.dir/shellScriptRunner.cpp.s"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/gabrielclark/Documents/projects/natural-language-shell/frontend/natural_language_shell/CppCode/shellApi/shellScriptRunner.cpp -o CMakeFiles/shell_api_library.dir/shellScriptRunner.cpp.s

# Object files for target shell_api_library
shell_api_library_OBJECTS = \
"CMakeFiles/shell_api_library.dir/shellScriptRunner.cpp.o"

# External object files for target shell_api_library
shell_api_library_EXTERNAL_OBJECTS =

libshell_api_library.dylib: CMakeFiles/shell_api_library.dir/shellScriptRunner.cpp.o
libshell_api_library.dylib: CMakeFiles/shell_api_library.dir/build.make
libshell_api_library.dylib: CMakeFiles/shell_api_library.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/gabrielclark/Documents/projects/natural-language-shell/frontend/natural_language_shell/CppCode/shellApi/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX shared library libshell_api_library.dylib"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/shell_api_library.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/shell_api_library.dir/build: libshell_api_library.dylib
.PHONY : CMakeFiles/shell_api_library.dir/build

CMakeFiles/shell_api_library.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/shell_api_library.dir/cmake_clean.cmake
.PHONY : CMakeFiles/shell_api_library.dir/clean

CMakeFiles/shell_api_library.dir/depend:
	cd /Users/gabrielclark/Documents/projects/natural-language-shell/frontend/natural_language_shell/CppCode/shellApi && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/gabrielclark/Documents/projects/natural-language-shell/frontend/natural_language_shell/CppCode/shellApi /Users/gabrielclark/Documents/projects/natural-language-shell/frontend/natural_language_shell/CppCode/shellApi /Users/gabrielclark/Documents/projects/natural-language-shell/frontend/natural_language_shell/CppCode/shellApi /Users/gabrielclark/Documents/projects/natural-language-shell/frontend/natural_language_shell/CppCode/shellApi /Users/gabrielclark/Documents/projects/natural-language-shell/frontend/natural_language_shell/CppCode/shellApi/CMakeFiles/shell_api_library.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/shell_api_library.dir/depend
