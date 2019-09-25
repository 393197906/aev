import 'package:aev/fetch/Fetch.dart';
import 'package:aev/fetch/YcError.dart';
import 'package:aev/fetch/middleware.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:aev/aev.dart';

void main() {
  final token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiIiLCJhdWQiOiIiLCJpYXQiOjE1NjkzNzA4OTYsImV4cCI6MTU3MTk2Mjg5NiwibmJmIjoxMzU3MDAwMDAwLCJqdGkiOiIzOEZEODRFREUwMjRCQjNFMzgyNjQxODQ0NjlCMjk5NCIsImlkIjoxNTUsIm9wZW5faWQiOiI3NDUxMDY0MzI4QjA0RjQ0NzVENUZGRUY3RkUxNEZBNyIsInBsYXRmb3JtX2luZm8iOnsic3lzX21hcmsiOiJiYmMiLCJ1c2VyX2lkIjoxNTUsInBob25lIjoiMTg4NTQwNjI5ODAiLCJ1c2VybmFtZSI6bnVsbH0sInNob3BfaW5mbyI6W119.LRthhbyyRx1xi8UPavb17GEjnYsGRlPrXNpvdqfDlVI";
  Fetch fetch = Fetch(enableLog: false, middlewares: [
    (next) {
      return (FetchOptions options) {
        options.headers = {"Authorization": token};
        return next(options);
      };
    },
    ycFilter((YcError error) {
      print(error);
    }),
  ]);

  test("post base", () async {
    final url = "https://oms.91youxian.com/loginController/login";
    var a = await fetch
        .post(url, {"userName": "18854062980", "passWord": "123456"});
    expect(a is Map, true);
    expect(a['phone'], "18854062980");
  });

  test("get base", () async {
    final url =
        "https://baseinfo.youxianvip.com/userCenter/supplier/statistics";
    var a = await fetch.get(url);
    expect(a is List, true);
  });
}
