#include <cstdio>
#include <iostream>
#include <memory>
#include <stdexcept>
#include <string>
#include <array>
#include <string.h>

using namespace std;
extern "C" char* exec(char* cmd) {
	std::array<char, 128> buffer;
	std::string result;
	std::unique_ptr<FILE, decltype(&pclose)> pipe(popen(cmd, "r"), pclose);
	if (!pipe) {
		throw std::runtime_error("popen() failed!");
	}
	while (fgets(buffer.data(), buffer.size(), pipe.get()) != nullptr) {
		result.append(buffer.data());
	}

	const char* ret = result.c_str();
	std::cout << ret;
	return strdup(ret);
}

/*
int main() {
	const char* chars = exec("ls");
	std::cout << chars;
	return 1;
}
*/
