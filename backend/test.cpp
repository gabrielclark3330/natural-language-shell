#define CPPHTTPLIB_OPENSSL_SUPPORT
#include "cpp-httplib-master/httplib.h"
#include <iostream>

int main(void)
{
	httplib::Client cli("localhost", 1234);

	if (auto res = cli.Get("/hi")) {
    	if (res->status == 200) {
			std::cout << res->body << std::endl;
		}
	} else {
		auto err = res.error();
		std::cout << "HTTP error: " << httplib::to_string(err) << std::endl;
  	}
}