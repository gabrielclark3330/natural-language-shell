#define CPPHTTPLIB_OPENSSL_SUPPORT
#include <array>
#include "cpp-httplib-master/httplib.h"
#include <cstdio>
#include <iostream>
#include "json.hpp"
#include <memory>
#include <stdexcept>
#include <string>

using json = nlohmann::json;

httplib::Client client("https://api.openai.com");

std::string getToken(){
	std::ifstream f("secret.json");
	json data = json::parse(f);
	return data["OpenAIKey"];
}

std::string sendPrompt(std::string prompt){

	json data = {
		{"model", "code-davinci-002"},
		{"prompt", "/*" + prompt + "*/"},
		{"max_tokens", 1024},
		// {"temperature", 1},
		// {"top_p", 1},
		// {"n", 1},
		// {"stream", false},
		// {"logprobs", NULL},
		// {"echo", false},
		// {"stop", NULL},
		// {"presence_penalty", 0},
		// {"frequency_penalty", 0},
		// {"best_of", 1},
		// {"logit_bias", NULL},
		// {"user", NULL}
	};

	auto res = client.Post("/v1/completions", data.dump(), "application/json");

	if (res && res->status == 200) {
		std::cout << "Successful response" << std::endl;
		// std::cout << "Successful response: " << res->body << std::endl;
		
		json response = json::parse(res->body);
    	std::vector<json> choices = response["choices"];
    	std::string result = choices[0]["text"];

		return result;
	} else {
		std::cout << "Request failed" << std::endl;
		return "";
	}
}

std::string command(const char* cmd){
	std::array<char, 128> buffer;
    std::string result;
    std::unique_ptr<FILE, decltype(&pclose)> pipe(popen(cmd, "r"), pclose);
    if (!pipe) {
        throw std::runtime_error("popen() failed!");
    }
    while (fgets(buffer.data(), buffer.size(), pipe.get()) != nullptr) {
        result += buffer.data();
    }
    return result;
}

int main() {

	std::string prompt = "Write a command to list folders for terminal";

	client.set_bearer_token_auth(getToken());

	std::string response = sendPrompt(prompt);

	if(response == ""){
		return 0;
	} else {
		std::cout << response << std::endl;
	}

	std::string validation;
	std::cin >> validation;

	if(validation == "Yes"){
		std::string commandOutput = command(response.data());
		std::cout << commandOutput << std::endl;
	} else {
		std::cout << "Cancelled" << std::endl;
	}

	return 0;
}
