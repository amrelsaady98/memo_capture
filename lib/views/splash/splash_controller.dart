import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:memo_capture/configs/routes/app_routes.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  late Rxn<AnimationController> _logoAnimationController =
      Rxn<AnimationController>();

  AnimationController? get logoAnimationController =>
      _logoAnimationController.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initAnimationConfig();
    Future.delayed(const Duration(milliseconds: 2000)).then((value) {
      print('animation started');
      logoAnimationController
          ?.forward()
          .then((value) => Get.offAllNamed(AppRoutes.MAIN_PAGE));
    });
  }

  void initAnimationConfig() {
    _logoAnimationController.value = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      lowerBound: 0,
      upperBound: 10,
    );
  }

  @override
  void onClose() {
    _logoAnimationController.value?.dispose();
    super.onClose();
  }
}
