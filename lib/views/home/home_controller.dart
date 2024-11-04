import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:memo_capture/core/models/memory.dart';
import 'package:memo_capture/core/providers/memory_provide.dart';
import 'package:memo_capture/views/main/main_controller.dart';

class HomeController extends GetxController {
  HomeController(this._memoryProvider);

  final mainController = Get.find<MainController>();

  Rxn<Offset> maskOffset = Rxn<Offset>(Offset.zero);
  RxnDouble maskHoleRadius = RxnDouble(0);

  RxList<Memory> savedMemos = RxList([]);

  final MemoryProvider _memoryProvider;

  @override
  void onInit() async {
    super.onInit();
    savedMemos.addAll(await _memoryProvider.getAllMemoryItems());
    print('Home onInit Called ');
  }

  // @override
  // void onReady() async {
  //   super.onReady();
  //   savedMemos.clear();
  //   print('Home onReady Called ');
  // }

  onButtonPressed(RxBool observable, GlobalKey key) {
    bool currentValue = observable.value;
    observable.value = !currentValue;
    if (observable.value) {
      RenderBox box = key.currentContext?.findRenderObject() as RenderBox;
      Offset position = box.localToGlobal(Offset.zero);
      maskOffset.value = position;
      maskHoleRadius.value = box.size.longestSide / 2;
    }
  }

  void onImageTaped(GlobalKey imageKey, Memory memory) {
    RenderBox box = imageKey.currentContext?.findRenderObject() as RenderBox;

    mainController.tappedImageOffset.value = box.localToGlobal(Offset.zero);
    mainController.tappedImageSize.value = box.size;

    mainController.tappedImageMemory.value = memory;

    mainController.isImageOpen.value = !mainController.isImageOpen.value;

    getImageSize(memory.imagePath)
        .then((value) => mainController.tappedImageActualSize.value = value);
  }

  Future<Size> getImageSize(String assetPath) async {
    // Load the image from the asset bundle
    // final ByteData data = await File(assetPath).readAsBytes();
    final Uint8List bytes = await File(assetPath).readAsBytes();

    // Instantiate the image codec
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();

    // Get the image size
    final ui.Image image = frameInfo.image;
    return Size(image.width.toDouble(), image.height.toDouble());
  }

  onFavtapped(int index) {
    savedMemos[index].isFavourite = !savedMemos[index].isFavourite;
    savedMemos.refresh();
    _memoryProvider.updateMemory(savedMemos[index]);
  }
}
