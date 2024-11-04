import 'package:get/get.dart';
import 'package:memo_capture/views/settings/settings_controller.dart';

class SettingsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController());
  }
}
