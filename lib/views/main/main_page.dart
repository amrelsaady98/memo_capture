import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:memo_capture/main.dart';
import 'package:memo_capture/configs/routes/app_routes.dart';
import 'package:memo_capture/configs/theme/colors.dart';
import 'package:memo_capture/configs/theme/font_styles.dart';
import 'package:memo_capture/views/home/home_page.dart';
import 'package:memo_capture/views/main/main_controller.dart';
import 'package:memo_capture/views/main/main_page_widgets.dart';
import 'package:memo_capture/views/shared/buttons.dart';

class MainPage extends GetView<MainController> {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.getPlaceMask()) {
          controller.isMenuOpen.value = false;
          controller.isSearchOpen.value = false;
          controller.isImageOpen.value = false;
          //TODO: close dialog
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Scaffold(
              body: Obx(
                () => Stack(
                  children: [
                    SafeArea(
                      child: IgnorePointer(
                        ignoring: controller.getPlaceMask() &&
                            !controller.isImageOpen.value,
                        child: Navigator(
                          key: Get.nestedKey(2),
                          initialRoute: AppRoutes.HOME_PAGE,
                          // pages: AppRoutes.GET_PAGES,
                          onGenerateRoute: (settings) =>
                              controller.onGenerateRoute(settings),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: controller.getPlaceMask(),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 5,
                          sigmaY: 5,
                        ),
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Obx(
                () => Container(
                  height: 64,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IgnorePointer(
                        ignoring: controller.getPlaceMask() &&
                            !controller.isSearchOpen.value,
                        child: GestureDetector(
                          onTap: () => controller.onSearchButtonPreesed(
                            controller.isSearchOpen,
                            controller.searchButtonKey,
                          ),
                          child: CustomIconButton(
                            key: controller.searchButtonKey,
                            height: 48,
                            width: 48,
                            asset: 'assets/icons/icon-search.png',
                            gridsColor: controller.isSearchOpen.value
                                ? Colors.transparent
                                : null,
                          ),
                        ),
                      ),
                      IgnorePointer(
                        ignoring: controller.getPlaceMask(),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.bright_color,
                            shape: BoxShape.circle,
                          ),
                          child: GestureDetector(
                            onTap: () => Get.offAndToNamed(
                                AppRoutes.ADD_MEMORY_PAGE,
                                id: 2),
                            child: Image.asset(
                              'assets/icons/icon-add.png',
                              height: 36,
                              width: 36,
                              color: AppColors.white_color,
                            ),
                          ),
                        ),
                      ),
                      IgnorePointer(
                        ignoring: controller.getPlaceMask() &&
                            !controller.isMenuOpen.value,
                        child: GestureDetector(
                          onTap: () => controller.onButtonPressed(
                              controller.isMenuOpen, controller.menuButtonKey),
                          child: CustomIconButton(
                            key: controller.menuButtonKey,
                            height: 48,
                            width: 48,
                            asset: 'assets/icons/icon-menu.png',
                            gridsColor: controller.isMenuOpen.value
                                ? Colors.transparent
                                : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // background overlay mask
            Obx(
              () => AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: controller.getPlaceMask() ? 1 : 0,
                child: ScreenOverlayMask(
                  offset: controller.maskOffset.value!,
                  radius: controller.maskHoleRadius.value!,
                ),
              ),
            ),
            // search layout
            Obx(() {
              return Visibility(
                visible: controller.isSearchOpen.value,
                child: Material(
                  type: MaterialType.transparency,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          TextField(
                            cursorColor: AppColors.white_color,
                            decoration: InputDecoration(
                              hintText: "Search titles, tags, dates, media...",
                              hintStyle: AppFontStyles.caption.copyWith(
                                  color: AppColors.light_color, fontSize: 16),
                              contentPadding: const EdgeInsets.all(12),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.white_color, width: 1),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.white_color, width: 1),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "My Favourites".toUpperCase(),
                                      style: AppFontStyles.link.copyWith(
                                        color: AppColors.white_color,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    const CustomIconButton(
                                      asset:
                                          'assets/icons/icon-heart-filled.png',
                                      height: 44,
                                      width: 44,
                                    )
                                  ],
                                ),
                                const SizedBox(height: 28),
                                ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () =>
                                          controller.onSearchTagPressed(index),
                                      child: Text(
                                        controller.searchTagItems[index].name
                                            .toUpperCase(),
                                        style: AppFontStyles.link.copyWith(
                                          color: AppColors.white_color,
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (_, __) => const SizedBox(
                                    height: 36,
                                  ),
                                  itemCount: controller.searchTagItems.length,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
            // menu layout
            Obx(
              () {
                if (!controller.isMenuOpen.value) {
                  return Container();
                }
                return Visibility(
                  visible: controller.isMenuOpen.value,
                  child: Positioned(
                    bottom: MediaQuery.sizeOf(context).height -
                        (controller.menuButtonKey.currentContext
                                ?.findRenderObject() as RenderBox)
                            .localToGlobal(Offset.zero)
                            .dy +
                        12,
                    right: MediaQuery.sizeOf(context).width -
                        (controller.menuButtonKey.currentContext
                                ?.findRenderObject() as RenderBox)
                            .localToGlobal(Offset.zero)
                            .dx -
                        (controller.menuButtonKey.currentContext
                                    ?.findRenderObject() as RenderBox)
                                .size
                                .width *
                            1.5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 24,
                      ),
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.white_color,
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () => controller.onSettingsPressed(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Text('SETTINGS',
                                        style: AppFontStyles.link),
                                    const SizedBox(width: 8),
                                    Image.asset(
                                      'assets/icons/icon-settings-bright.png',
                                      width: 16,
                                      height: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text('ACCOUNT',
                                      style: AppFontStyles.link),
                                  const SizedBox(width: 8),
                                  Image.asset(
                                    'assets/icons/icon-person-bright.png',
                                    width: 16,
                                    height: 16,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text('ABOUT',
                                      style: AppFontStyles.link),
                                  const SizedBox(width: 8),
                                  Image.asset(
                                    'assets/icons/icon-about.png',
                                    width: 16,
                                    height: 16,
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ),
                );
              },
            ), // image layout
            // image layout
            Obx(
              () {
                final screenSize = MediaQuery.of(context).size;
                Offset centerOffset = Offset(
                  screenSize.width / 2 -
                      controller.tappedImageSize.value!.width / 2,
                  screenSize.height / 2 -
                      (((controller.tappedImageSize.value?.width ?? 0) /
                              (controller.tappedImageActualSize.value?.width ??
                                  1) *
                              (controller.tappedImageActualSize.value?.height ??
                                  0))) /
                          2,
                );
                if (!controller.isImageOpen.value) {
                  return Container();
                }
                return Visibility(
                  visible: controller.isImageOpen.value,
                  child: SizedBox(
                    width: screenSize.width,
                    height: screenSize.height,
                    child: Stack(
                      children: [
                        TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: 0, end: 100),
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInBack,
                            builder: (context, value, child) {
                              return Transform.translate(
                                offset: Offset(
                                  (controller.tappedImageOffset.value!.dx *
                                          (100 - value) /
                                          100 +
                                      centerOffset.dx * (value) / 100),
                                  (controller.tappedImageOffset.value!.dy *
                                          (100 - value) /
                                          100 +
                                      centerOffset.dy * (value) / 100),
                                ),
                                child: Transform.scale(
                                  scale: (controller
                                              .tappedImageSize.value!.width <
                                          MediaQuery.of(context).size.width *
                                              0.6)
                                      ? 0.5 * value / 100 + 1
                                      : 1,
                                  child: SizedBox(
                                    width:
                                        controller.tappedImageSize.value?.width,
                                    height: controller
                                                .tappedImageSize.value!.height *
                                            (100 - value) /
                                            100 +
                                        ((controller.tappedImageSize.value
                                                        ?.width ??
                                                    0) /
                                                (controller
                                                        .tappedImageActualSize
                                                        .value
                                                        ?.width ??
                                                    1) *
                                                (controller
                                                        .tappedImageActualSize
                                                        .value
                                                        ?.height ??
                                                    0)) *
                                            value /
                                            100,
                                    child: ClipRRect(
                                      key: key,
                                      borderRadius: BorderRadius.circular(6),
                                      child: Image.file(
                                        File(controller.tappedImageMemory.value!
                                            .imagePath),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                        Positioned(
                          top: screenSize.height - 150,
                          left: (screenSize.width - 240) / 2,
                          child: SizedBox(
                            width: 240,
                            height: 36,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'More Info',
                                  style: TextStyle(
                                    color: AppColors.white_color,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print(
                                        'before: ${controller.tappedImageMemory.value?.id}');
                                    controller.isImageOpen.value = false;
                                    Get.toNamed(
                                      AppRoutes.MEMORY_DETAILS,
                                      id: 2,
                                      arguments: {
                                        'memo_id': controller
                                                .tappedImageMemory.value?.id ??
                                            3
                                      },
                                    );
                                  },
                                  child: Image.asset(
                                    'assets/icons/icon-arrow-right.png',
                                    width: 36,
                                    height: 36,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 64,
                          left: screenSize.width - 64,
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.dark_color,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.taupe_color,
                                        blurRadius: 8,
                                        spreadRadius: -2,
                                      )
                                    ]),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    controller.isImageOpen.value = false;
                                  },
                                  child: const CustomIconButton(
                                    asset: 'assets/icons/icon-close-light.png',
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            /* Obx(
              () {
                return Visibility(
                  visible: controller.isSearchOpen.value,
                  child: Material(
                    type: MaterialType.transparency,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 36, vertical: 300),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 12),
                            suffixIcon: Container(
                              width: 64,
                              height: 48,
                              padding: const EdgeInsets.all(12),
                              decoration: const BoxDecoration(
                                color: AppColors.bright_color,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8)),
                              ),
                              child: Image.asset(
                                'assets/icons/icon-search.png',
                                color: Colors.white,
                                height: 12,
                                width: 12,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ), */
          ],
        ),
      ),
    );
  }
}
