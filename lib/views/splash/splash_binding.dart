import 'package:get/get.dart';
import 'package:memo_capture/views/splash/splash_controller.dart';

class SplashBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }

}