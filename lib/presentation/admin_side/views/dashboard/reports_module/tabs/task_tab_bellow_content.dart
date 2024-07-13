import 'package:flutter/material.dart';
import 'package:flutter_image_stack/flutter_image_stack.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/reports_module/widgets/container_columns_widget.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_icons.dart';
import 'package:time_tracker/constants/app_images.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/widgets/alert_dialog_widget.dart';
import 'package:time_tracker/widgets/global_divider_widget.dart';
import 'package:time_tracker/widgets/global_switch_button_widget.dart';
import 'package:time_tracker/widgets/global_text_button.dart';
import 'package:time_tracker/widgets/icon_button_with_label.dart';
import 'package:time_tracker/widgets/rounded_text_field.dart';

class TaskTabBellowContent extends StatefulWidget {
  const TaskTabBellowContent({super.key, required this.isAdminSide});
  final bool isAdminSide;

  @override
  State<TaskTabBellowContent> createState() => _TaskTabBellowContentState();
}

class _TaskTabBellowContentState extends State<TaskTabBellowContent> {
  ScrollController scrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();
  final List<String> images = [
    AppImages.profileImage,
    AppImages.profileImage,
    AppImages.profileImage,
  ];
  final List<String> titles = ['Title', 'Members', 'Duration', 'Actions'];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.isAdminSide)
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
                Row(
                  children: [
                    SizedBox(
                      height: 40,
                      child: IconButtonWithLabel(
                        backgroundColor: AppColors.appPrimaryColor,
                        borderColor: AppColors.appPrimaryColor,
                        text: 'User Report',
                        iconHeight: 14,
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                        icon: IconImages.download,
                        onTap: () {
                          showDialog(
                            barrierColor: Colors.transparent,
                            context: context,
                            builder: (context) => AlertDialogWidget(
                              title: 'Background Task',
                              contentChild: Column(
                                children: [
                                  const Text(
                                    'Action In Progress',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SpinKitSpinningLines(
                                      color: AppColors.appPrimaryColor,
                                      lineWidth: 3,
                                      itemCount: 10),
                                  const SizedBox(
                                    width: 721,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        'You can safely close this window & continue with other tasks or activities. The background task will continue to execute uninterrupted, & you can check back at any time to see the status & progress of the task.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.appDarkGrey),
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(top: 15, bottom: 30),
                                    child: GlobalDividerWidget(
                                      dividerColor: AppColors.appDarkGrey,
                                      width: double.infinity,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            IconImages.appUsageCircle,
                                            height: 14,
                                          ),
                                          const SizedBox(width: 7),
                                          const Text(
                                            AppTexts.appUsage,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            IconImages.finish,
                                            height: 14,
                                            color: AppColors.appDarkGrey,
                                          ),
                                          const SizedBox(width: 7),
                                          const Text(
                                            'Finished',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          GlobalTextButton(
                                            text: 'Download File',
                                            bachgroundColor: Colors.transparent,
                                            buttonTextColor:
                                                AppColors.appPrimaryColor,
                                            onTap: () {},
                                          ),
                                          const SizedBox(width: 40),
                                          IconButton(
                                              onPressed: () {},
                                              icon: SvgPicture.asset(
                                                  IconImages.delete))
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(top: 15, bottom: 30),
                                    child: GlobalDividerWidget(
                                      dividerColor: AppColors.appDarkGrey,
                                      width: double.infinity,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 105,
                                    child: GlobalTextButton(
                                      text: AppTexts.close,
                                      bachgroundColor:
                                          AppColors.appPrimaryColor,
                                      buttonTextColor: Colors.white,
                                      onTap: () => Navigator.pop(context),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 30),
                    SizedBox(
                      height: 40,
                      child: IconButtonWithLabel(
                        icon: IconImages.download,
                        backgroundColor: AppColors.appPrimaryColor,
                        borderColor: AppColors.appPrimaryColor,
                        text: 'Project Report',
                        iconHeight: 14,
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        onTap: () {
                          showDialog(
                            barrierColor: Colors.transparent,
                            context: context,
                            builder: (context) => AlertDialogWidget(
                              title: 'Project Report',
                              contentChild: Column(
                                children: [
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        width: 300,
                                        child: RoundedTextField(
                                          keyboardType: TextInputType.text,
                                          borderColor: AppColors.appLightGrey,
                                          labelTextStyle: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.appLightGrey,
                                          ),
                                          enableBorder: true,
                                          labelText: 'Enter File Name',
                                          textFieldColor: Colors.white,
                                          obscureText: false,
                                          labelTextColor:
                                              AppColors.appLightGrey,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      SizedBox(
                                        width: 300,
                                        child: RoundedTextField(
                                            keyboardType: TextInputType.text,
                                            borderColor: AppColors.appLightGrey,
                                            hintText: 'Enter File Name',
                                            textFieldColor: Colors.white,
                                            showBorder: true,
                                            obscureText: false),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 23),
                                  Container(
                                    width: 630,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.appLightGrey),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 630,
                                          height: 50,
                                          decoration: const BoxDecoration(
                                              color: AppColors.appPrimaryColor,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(12),
                                                  topRight:
                                                      Radius.circular(12))),
                                          child: const Center(
                                            child: Text(
                                              'You\'re about to export a file with the following settings.',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 50,
                                              right: 236,
                                              top: 15,
                                              bottom: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Name',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                'Exported Report',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.appLightGrey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const GlobalDividerWidget(
                                          dividerColor: AppColors.appDarkGrey,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 50,
                                              right: 310,
                                              top: 15,
                                              bottom: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Type',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                'Project',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.appLightGrey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const GlobalDividerWidget(
                                          dividerColor: AppColors.appDarkGrey,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 50,
                                              right: 330,
                                              top: 15,
                                              bottom: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Format',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                'CSV',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.appLightGrey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const GlobalDividerWidget(
                                          dividerColor: AppColors.appDarkGrey,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                            left: 50,
                                            right: 150,
                                            top: 15,
                                            bottom: 15,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Duration',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                '31 May 2023 - 31 May 2023',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.appLightGrey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 400,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.appDarkGrey),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Row(
                                          children: [
                                            GlobalSwitchButton(
                                                onTap: (value) {},
                                                currentState: true),
                                            const Text(
                                              'Include Headers',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      SizedBox(
                                        height: 40,
                                        width: 158,
                                        child: IconButtonWithLabel(
                                          icon: IconImages.export,
                                          iconHeight: 15,
                                          iconColor: Colors.white,
                                          borderColor:
                                              AppColors.appPrimaryColor,
                                          textStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                          backgroundColor:
                                              AppColors.appPrimaryColor,
                                          onTap: () {},
                                          text: 'Export',
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        const SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Container(
            padding:
                const EdgeInsets.only(top: 50, left: 40, right: 40, bottom: 20),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: ContainerColumsWidget(
                    title: 'Title',
                    crossAxisAlignment: CrossAxisAlignment.start,
                    itemLength: 5,
                    widgetToGenerate: SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            IconImages.backLog,
                            color: AppColors.blueColor,
                          ),
                          const SizedBox(width: 3),
                          const Text(
                            AppTexts.backLog,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.appDarkGrey),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ContainerColumsWidget(
                    title: 'Members',
                    crossAxisAlignment: CrossAxisAlignment.start,
                    itemLength: 5,
                    widgetToGenerate: SizedBox(
                      height: 50,
                      child: FlutterImageStack(
                        imageList: images,
                        imageSource: ImageSource.asset,
                        totalCount: images.length,
                        itemCount: 3,
                        itemRadius: 25,
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  child: ContainerColumsWidget(
                    title: 'Duration',
                    crossAxisAlignment: CrossAxisAlignment.start,
                    itemLength: 5,
                    widgetToGenerate: SizedBox(
                      height: 50,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          '00:00:04',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.appDarkGrey),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: ContainerColumsWidget(
                      title: 'Actions',
                      crossAxisAlignment: CrossAxisAlignment.start,
                      itemLength: 5,
                      widgetToGenerate: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: SizedBox(
                          height: 33,
                          width: 115,
                          child: GlobalTextButton(
                            text: 'See By Users',
                            bachgroundColor: Colors.transparent,
                            borderColor: AppColors.appPrimaryColor,
                            buttonTextColor: AppColors.appPrimaryColor,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return const AlertDialogWidget(
                                    title: 'Users Record',
                                    contentChild: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 100),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Users',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                'Work Time',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                'Invoiced',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        ),
                                        GlobalDividerWidget(
                                          width: 800,
                                          dividerColor: AppColors.blueColor,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 70),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 25,
                                                      backgroundImage:
                                                          AssetImage(AppImages
                                                              .profileImage),
                                                    ),
                                                    SizedBox(width: 15),
                                                    Text(
                                                      'Invoiced',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: AppColors
                                                              .appDarkGrey),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  '00:00:00',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors
                                                          .appDarkGrey),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  '-',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors
                                                          .appDarkGrey),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
