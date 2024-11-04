import 'package:get/get.dart';

import 'cash_manager.dart';

class AuthManager extends GetxController with CacheManager {
  RxBool isLogged = false.obs;

  void login(String token) async {
    await saveToken(token);

    /// token is cached then update ui
    isLogged.value = true;
  }

  void logout() async {
    await removeToken();
    isLogged.value = false;
  }

  bool checkLoginStatus()  {
    final token = getToken();
    if (token == null) {
      return false;
    } else {
      return true;
    }
  }
}
