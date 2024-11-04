import 'package:get/get.dart';
import 'package:memo_capture/core/providers/medium_provider.dart';
import 'package:memo_capture/core/providers/memory_provide.dart';
import 'package:memo_capture/core/providers/tag_provider.dart';
import 'package:memo_capture/core/services/local_services/app_database.dart';
import 'package:memo_capture/views/add_memo/add_memory_controller.dart';

class AddMemoryBindings extends Bindings {
  @override
  void dependencies() async {
    Get.put(MediumProvider(Get.find<AppDatabase>().meduimDao));
    Get.put(TagProvider(Get.find<AppDatabase>().tagDoa));
    Get.put(MemoryProvider(
      Get.find<AppDatabase>().memoryDao,
      Get.find<AppDatabase>().memoryTagDao,
    ));
    Get.lazyPut(() => AddMemoryController(Get.find<MemoryProvider>()));
  }
}
