import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:memo_capture/configs/theme/colors.dart';
import 'package:memo_capture/main.dart';
import 'package:memo_capture/views/splash/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bright_color,
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => Container(
            alignment: AlignmentDirectional.center,
            child: Stack(
              children: [
                AnimatedBuilder(
                  animation: controller.logoAnimationController!,
                  builder: (context, _) {
                    return Transform.scale(
                      scale: (controller.logoAnimationController?.value ?? 1 ),
                      child: Container(
                        width: 100,
                        height: 100,
                        padding: const EdgeInsets.fromLTRB(24, 12, 0, 12),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white_color,
                        ),
                      ),
                    );
                  },
                ),
                AnimatedBuilder(
                    animation: controller.logoAnimationController!,
                    builder: (context, _) {
                      return Transform.translate(
                        //TODO: logo move to left
                        offset:  Offset(
                          0,
                          0
                        ) ,
                        child: Container(
                          width: 100,
                          height: 100,
                          padding: const EdgeInsets.fromLTRB(24, 12, 0, 12),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.white_color,
                          ),
                          child: Image.asset(
                            'assets/images/logo-image.png',
                            fit: BoxFit.fitWidth,
    
                          ),
                        ),
                      );
                    }),
              ],
            )),
      ),
    );
  }
}
