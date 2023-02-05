#define CPPHTTPLIB_OPENSSL_SUPPORT
#include "cpp-httplib-master/httplib.h"
#include <iostream>
#include "json.hpp"

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

int main() {

	std::string prompt = "Create a python program to print hello world";

	client.set_bearer_token_auth(getToken());

	std::string response = sendPrompt(prompt);
	std::cout << "G'DAY MATEY!!!!!" << std::endl;

	std::cout << response << std::endl;
	std::cout << "YA FINISHED MATE!!!" << std::endl;

	return 0;
}
