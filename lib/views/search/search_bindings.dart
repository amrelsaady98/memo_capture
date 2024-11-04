import 'package:get/get.dart';
import 'package:memo_capture/core/providers/memory_provide.dart';
import 'package:memo_capture/core/services/local_services/app_database.dart';
import 'package:memo_capture/views/search/search_controller.dart';

class SearchBindings extends Bindings {
  final Map<String, dynamic> arguments;

  SearchBindings({required this.arguments});
  @override
  void dependencies() {
    
    Get.put(MemoryProvider(
      Get.find<AppDatabase>().memoryDao,
      Get.find<AppDatabase>().memoryTagDao,
    ));
    Get.put(AppSearchController(
      Get.find<MemoryProvider>(),
      arguments,
    ));
  }
}
