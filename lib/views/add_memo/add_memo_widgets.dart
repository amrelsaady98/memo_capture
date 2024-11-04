import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memo_capture/core/models/medium.dart';
import 'package:memo_capture/core/models/memory.dart';
import 'package:memo_capture/core/models/tag.dart';
import 'package:memo_capture/configs/theme/colors.dart';
import 'package:memo_capture/configs/theme/font_styles.dart';
import 'package:memo_capture/views/shared/buttons.dart';

class AddMemoMediumExpantionTile extends StatelessWidget {
  AddMemoMediumExpantionTile({
    super.key,
    required this.title,
    required this.icon,
    this.mediumItems,
    this.onAddItemPressed,
    this.onItemSelected,
    this.footerItem,
  });

  String title;
  Widget icon;
  List<MediumItem>? mediumItems;
  Widget? footerItem;
  void Function()? onAddItemPressed;
  void Function(int index)? onItemSelected;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      trailing: icon,
      title: Text(
        title,
        style: AppFontStyles.body.copyWith(color: AppColors.dark_50_color),
      ),
      expandedAlignment: Alignment.centerLeft,
      tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      collapsedShape: const RoundedRectangleBorder(
        side: BorderSide(
          width: 1,
          color: AppColors.dark_50_color,
        ),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          width: 1,
          color: AppColors.dark_color,
        ),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      children: [
        const Divider(
          color: AppColors.dark_50_color,
          thickness: 1,
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: mediumItems?.length ?? 0,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => onItemSelected!(index),
                child: Container(
                  height: 48,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Transform.scale(
                        scale: 1,
                        child: SizedBox(
                          child: CupertinoCheckbox(
                            value: mediumItems![index].isSelected,
                            side: BorderSide(
                              color: mediumItems![index].isSelected
                                  ? AppColors.bright_color
                                  : AppColors.dark_50_color,
                              width: 1,
                              strokeAlign: 1,
                            ),
                            onChanged: (value) => onItemSelected!(index),
                            activeColor: AppColors.bright_color,
                            shape: const CircleBorder(side: BorderSide()),
                          ),
                        ),
                      ),
                      Text(mediumItems![index].name),
                    ],
                  ),
                ),
              );
            }),
        Visibility(
          visible: footerItem != null,
          child: const Divider(
            color: AppColors.dark_50_color,
            thickness: 1,
          ),
        ),
        Visibility(
          visible: footerItem != null,
          child: footerItem ?? Container(),
        ),
      ],
    );
  }
}

class AddMemoTagExpantionTile extends StatelessWidget {
  AddMemoTagExpantionTile({
    super.key,
    required this.title,
    required this.icon,
    this.mediumItems,
    this.onAddItemPressed,
    this.onItemSelected,
    this.footerItem,
  });

  String title;
  Widget icon;
  List<TagItem>? mediumItems;
  Widget? footerItem;
  void Function()? onAddItemPressed;
  void Function(int index)? onItemSelected;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      trailing: icon,
      title: Text(
        title,
        style: AppFontStyles.body.copyWith(color: AppColors.dark_50_color),
      ),
      expandedAlignment: Alignment.centerLeft,
      tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      collapsedShape: const RoundedRectangleBorder(
        side: BorderSide(
          width: 1,
          color: AppColors.dark_50_color,
        ),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          width: 1,
          color: AppColors.dark_color,
        ),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      children: [
        const Divider(
          color: AppColors.dark_50_color,
          thickness: 1,
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: mediumItems?.length ?? 0,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => onItemSelected!(index),
                child: Container(
                  height: 48,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Transform.scale(
                        scale: 1,
                        child: SizedBox(
                          child: CupertinoCheckbox(
                            value: mediumItems![index].isSelected,
                            side: BorderSide(
                              color: mediumItems![index].isSelected
                                  ? AppColors.bright_color
                                  : AppColors.dark_50_color,
                              width: 1,
                              strokeAlign: 1,
                            ),
                            onChanged: (value) => onItemSelected!(index),
                            activeColor: AppColors.bright_color,
                            shape: const CircleBorder(side: BorderSide()),
                          ),
                        ),
                      ),
                      Text(mediumItems![index].name),
                    ],
                  ),
                ),
              );
            }),
        Visibility(
          visible: footerItem != null,
          child: const Divider(
            color: AppColors.dark_50_color,
            thickness: 1,
          ),
        ),
        Visibility(
          visible: footerItem != null,
          child: footerItem ?? Container(),
        ),
      ],
    );
  }
}
