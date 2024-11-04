import 'dart:io';

import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memo_capture/core/models/memory.dart';
import 'package:memo_capture/configs/routes/app_routes.dart';
import 'package:memo_capture/configs/theme/colors.dart';
import 'package:memo_capture/configs/theme/font_styles.dart';
import 'package:memo_capture/views/add_memo/add_memo_widgets.dart';
import 'package:memo_capture/views/add_memo/add_memory_controller.dart';
import 'package:memo_capture/views/shared/buttons.dart';
import 'package:memo_capture/views/shared/inputs.dart';
import 'package:memo_capture/views/shared/layouts.dart';

class AddMemoryPage extends GetView<AddMemoryController> {
  const AddMemoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      pageTitle: 'Add an Entry',
      leadingIconAsset: 'assets/icons/icon-layout.png',
      leadingOnClick: () => Get.offAndToNamed(AppRoutes.HOME_PAGE, id: 2),
      bodyChildern: [
        Obx(
          () => Container(
            height: 200,
            width: MediaQuery.of(context).size.width - 48,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.light_color,
              borderRadius: BorderRadius.circular(12),
              image: controller.imagePath?.value != null
                  ? DecorationImage(
                      image: FileImage(
                        File(controller.imagePath!.value!),
                      ),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => controller.onAddImagePressed(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    decoration: const BoxDecoration(
                      color: AppColors.bright_color,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/icons/icon-upload.png',
                      height: 18,
                      width: 18,
                      color: AppColors.white_color,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Tap To Add new Memo',
                  style: AppFontStyles.caption,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: AppTextField(
            label: 'Title',
            onTextChanged: (value) {
              controller.memotitle.value = value;
              print('changed value: $value');
              print('controller value: ${controller.memotitle?.value}');
            },
          ),
        ),
        Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: AppTextField(
              label: 'Date',
              hint: controller.memoDateView.value,
              onTextChanged: (value) {},
              icon: Container(
                margin: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () => controller.onDateIconPressed(context),
                  child: const CustomIconButton(
                    height: 36,
                    width: 36,
                    asset: 'assets/icons/icon-calender.png',
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Obx(
            () => AddMemoMediumExpantionTile(
              title: controller.selectedMediumTitle.value ?? "Select Medium",
              icon: const CustomIconButton(
                height: 36,
                width: 36,
                asset: 'assets/icons/icon-arrow-down.png',
              ),
              mediumItems: controller.meduimItems.value,
              onItemSelected: (index) => controller.onMeduimItemPressed(index),
              footerItem: GestureDetector(
                onTap: () => controller.onAddMediumPressed(),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      CustomIconButton(
                        height: 36,
                        width: 36,
                        asset: 'assets/icons/icon-layout.png',
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Add medium',
                        style: AppFontStyles.link,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Obx(
            () => AddMemoTagExpantionTile(
              title: controller.selectedTagTitle.value ?? "Select Tags",
              icon: const CustomIconButton(
                height: 36,
                width: 36,
                asset: 'assets/icons/icon-arrow-down.png',
              ),
              mediumItems: controller.tagItems.value,
              onItemSelected: (index) => controller.onTagItemPressed(index),
              footerItem: GestureDetector(
                onTap: () => controller.onAddTagPressed(),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      CustomIconButton(
                        height: 36,
                        width: 36,
                        asset: 'assets/icons/icon-layout.png',
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Add TAG',
                        style: AppFontStyles.link,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: AppTextField(
            label: "Description",
            onTextChanged: (value) => controller.memoDescription.value = value,
            isMultiLine: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: FilledButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(AppColors.bright_color),
            ),
            onPressed: () => controller.onAddEntryPressed(),
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                alignment: AlignmentDirectional.center,
                child: Text(
                  'Add Entry',
                  style: AppFontStyles.button
                      .copyWith(color: AppColors.white_color),
                )),
          ),
        ),
      ],
    );
  }
}
