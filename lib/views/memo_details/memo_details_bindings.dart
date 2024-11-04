import 'package:get/get.dart';
import 'package:memo_capture/core/providers/memory_provide.dart';
import 'package:memo_capture/core/providers/tag_provider.dart';
import 'package:memo_capture/core/services/local_services/app_database.dart';
import 'package:memo_capture/views/memo_details/memo_details_controller.dart';

class MemoDetailsBindings extends Bindings {
  final int memoId;

  MemoDetailsBindings({required this.memoId});

  @override
  void dependencies() async {
    Get.lazyPut(() => MemoryProvider(
          Get.find<AppDatabase>().memoryDao,
          Get.find<AppDatabase>().memoryTagDao,
        ));
    Get.lazyPut(() => TagProvider(Get.find<AppDatabase>().tagDoa));
    Get.lazyPut(() => MemoDetailsController(memoId: memoId));
  }
}
