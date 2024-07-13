import 'package:flutter/material.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_icons.dart';
import 'package:time_tracker/constants/app_images.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/helpers/helper_functions.dart';
import 'package:time_tracker/widgets/global_divider_widget.dart';
import 'package:time_tracker/widgets/icon_button_with_label.dart';

class ProductivityTabBellowContent extends StatefulWidget {
  const ProductivityTabBellowContent({super.key});

  @override
  State<ProductivityTabBellowContent> createState() =>
      _ProductivityTabBellowContentState();
}

class _ProductivityTabBellowContentState
    extends State<ProductivityTabBellowContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Downloads',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 40,
                child: IconButtonWithLabel(
                  icon: IconImages.download,
                  onTap: () {
                    showDownloadPreviewDialog(context);
                  },
                  backgroundColor: AppColors.appPrimaryColor,
                  borderColor: AppColors.appPrimaryColor,
                  text: 'Download Overview',
                  iconHeight: 14,
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Column(
          children: List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  alignment: WrapAlignment.spaceBetween,
                  runSpacing: 15,
                  runAlignment: WrapAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: AssetImage(AppImages.profileImage),
                          ),
                          SizedBox(height: 15),
                          Text(
                            AppTexts.jamesWilliams,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'jameswilliams@gmail.com',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.appDarkGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Total Productive: ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: AppColors.appPrimaryColor,
                              ),
                            ),
                            Text(
                              '00:00:22',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: AppColors.appPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        const SizedBox(
                          width: 296,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Google',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.appDarkGrey,
                                ),
                              ),
                              Text(
                                '00:00:24',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.appDarkGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        GlobalDividerWidget(
                          width: 296,
                          dividerColor: AppColors.appDarkGrey.withOpacity(0.4),
                        ),
                        const SizedBox(height: 25),
                        const SizedBox(
                          width: 296,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Time Tracking',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.appDarkGrey,
                                ),
                              ),
                              Text(
                                '00:00:24',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.appDarkGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        GlobalDividerWidget(
                          width: 296,
                          dividerColor: AppColors.appDarkGrey.withOpacity(0.4),
                        ),
                      ],
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      alignment: WrapAlignment.spaceBetween,
                      runSpacing: 15,
                      runAlignment: WrapAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Unproductive: ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blueColor.withOpacity(0.6),
                          ),
                        ),
                        Text(
                          '00:00:00',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blueColor.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
