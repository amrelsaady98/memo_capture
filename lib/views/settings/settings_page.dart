import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:memo_capture/views/settings/settings_controller.dart';
import 'package:memo_capture/views/shared/layouts.dart';

class SettingsPage extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return PageLayout(
      pageTitle: 'Settings',
      leadingIconAsset: 'assets/icons/icon-layout.png',
      leadingOnClick: () => Get.back(id: 2),
      bodyChildern: [
        Container(
          child: Text('Settings'),
        ),
      ],
    );
  }
}
