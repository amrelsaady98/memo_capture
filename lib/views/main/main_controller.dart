import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:memo_capture/configs/routes/app_routes.dart';
import 'package:memo_capture/core/models/memory.dart';
import 'package:memo_capture/core/models/tag.dart';
import 'package:memo_capture/core/providers/memory_provide.dart';
import 'package:memo_capture/core/providers/tag_provider.dart';
import 'package:memo_capture/views/add_memo/add_memory_page.dart';
import 'package:memo_capture/views/add_memo/add_memory_bindings.dart';
import 'package:memo_capture/views/memo_details/memo_details_bindings.dart';
import 'package:memo_capture/views/memo_details/memo_details_page.dart';
import 'package:memo_capture/views/search/search_bindings.dart';
import 'package:memo_capture/views/search/search_controller.dart';
import 'package:memo_capture/views/search/search_page.dart';
import 'package:memo_capture/views/settings/settings_bindings.dart';
import 'package:memo_capture/views/settings/settings_page.dart';

import '../home/home_bindings.dart';
import '../home/home_page.dart';

class MainController extends GetxController {
  late TagProvider _tagProvider;
  late MemoryProvider _memoryProvider;

  GlobalKey menuButtonKey = GlobalKey(debugLabel: 'add-button');
  GlobalKey searchButtonKey = GlobalKey(debugLabel: 'search-button');

  Rxn<Offset> tappedImageOffset = Rxn<Offset>(Offset.zero);
  Rxn<Size> tappedImageSize = Rxn<Size>(Size.zero);
  Rxn<Size?> tappedImageActualSize = Rxn<Size?>();
  Rxn<Memory> tappedImageMemory = Rxn<Memory>();

  RxBool isMenuOpen = RxBool(false);
  RxBool isSearchOpen = RxBool(false);
  RxBool isImageOpen = RxBool(false);

  Rxn<Offset> maskOffset = Rxn<Offset>(Offset.zero);
  RxnDouble maskHoleRadius = RxnDouble(0);

  bool getPlaceMask() =>
      isMenuOpen.value || isSearchOpen.value || isImageOpen.value;

  RxList<TagItem> searchTagItems = RxList();

  @override
  void onInit() async {
    super.onInit();
    _tagProvider = Get.find<TagProvider>();
    _memoryProvider = Get.find<MemoryProvider>();
  }

  onButtonPressed(RxBool observable, GlobalKey key) {
    bool currentValue = observable.value;
    observable.value = !currentValue;
    if (observable.value) {
      RenderBox box = key.currentContext?.findRenderObject() as RenderBox;
      Offset position = box.localToGlobal(Offset.zero);
      maskOffset.value = position;
      maskHoleRadius.value = box.size.longestSide / 2;
    } else {
      maskOffset.value = Offset.zero;
      maskHoleRadius.value = 0;
    }
  }

  void onSearchButtonPreesed(RxBool observable, GlobalKey key) {
    onButtonPressed(observable, key);
    _tagProvider.getAllTagItems().then((value) {
      searchTagItems.clear();
      searchTagItems.addAll(value);
    });
  }

  Route? onGenerateRoute(RouteSettings settings) {
    print(settings.toString());
    if (settings.name == AppRoutes.HOME_PAGE) {
      return GetPageRoute(
        settings: settings,
        page: () => HomePage(),
        binding: HomeBindings(),
        transition: Transition.fadeIn,
      );
    }
    if (settings.name == AppRoutes.MEMORY_DETAILS) {
      return GetPageRoute(
        settings: settings,
        page: () => const MemoDetailsPage(),
        binding: MemoDetailsBindings(
            memoId:
                (settings.arguments as Map<String, dynamic>?)?['memo_id'] ?? 0),
        transition: Transition.rightToLeft,
      );
    }
    if (settings.name == AppRoutes.ADD_MEMORY_PAGE) {
      return GetPageRoute(
        settings: settings,
        page: () => const AddMemoryPage(),
        binding: AddMemoryBindings(),
        transition: Transition.fadeIn,
      );
    }
    if (settings.name == AppRoutes.SETTINGS) {
      return GetPageRoute(
        settings: settings,
        page: () => SettingsPage(),
        binding: SettingsBindings(),
      );
    }
    if (settings.name == AppRoutes.SEARCH_PAGE) {
      return GetPageRoute(
        settings: settings,
        page: () => SearchPage(),
        binding: SearchBindings(
            arguments: settings.arguments as Map<String, dynamic>),
      );
    }

    return null;
  }

  void onSearchTagPressed(int index) async {
    isSearchOpen.value = false;
    // Get.put(AppSearchController(Get.find<MemoryProvider>(),
    //     {"type": 'tag', 'value': searchTagItems[index].id}));
    print(Get.currentRoute);

    Get.toNamed(
      AppRoutes.SEARCH_PAGE,
      id: 2,
      arguments: {"type": 'tag', 'value': searchTagItems[index].id},
    );
    Get.find<AppSearchController>().savedMemos.clear();
    Get.find<AppSearchController>().savedMemos.addAll(
        await _memoryProvider.getMemoryByTag(searchTagItems[index].id ?? 0));
  }

  void onSettingsPressed() {
    isMenuOpen.value = false;
    Get.toNamed(
      AppRoutes.SETTINGS,
      id: 2,
    );
  }
}
