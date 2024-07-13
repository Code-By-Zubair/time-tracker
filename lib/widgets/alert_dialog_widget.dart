import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_icons.dart';
import 'package:time_tracker/helpers/media_query_helper.dart';
import 'package:time_tracker/widgets/global_divider_widget.dart';

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({
    super.key,
    required this.title,
    this.contentChild,
    this.onCrossTap,
  });
  final String title;
  final Widget? contentChild;

  final VoidCallback? onCrossTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      alignment: Alignment.center,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(40),
      content: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.appPrimaryColor.withOpacity(0.9),
                            spreadRadius: 1,
                            blurRadius: 10,
                          ),
                        ]),
                  )
                      .animate(
                        onComplete: (controller) => controller.repeat(),
                      )
                      .shimmer(duration: const Duration(seconds: 5), size: 1))),
          Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: SvgPicture.asset(IconImages.cross),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const GlobalDividerWidget(
                        width: double.infinity,
                        dividerColor: AppColors.appDarkGrey,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      contentChild ?? const SizedBox.shrink(),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
    // : AlertDialog(
    //     surfaceTintColor: Colors.white,
    //     actionsAlignment: actionsAlignment,
    //     shape:
    //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    //     title: showAlert
    //         ? Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text(
    //                 title,
    //                 style: const TextStyle(
    //                     fontSize: 20, fontWeight: FontWeight.w600),
    //               ),
    //               IconButton(
    //                   onPressed: onCrossTap ?? () => Navigator.pop(context),
    //                   icon: SvgPicture.asset(IconImages.cross))
    //             ],
    //           )
    //         : const SizedBox.shrink(),
    //     content: SingleChildScrollView(child: contentChild),
    //     actions: actions,
    //   );
  }
}
