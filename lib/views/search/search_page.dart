import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:memo_capture/configs/routes/app_routes.dart';
import 'package:memo_capture/configs/theme/colors.dart';
import 'package:memo_capture/configs/theme/font_styles.dart';
import 'package:memo_capture/views/search/search_controller.dart';
import 'package:memo_capture/views/shared/layouts.dart';

class SearchPage extends GetView<AppSearchController> {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      pageTitle: '',
      leadingIconAsset: 'assets/icons/icon-layout.png',
      leadingOnClick: () => Get.offAndToNamed(AppRoutes.HOME_PAGE, id: 2),
      bodyChildern: [
        Container(
          width: double.infinity,
          height: 92,
          color: AppColors.light_color,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Showing results for:',
                style: AppFontStyles.caption,
              ),
              const SizedBox(height: 6),
              Text(
                '“Lady Art”',
                style: AppFontStyles.button.copyWith(fontSize: 28),
              ),
            ],
          ),
        ),
        Obx(
          () => Container(
            alignment: AlignmentDirectional.center,
            child: GridView.custom(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              gridDelegate: SliverQuiltedGridDelegate(
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                repeatPattern: QuiltedGridRepeatPattern.inverted,
                pattern: const [
                  QuiltedGridTile(3, 2),
                  QuiltedGridTile(2, 2),
                  QuiltedGridTile(3, 2),
                  QuiltedGridTile(2, 2),
                  QuiltedGridTile(2, 4),
                  QuiltedGridTile(3, 2),
                  QuiltedGridTile(3, 2),
                  QuiltedGridTile(2, 4),
                ],
              ),
              childrenDelegate: SliverChildBuilderDelegate(
                childCount: controller.savedMemos.length,
                (context, index) {
                  GlobalKey key = GlobalKey(debugLabel: 'image-$index');
                  return Stack(
                    fit: StackFit.loose,
                    children: [
                      GestureDetector(
                        onTap: () => controller.onImageTaped(
                            key, controller.savedMemos[index]),
                        child: ClipRRect(
                          key: key,
                          borderRadius: BorderRadius.circular(6),
                          child: Image.file(
                            File(controller.savedMemos[index].imagePath),
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 24,
                        left: 12,
                        child: GestureDetector(
                          onTap: () => controller.onFavtapped(index),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.dark_color.withOpacity(0.5),
                            ),
                            child: Image.asset(
                              controller.savedMemos[index].isFavourite
                                  ? 'assets/icons/icon-heart-filled.png'
                                  : 'assets/icons/icon-heart.png',
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
