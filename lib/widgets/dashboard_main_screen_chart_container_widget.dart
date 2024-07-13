import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/widgets/global_text_button.dart';

class DashBoardMainScreenChartContainerWidget extends StatelessWidget {
  const DashBoardMainScreenChartContainerWidget({
    super.key,
    this.height,
    required this.showButton,
    required this.icon,
    required this.title,
    required this.chart,
    // required this.chartImage,
  });
  final bool showButton;
  final String icon;
  final String title;
  final double? height;
  // final String chartImage;
  final Widget chart;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Wrap(
              runSpacing: 15,
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      icon,
                      color: AppColors.appLightGrey,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                showButton
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GlobalTextButton(
                            text: AppTexts.mouseClicks,
                            bachgroundColor: AppColors.bgColor,
                            foregroundColor: AppColors.blueColor,
                            borderColor: AppColors.blueColor,
                            buttonTextColor: AppColors.blueColor,
                            onTap: () {},
                          ),
                          const SizedBox(width: 10),
                          GlobalTextButton(
                            text: AppTexts.keyStrokes,
                            bachgroundColor: AppColors.bgColor,
                            foregroundColor: AppColors.appPrimaryColor,
                            borderColor: AppColors.appPrimaryColor,
                            buttonTextColor: AppColors.appPrimaryColor,
                            onTap: () {},
                          ),
                          const SizedBox(width: 10),
                          GlobalTextButton(
                            text: AppTexts.websiteVisited,
                            bachgroundColor: AppColors.bgColor,
                            foregroundColor: AppColors.purpleColor,
                            borderColor: AppColors.purpleColor,
                            buttonTextColor: AppColors.purpleColor,
                            onTap: () {},
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Image.asset(chartImage),
          chart
        ],
      ),
    );
  }
}
