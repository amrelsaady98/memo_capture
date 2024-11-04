import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:memo_capture/configs/routes/app_routes.dart';
import 'package:memo_capture/core/models/medium.dart';
import 'package:memo_capture/core/models/memory.dart';
import 'package:memo_capture/core/models/tag.dart';
import 'package:memo_capture/core/providers/medium_provider.dart';
import 'package:memo_capture/core/providers/memory_provide.dart';
import 'package:memo_capture/core/providers/tag_provider.dart';
import 'package:memo_capture/core/services/local_services/medium_dao.dart';
import 'package:memo_capture/configs/theme/colors.dart';
import 'package:memo_capture/configs/theme/font_styles.dart';
import 'package:memo_capture/core/services/stroage_service.dart';
import 'package:memo_capture/views/shared/inputs.dart';
import 'package:path_provider/path_provider.dart';

class AddMemoryController extends GetxController {
  AddMemoryController(this._memoryProvider);

  RxnString memotitle = RxnString();
  DateTime? memoDate;
  RxnString imagePath = RxnString();

  late RxString memoDateView;
  RxList<String>? memoMeduim;

  RxList<MediumItem> meduimItems = RxList<MediumItem>([]);
  RxnString selectedMediumTitle = RxnString();

  RxList<TagItem> tagItems = RxList<TagItem>([]);
  RxList<int> selectedTagsIds = RxList<int>([]);
  RxnString selectedTagTitle = RxnString();

  RxnString memoDescription = RxnString();

  final MediumProvider _mediumProvider = Get.find();
  final TagProvider _tagProvider = Get.find();

  String? _newMediumTitle;
  String? _newTagTitle;

  late StorageServices _storageServices;
  final MemoryProvider _memoryProvider;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initData();
    memoDateView = RxString(DateFormat("MMMM, dd yyyy").format(DateTime.now()));
    _storageServices = Get.put(StorageServices());
  }

  void initData() async {
    final localMediumData = await _mediumProvider.getAllMediumItems();
    final localTagData = await _tagProvider.getAllTagItems();
    meduimItems.clear();
    meduimItems.addAll(localMediumData);
    tagItems.clear();
    tagItems.addAll(localTagData);
    tagItems.refresh();
    meduimItems.refresh();
  }

  void onAddImagePressed() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      imagePath?.value = image.path;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void onMeduimItemPressed(int index) {
    bool selected = meduimItems[index].isSelected;

    for (var item in meduimItems) {
      item.isSelected = false;
    }
    meduimItems[index].isSelected = !selected;

    selectedMediumTitle.value = meduimItems[index].name;

    meduimItems.refresh();
  }

  void onTagItemPressed(int index) {
    bool selected = tagItems[index].isSelected;

    int selectedTagCount = 0;

    tagItems[index].isSelected = !selected;

    selectedTagsIds.clear();
    for (var item in tagItems) {
      if (item.isSelected) {
        selectedTagCount++;
        selectedTagsIds.add(item.id ?? 0);
      }
    }

    switch (selectedTagCount) {
      case (0):
        selectedTagTitle.value = "Select Tag or creat new";
      case (1):
        selectedTagTitle.value = "One Selected Tag";
      case (2):
        selectedTagTitle.value = "Two Selected Tags";
      default:
        selectedTagTitle.value = "$selectedTagCount Selected Tags";
    }

    tagItems.refresh();
  }

  void onDateIconPressed(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),

      //DateTime.now() - not to allow to choose before today.
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      memoDateView.value = DateFormat('MMMM, dd yyyy').format(pickedDate);
    }
  }

  void onAddMediumPressed() {
    Get.dialog(AlertDialog(
      title: const Center(
        child: Text(
          'Add New Medium',
          style: AppFontStyles.link,
        ),
      ),
      backgroundColor: AppColors.white_color,
      surfaceTintColor: Colors.transparent,
      shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      content: Container(
        height: 100,
        alignment: Alignment.center,
        child: AppTextField(
            label: 'Medium Title',
            onTextChanged: (value) {
              _newMediumTitle = value;
            }),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Discard'),
          onPressed: () {
            Get.back();
          },
        ),
        TextButton(
          child: const Text('Save'),
          onPressed: () async {
            if (_newMediumTitle != null &&
                (_newMediumTitle?.isNotEmpty ?? false)) {
              await _mediumProvider
                  .addMediumItem(MediumItem(name: _newMediumTitle!));
              initData();
              Get.back();
              Get.showSnackbar(
                GetSnackBar(
                  messageText: Text(
                    "$_newMediumTitle Medium added Successfully",
                    style: AppFontStyles.caption
                        .copyWith(color: AppColors.bright_color),
                  ),
                  backgroundColor: AppColors.white_color,
                  duration: const Duration(seconds: 3),
                ),
              );
            }
          },
        ),
      ],
    ));
  }

  void onAddTagPressed() {
    Get.dialog(AlertDialog(
      title: const Center(
        child: Text(
          'Add New Tag',
          style: AppFontStyles.link,
        ),
      ),
      backgroundColor: AppColors.white_color,
      surfaceTintColor: Colors.transparent,
      shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      content: Container(
        height: 100,
        alignment: Alignment.center,
        child: AppTextField(
            label: 'Tag Title',
            onTextChanged: (value) {
              _newTagTitle = value;
            }),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Discard'),
          onPressed: () {
            _newTagTitle = null;
            Get.back();
          },
        ),
        TextButton(
          child: const Text('Save'),
          onPressed: () async {
            if (_newTagTitle != null && (_newTagTitle?.isNotEmpty ?? false)) {
              _tagProvider.addTagItem(TagItem(name: _newTagTitle!));
              initData();
              Get.back();
              Get.showSnackbar(
                GetSnackBar(
                  messageText: Text(
                    "$_newTagTitle TAG added Successfully",
                    style: AppFontStyles.caption
                        .copyWith(color: AppColors.bright_color),
                  ),
                  backgroundColor: AppColors.white_color,
                  duration: const Duration(seconds: 3),
                ),
              );
            }
          },
        ),
      ],
    ));
  }

  void onAddEntryPressed() async {
    //TODO: check if image selected
    int? lastMemoryId = await _memoryProvider.getLastmemoryId();
    File? savedImage = await _storageServices.saveFileToAppDocument(
        '${(lastMemoryId ?? -1) + 1}', File(imagePath.value!));

    // Adding a new memory
    final newMemory = Memory(
      title: memotitle.value ?? '',
      imagePath: savedImage?.path ?? '',
      dateTime: memoDate?.millisecondsSinceEpoch ??
          DateTime.now().millisecondsSinceEpoch,
      medium: selectedMediumTitle.value,
      description: memoDescription.value,
    );

    int? generatedMemoryId = await _memoryProvider.addMediumItem(newMemory);

// Check if the ID was generated successfully
    if (generatedMemoryId != null) {
      // Adding multiple tags to the newly created memory
      await _memoryProvider.addTagsToMemory(generatedMemoryId, selectedTagsIds);
      final memoryTags = await _memoryProvider.getMemoryTags(generatedMemoryId);
      print(memoryTags);
      print(generatedMemoryId); // Assuming tag IDs 1, 2, and 3 exist
    } else {
      throw Exception('Failed to retrieve the generated memory ID.');
    }
    Get.offAndToNamed(AppRoutes.HOME_PAGE, id: 2);
    Get.showSnackbar(
      GetSnackBar(
        messageText: Text(
          "${newMemory.title} Memory added Successfully",
          style: AppFontStyles.caption.copyWith(color: AppColors.bright_color),
        ),
        backgroundColor: AppColors.white_color,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
