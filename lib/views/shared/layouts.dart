import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:memo_capture/views/shared/buttons.dart';

class PageLayout extends StatelessWidget {
  const PageLayout({
    super.key,
    required this.pageTitle,
    required this.leadingIconAsset,
    required this.leadingOnClick,
    required this.bodyChildern,
  });

  final String pageTitle;

  final String leadingIconAsset;
  final void Function() leadingOnClick;

  final List<Widget> bodyChildern;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          padding: const EdgeInsets.only(top: 24),
          child: AppBar(
            leading: GestureDetector(
              onTap: () => leadingOnClick(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomIconButton(
                  height: 48,
                  width: 48,
                  asset: leadingIconAsset,
                ),
              ),
            ),
            surfaceTintColor: Colors.transparent,
            titleTextStyle: const TextStyle(
                color: Color(0xFF595959),
                fontWeight: FontWeight.bold,
                fontSize: 14),
            centerTitle: true,
            title: Text(pageTitle),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: bodyChildern,
        ),
      ),
    );
  }
}
