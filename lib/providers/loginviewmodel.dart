import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/api_service.dart';

class LoginViewModel with ChangeNotifier {
  String errorMessage = "";
  int status = 0; //  0- not login/ 1 - waiting/ 2 - error/ 3 - login
  final api = ApiService();
  Future<void> login(String username, String password) async {
    status = 1;
    notifyListeners();
    try {
      var response = await api.loginUser(username, password);
      if (response == null) {
        status = 2;
        errorMessage = "Username or Password not Correct!";
      } else {
        status = 3;
      }
      notifyListeners();
    } catch (e) {
      print("Lỗi khi đăng nhập: $e");
      status = 2;
      errorMessage = "Đã xảy ra lỗi khi đăng nhập.";
    }
  }
}
