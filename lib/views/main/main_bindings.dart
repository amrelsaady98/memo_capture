import 'package:get/get.dart';
import 'package:memo_capture/core/providers/memory_provide.dart';
import 'package:memo_capture/core/providers/tag_provider.dart';
import 'package:memo_capture/core/services/local_services/app_database.dart';
import 'package:memo_capture/views/main/main_controller.dart';
import 'package:memo_capture/views/search/search_controller.dart';

class MainBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(MemoryProvider(
      Get.find<AppDatabase>().memoryDao,
      Get.find<AppDatabase>().memoryTagDao,
    ));
    // Get.put(AppSearchController(
    //   Get.find<MemoryProvider>(),
    //   {},
    // ));
    Get.lazyPut(() => TagProvider(Get.find<AppDatabase>().tagDoa));
    Get.lazyPut(() => MainController());
  }
}
