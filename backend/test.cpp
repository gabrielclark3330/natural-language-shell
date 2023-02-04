#define CPPHTTPLIB_OPENSSL_SUPPORT
#include "cpp-httplib-master/httplib.h"
#include <iostream>

int main(void)
{
  httplib::Client cli("https://api.ipify.org?format=json");

  if (auto res = cli.Get("")) {
    if (res->status == 200) {
      std::cout << res->body << std::endl;
    }
  } else {
    auto err = res.error();
    std::cout << "HTTP error: " << httplib::to_string(err) << std::endl;
  }
}