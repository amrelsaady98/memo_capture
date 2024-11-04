import 'package:get/get.dart';
import 'package:memo_capture/core/models/memory.dart';
import 'package:memo_capture/core/models/tag.dart';
import 'package:memo_capture/core/providers/memory_provide.dart';
import 'package:memo_capture/core/providers/tag_provider.dart';

class MemoDetailsController extends GetxController {
  final int memoId;

  late MemoryProvider _memoryProvider;
  late TagProvider _tagProvider;

  Rxn<Memory> memoryItem = Rxn<Memory>();
  RxList<TagItem> memoryTags = RxList();

  MemoDetailsController({required this.memoId});

  @override
  void onInit() async {
    super.onInit();
    _memoryProvider = Get.find<MemoryProvider>();
    _tagProvider = Get.find<TagProvider>();
    memoryItem.value = await _memoryProvider.getMemoryById(memoId);
    memoryTags.value = await _tagProvider.getMemoryTags(memoId);
    print(memoId);
    print(memoryTags.toString());
  }
}
