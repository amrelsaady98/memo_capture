import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:memo_capture/configs/routes/app_routes.dart';
import 'package:memo_capture/configs/theme/colors.dart';
import 'package:memo_capture/configs/theme/font_styles.dart';
import 'package:memo_capture/core/models/memory.dart';
import 'package:memo_capture/views/memo_details/memo_details_controller.dart';
import 'package:memo_capture/views/shared/buttons.dart';
import 'package:memo_capture/views/shared/layouts.dart';

class MemoDetailsPage extends GetView<MemoDetailsController> {
  const MemoDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final message = Get.arguments;
    print(message);
    return PageLayout(
      pageTitle: '',
      leadingIconAsset: 'assets/icons/icon-layout.png',
      leadingOnClick: () => Get.offAndToNamed(AppRoutes.HOME_PAGE, id: 2),
      bodyChildern: <Widget>[
        Obx(
          () => Container(
            child: (controller.memoryItem.value != null)
                ? Image.file(File(controller.memoryItem.value?.imagePath ?? ''))
                : Text(controller.memoryItem.toString()),
          ),
        ),
        SizedBox(height: 24),
        Obx(
          () {
            Memory? item = controller.memoryItem.value;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item?.title ?? '',
                        style: AppFontStyles.header_1,
                      ),
                      Text(
                        '${DateFormat('MMM dd').format((DateTime.fromMillisecondsSinceEpoch(item?.dateTime ?? 0)) ?? DateTime.now())}  •  ${item?.medium}',
                        style: AppFontStyles.caption,
                      )
                    ],
                  ),
                  GestureDetector(
                    child: Image.asset(
                      (item?.isFavourite ?? false)
                          ? 'assets/icons/icon-heart-filled.png'
                          : 'assets/icons/icon-heart.png',
                      width: 18,
                      height: 24,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 24),
        Obx(
          () => Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            width: double.infinity,
            child: Wrap(
              spacing: 8,
              alignment: WrapAlignment.start,
              children: [
                ...(controller.memoryTags
                    .map(
                      (item) => Chip(
                        // onPressed: () {},
                        visualDensity: VisualDensity.compact,
                        label: Text('${item.name.toUpperCase()}'),
                        labelStyle: const TextStyle(
                            letterSpacing: 3, color: AppColors.text_color),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 0,
                        ),
                        color: MaterialStateProperty.all(
                          AppColors.light_color,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                          side: const BorderSide(color: Colors.transparent),
                        ),
                      ),
                    )
                    .toList()),
                ActionChip(
                  onPressed: () {},
                  visualDensity: VisualDensity.compact,
                  label: Text('+'),
                  labelStyle: const TextStyle(
                      fontSize: 18,
                      letterSpacing: 3,
                      color: AppColors.text_color),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 0,
                  ),
                  color: MaterialStateProperty.all(
                    AppColors.dark_50_color.withOpacity(0.3),
                  ),
                  shape: const CircleBorder(
                    side: BorderSide(color: Colors.transparent),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Obx(
          () => Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              controller.memoryItem.value?.description ?? '',
              style: AppFontStyles.caption.copyWith(fontSize: 20),
            ),
          ),
        ),
        const SizedBox(height: 24)
      ],
    );
  }
}

class MemoryItem {}
