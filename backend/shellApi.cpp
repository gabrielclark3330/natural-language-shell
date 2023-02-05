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
		// {"model", "code-davinci-002"},
		// {"model", "code-cushman-001"},
		{"model", "text-davinci-003"},
		// {"prompt", "/*" + prompt + "*/"},
		{"prompt", prompt},
		{"max_tokens", 1024},
		// {"temperature", 1},
		// {"top_p", 1},
		// {"n", 1},
		// {"stream", false},
		// {"logprobs", NULL},
		// {"echo", false},
		{"stop", "#"},
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
		auto err = res.error();
		std::cout << "HTTP error: " << httplib::to_string(err) << std::endl;
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
	std::cout << "N>";
	std::string prompt;
	std::string line;
	while(getline(std::cin, line)){
		if(!line.empty()){
			prompt += "\n" + line;
			std::cout << "N>";
		} else {
			break;
		}
	}

	std::cout << prompt << std::endl;

	client.set_bearer_token_auth(getToken());

	std::string response = sendPrompt(prompt);

	if(response == ""){
		return 0;
	}

	std::cout << response << std::endl;

	std::cout << "Is the command valid? ";
	std::string validCommand;
	getline(std::cin, validCommand);

	if(validCommand == "Yes" || validCommand == "yes" || validCommand == "y" || validCommand == "Y"){
		std::string commandOutput = command(response.data());
		std::cout << commandOutput << std::endl;
	}

	return 0;
}
