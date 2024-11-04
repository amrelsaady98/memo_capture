import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_capture/core/models/memory.dart';
import 'package:memo_capture/core/providers/memory_provide.dart';
import 'package:memo_capture/views/main/main_controller.dart';

class AppSearchController extends GetxController {
  final Map<String, dynamic> arguments;

  AppSearchController(this._memoryProvider, this.arguments);

  final mainController = Get.find<MainController>();

  Rxn<Offset> maskOffset = Rxn<Offset>(Offset.zero);
  RxnDouble maskHoleRadius = RxnDouble(0);

  RxList<Memory> savedMemos = RxList();

  final MemoryProvider _memoryProvider;

  @override
  void onInit() async {
    super.onInit();
    if (arguments['type'] != null && arguments['type'] == 'tag') {
      //TODO: get memo's by tag id
      savedMemos
          .addAll(await _memoryProvider.getMemoryByTag(arguments['value']));
      print('Tag id: ${arguments['value']}');
      print(savedMemos.toString());
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    savedMemos.clear();
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
