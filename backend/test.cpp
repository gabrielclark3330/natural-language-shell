#define CPPHTTPLIB_OPENSSL_SUPPORT
#include "cpp-httplib-master/httplib.h"
#include <iostream>
#include <fstream>
#include <string>
#include "json.hpp"

using json = nlohmann::json;

std::string getToken(){
	std::ifstream f("secret.json");
	json data = json::parse(f);
	return data["OpenAIKey"];
}

int main(void)
{
	httplib::SSLClient cli("api.openai.com");
	cli.set_bearer_token_auth(getToken());

	httplib::Headers headers = {
		{"Cache-Control", "no-cache"},
		{"Accept", "*/*"},
		{"Accept-Encoding", "gzip, deflate, br"},
		{"Connection", "keep-alive"}
	};

	json data;

	if (auto res = cli.Get("/v1/models/code-davinci-002", headers)) {
    	if (res->status == 200) {
			// std::cout << res->body << std::endl;
			data = json::parse(res->body);
			std::cout << data["id"] << std::endl;
		}
	} else {
		auto err = res.error();
		std::cout << "HTTP error: " << httplib::to_string(err) << std::endl;
  	}
}