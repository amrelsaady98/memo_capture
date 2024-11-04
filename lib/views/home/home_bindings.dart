import 'package:get/get.dart';
import 'package:memo_capture/core/providers/memory_provide.dart';
import 'package:memo_capture/core/services/local_services/app_database.dart';
import 'package:memo_capture/views/home/home_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(MemoryProvider(
      Get.find<AppDatabase>().memoryDao,
      Get.find<AppDatabase>().memoryTagDao,
    ));
    Get.lazyPut(() => HomeController(Get.find<MemoryProvider>()));
  }
}
