import 'package:get/get.dart';
import 'package:memo_capture/views/login/login_controller.dart';

class LoginBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}