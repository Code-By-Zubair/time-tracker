import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/helpers/media_query_helper.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_icons.dart';
import 'package:time_tracker/constants/app_images.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/helpers/helper_functions.dart';
import 'package:time_tracker/providers/report_provider_user_side.dart';
import 'package:time_tracker/widgets/alert_dialog_widget.dart';
import 'package:time_tracker/widgets/global_divider_widget.dart';
import 'package:time_tracker/widgets/global_text_button.dart';
import 'package:time_tracker/widgets/icon_button_with_label.dart';
import 'package:time_tracker/widgets/rounded_text_field.dart';

class UserTabBelowContent extends StatefulWidget {
  const UserTabBelowContent({
    super.key,
    required this.containers,
    required this.isAdminSide,
  });

  final List<String> containers;
  final bool isAdminSide;

  @override
  State<UserTabBelowContent> createState() => _UserTabBelowContentState();
}

class _UserTabBelowContentState extends State<UserTabBelowContent> {
  int isExpanded = -1;
  bool isPreview = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.isAdminSide)
          isExpanded != -1
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Downloads',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Row(
                        children: [
                          SizedBox(
                              width: 106,
                              height: 40,
                              child: GlobalTextButton(
                                text: 'Create PDF',
                                bachgroundColor: Colors.transparent,
                                buttonTextColor: AppColors.appDarkGrey,
                                borderColor: AppColors.appDarkGrey,
                                onTap: () {
                                  showDownloadPreviewDialog(context);
                                },
                              )),
                          const SizedBox(width: 30),
                          SizedBox(
                              height: 40,
                              child: IconButtonWithLabel(
                                icon: IconImages.download,
                                backgroundColor: AppColors.appPrimaryColor,
                                borderColor: AppColors.appPrimaryColor,
                                text: 'Download Overview',
                                iconHeight: 14,
                                textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  showDownloadPreviewDialog(context);
                                },
                              )),
                        ],
                      )
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        SizedBox(height: isExpanded != -1 ? 30 : 0),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(widget.containers.length, (i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: AnimatedContainer(
                constraints: const BoxConstraints(
                    maxHeight: double.infinity, minHeight: 200),
                duration: const Duration(milliseconds: 200),
                width: double.infinity,
                padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    AssetImage(AppImages.profileImage),
                              ),
                              SizedBox(height: 15),
                              Text(
                                'James Williams',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'ID: ',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Flexible(
                                    child: Text(
                                      '646c54c36f6',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.appDarkGrey),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            width: 1,
                            height: 133,
                            color: AppColors.appDarkGrey,
                          ),
                        ),
                        const Expanded(
                          flex: 6,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Team',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      AppTexts.defaultTeam,
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
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Last Synced',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'May,24 16:59',
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
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'App Version',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      '3.0.59',
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
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppTexts.status,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 5,
                                          backgroundColor: AppColors.redColor,
                                        ),
                                        SizedBox(width: 3),
                                        Flexible(
                                          child: Text(
                                            'Tracking Stopped',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.appDarkGrey),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          width: 1,
                          height: 133,
                          color: AppColors.appDarkGrey,
                        ),
                        Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Work Time: ',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Flexible(
                                      child: Text(
                                        '00:27:58',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.appPrimaryColor),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Break Time: ',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Flexible(
                                      child: Text(
                                        '00:27:58',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.appPrimaryColor),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 27),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: context.w * 0.01,
                                  ),
                                  child: LinearPercentIndicator(
                                    width: context.w * 0.12,
                                    lineHeight: 17.0,
                                    percent: 0.5,
                                    center: const Padding(
                                      padding: EdgeInsets.only(bottom: 3),
                                      child: Text(
                                        "50.0%",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    backgroundColor:
                                        AppColors.greenColor.withOpacity(0.2),
                                    progressColor: AppColors.greenColor,
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
                    isExpanded == i
                        ? const SizedBox.shrink()
                        : Center(
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isExpanded = i;
                                  });
                                },
                                icon: const Icon(Icons.keyboard_arrow_down)),
                          ),
                    isExpanded == i
                        ? Column(
                            children: [
                              const SizedBox(height: 30),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Container(
                                    padding: const EdgeInsets.all(20),
                                    height: 492,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13),
                                      border: Border.all(
                                          color: AppColors.appDarkGrey),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 7,
                                              backgroundColor:
                                                  AppColors.lightOrange,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              'May,24 2023',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 7),
                                        const Row(
                                          children: [
                                            Text(
                                              'Work Time: ',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Flexible(
                                              child: Text(
                                                '27 Minutes',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.blueColor,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 7),
                                        const Row(
                                          children: [
                                            Text(
                                              'From Which Away-',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                '00:00:00',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      AppColors.appPrimaryColor,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 7),
                                        const Row(
                                          children: [
                                            Text(
                                              'Break Time',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Flexible(
                                              child: Text(
                                                '00:00:00',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      AppColors.appPrimaryColor,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const Spacer(),
                                        Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.start,
                                          runAlignment: WrapAlignment.start,
                                          runSpacing: 15,
                                          children: [
                                            GlobalTextButton(
                                              text: 'Remove Time',
                                              bachgroundColor:
                                                  Colors.transparent,
                                              borderColor:
                                                  AppColors.appDarkGrey,
                                              buttonTextColor:
                                                  AppColors.appDarkGrey,
                                              onTap: () {
                                                showDialog(
                                                  barrierColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (context) =>
                                                      StatefulBuilder(
                                                    builder:
                                                        (context, setState1) =>
                                                            AlertDialogWidget(
                                                      title:
                                                          'Delete Tracking Records',
                                                      contentChild: Column(
                                                        children: [
                                                          const Row(
                                                            children: [
                                                              Text(
                                                                'From:  ',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 15,
                                                              ),
                                                              SizedBox(
                                                                width: 195,
                                                                height: 45,
                                                                child:
                                                                    RoundedTextField(
                                                                  hintText:
                                                                      '31-05-2023',
                                                                  labelText:
                                                                      'Start Date',
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .none,
                                                                  obscureText:
                                                                      false,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              SizedBox(
                                                                width: 195,
                                                                height: 45,
                                                                child:
                                                                    RoundedTextField(
                                                                  hintText:
                                                                      '12:20 pm',
                                                                  labelText:
                                                                      'Start Time',
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .none,
                                                                  obscureText:
                                                                      false,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 25,
                                                          ),
                                                          const Row(
                                                            children: [
                                                              Text(
                                                                'To:  ',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 35,
                                                              ),
                                                              SizedBox(
                                                                width: 195,
                                                                height: 45,
                                                                child:
                                                                    RoundedTextField(
                                                                  hintText:
                                                                      '31-05-2023',
                                                                  labelText:
                                                                      'End Date',
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .none,
                                                                  obscureText:
                                                                      false,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              SizedBox(
                                                                width: 195,
                                                                height: 45,
                                                                child:
                                                                    RoundedTextField(
                                                                  hintText:
                                                                      '12:20 pm',
                                                                  labelText:
                                                                      'End Time',
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .none,
                                                                  obscureText:
                                                                      false,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        30),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Removing ',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: AppColors
                                                                          .appDarkGrey),
                                                                ),
                                                                Text(
                                                                  '0-5:',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: AppColors
                                                                          .appDarkGrey),
                                                                ),
                                                                Text(
                                                                  '05:00',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: AppColors
                                                                          .appDarkGrey),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const GlobalDividerWidget(
                                                            width: 465,
                                                            dividerColor:
                                                                AppColors
                                                                    .appDarkGrey,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        20),
                                                            child: SizedBox(
                                                              height: 40,
                                                              width: 117,
                                                              child:
                                                                  IconButtonWithLabel(
                                                                      text:
                                                                          'Preview',
                                                                      icon: IconImages
                                                                          .preview,
                                                                      iconHeight:
                                                                          12,
                                                                      backgroundColor:
                                                                          AppColors
                                                                              .appPrimaryColor,
                                                                      borderColor:
                                                                          AppColors
                                                                              .appPrimaryColor,
                                                                      onTap:
                                                                          () {
                                                                        setState1(
                                                                            () {
                                                                          isPreview =
                                                                              !isPreview;
                                                                        });
                                                                      }),
                                                            ),
                                                          ),
                                                          if (isPreview)
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                const Text(
                                                                  'You\'re about to delete:',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 20,
                                                                ),
                                                                const Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      'Work Time: ',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      '0.00 hours',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: AppColors
                                                                            .appPrimaryColor,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                const Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      'Break Time: ',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      '0.00 hours',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: AppColors
                                                                            .appPrimaryColor,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                const Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      'Tracked Apps: ',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      '0',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: AppColors
                                                                            .appPrimaryColor,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                const Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      'Tracked Tasks: ',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      '0',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: AppColors
                                                                            .appPrimaryColor,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                const Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      'ScreenShots',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      '0',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: AppColors
                                                                            .appPrimaryColor,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                const Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      'Earned Rates: ',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      '\$0.00',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: AppColors
                                                                            .appPrimaryColor,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .symmetric(
                                                                    vertical:
                                                                        20,
                                                                  ),
                                                                  child:
                                                                      IconButtonWithLabel(
                                                                    text:
                                                                        'Delete',
                                                                    icon: IconImages
                                                                        .delete,
                                                                    iconHeight:
                                                                        15,
                                                                    iconColor:
                                                                        AppColors
                                                                            .appPrimaryColor,
                                                                    textStyle: const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: AppColors
                                                                            .appPrimaryColor),
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    borderColor:
                                                                        AppColors
                                                                            .appPrimaryColor,
                                                                    onTap:
                                                                        () {},
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                            const SizedBox(width: 20),
                                            GlobalTextButton(
                                              text: 'Add Mannual Time',
                                              bachgroundColor:
                                                  Colors.transparent,
                                              borderColor:
                                                  AppColors.appDarkGrey,
                                              buttonTextColor:
                                                  AppColors.appDarkGrey,
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (context) =>
                                                            StatefulBuilder(
                                                              builder: (context,
                                                                      setState1) =>
                                                                  AlertDialogWidget(
                                                                title:
                                                                    'Add Manual Time',
                                                                contentChild:
                                                                    Column(
                                                                  children: [
                                                                    const Row(
                                                                      children: [
                                                                        Text(
                                                                          'From:  ',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              15,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              195,
                                                                          height:
                                                                              45,
                                                                          child:
                                                                              RoundedTextField(
                                                                            hintText:
                                                                                '31-05-2023',
                                                                            labelText:
                                                                                'Start Date',
                                                                            keyboardType:
                                                                                TextInputType.none,
                                                                            obscureText:
                                                                                false,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              195,
                                                                          height:
                                                                              45,
                                                                          child:
                                                                              RoundedTextField(
                                                                            hintText:
                                                                                '12:20 pm',
                                                                            labelText:
                                                                                'Start Time',
                                                                            keyboardType:
                                                                                TextInputType.none,
                                                                            obscureText:
                                                                                false,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          25,
                                                                    ),
                                                                    const Row(
                                                                      children: [
                                                                        Text(
                                                                          'To:  ',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              35,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              195,
                                                                          height:
                                                                              45,
                                                                          child:
                                                                              RoundedTextField(
                                                                            hintText:
                                                                                '31-05-2023',
                                                                            labelText:
                                                                                'End Date',
                                                                            keyboardType:
                                                                                TextInputType.none,
                                                                            obscureText:
                                                                                false,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              195,
                                                                          height:
                                                                              45,
                                                                          child:
                                                                              RoundedTextField(
                                                                            hintText:
                                                                                '12:20 pm',
                                                                            labelText:
                                                                                'End Time',
                                                                            keyboardType:
                                                                                TextInputType.none,
                                                                            obscureText:
                                                                                false,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          vertical:
                                                                              30),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            'Adding ',
                                                                            style: TextStyle(
                                                                                fontSize: 18,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: AppColors.appDarkGrey),
                                                                          ),
                                                                          Text(
                                                                            '0-5:',
                                                                            style: TextStyle(
                                                                                fontSize: 18,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: AppColors.appDarkGrey),
                                                                          ),
                                                                          Text(
                                                                            '05:00',
                                                                            style: TextStyle(
                                                                                fontSize: 18,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: AppColors.appDarkGrey),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),

                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              117,
                                                                          height:
                                                                              40,
                                                                          child:
                                                                              GlobalTextButton(
                                                                            text:
                                                                                'Work Time',
                                                                            bachgroundColor:
                                                                                AppColors.appPrimaryColor,
                                                                            borderColor:
                                                                                AppColors.appPrimaryColor,
                                                                            buttonTextColor:
                                                                                Colors.white,
                                                                            onTap:
                                                                                () {},
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            width:
                                                                                20),
                                                                        SizedBox(
                                                                          width:
                                                                              117,
                                                                          height:
                                                                              40,
                                                                          child:
                                                                              GlobalTextButton(
                                                                            text:
                                                                                'Break Time',
                                                                            bachgroundColor:
                                                                                Colors.transparent,
                                                                            borderColor:
                                                                                AppColors.appPrimaryColor,
                                                                            buttonTextColor:
                                                                                AppColors.appPrimaryColor,
                                                                            onTap:
                                                                                () {},
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            20),
                                                                    const GlobalDividerWidget(
                                                                      width:
                                                                          465,
                                                                      dividerColor:
                                                                          AppColors
                                                                              .appDarkGrey,
                                                                    ),
                                                                    const SizedBox(
                                                                      width:
                                                                          465,
                                                                      child:
                                                                          Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            'Note: ',
                                                                            style: TextStyle(
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w400,
                                                                                color: AppColors.appDarkGrey),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              'Any existing tracking data for the selected period will be overwritten',
                                                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.appDarkGrey),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const GlobalDividerWidget(
                                                                      width:
                                                                          465,
                                                                      dividerColor:
                                                                          AppColors
                                                                              .appDarkGrey,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          vertical:
                                                                              20),
                                                                      child:
                                                                          SizedBox(
                                                                        height:
                                                                            40,
                                                                        width:
                                                                            117,
                                                                        child: GlobalTextButton(
                                                                            text:
                                                                                'Submit',
                                                                            buttonTextColor:
                                                                                Colors.white,
                                                                            bachgroundColor: AppColors.appPrimaryColor,
                                                                            borderColor: AppColors.appPrimaryColor,
                                                                            onTap: () {}),
                                                                      ),
                                                                    ),
                                                                    // if (isPreview)
                                                                    //   Column(
                                                                    //     crossAxisAlignment:
                                                                    //         CrossAxisAlignment.center,
                                                                    //     children: [
                                                                    //       const Text(
                                                                    //         'You\'re about to delete:',
                                                                    //         style:
                                                                    //             TextStyle(
                                                                    //           fontSize: 20,
                                                                    //           fontWeight: FontWeight.w500,
                                                                    //         ),
                                                                    //       ),
                                                                    //       const Row(
                                                                    //         mainAxisAlignment:
                                                                    //             MainAxisAlignment.center,
                                                                    //         children: [
                                                                    //           Text(
                                                                    //             'Work Time: ',
                                                                    //             style: TextStyle(
                                                                    //               fontSize: 18,
                                                                    //               fontWeight: FontWeight.w400,
                                                                    //             ),
                                                                    //           ),
                                                                    //           Text(
                                                                    //             '0.00 hours',
                                                                    //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.appPrimaryColor),
                                                                    //           ),
                                                                    //         ],
                                                                    //       ),
                                                                    //       const Row(
                                                                    //         mainAxisAlignment:
                                                                    //             MainAxisAlignment.center,
                                                                    //         children: [
                                                                    //           Text(
                                                                    //             'Break Time: ',
                                                                    //             style: TextStyle(
                                                                    //               fontSize: 18,
                                                                    //               fontWeight: FontWeight.w400,
                                                                    //             ),
                                                                    //           ),
                                                                    //           Text(
                                                                    //             '0.00 hours',
                                                                    //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.appPrimaryColor),
                                                                    //           ),
                                                                    //         ],
                                                                    //       ),
                                                                    //       const Row(
                                                                    //         mainAxisAlignment:
                                                                    //             MainAxisAlignment.center,
                                                                    //         children: [
                                                                    //           Text(
                                                                    //             'Tracked Apps: ',
                                                                    //             style: TextStyle(
                                                                    //               fontSize: 18,
                                                                    //               fontWeight: FontWeight.w400,
                                                                    //             ),
                                                                    //           ),
                                                                    //           Text(
                                                                    //             '0',
                                                                    //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.appPrimaryColor),
                                                                    //           ),
                                                                    //         ],
                                                                    //       ),
                                                                    //       const Row(
                                                                    //         mainAxisAlignment:
                                                                    //             MainAxisAlignment.center,
                                                                    //         children: [
                                                                    //           Text(
                                                                    //             'Tracked Tasks: ',
                                                                    //             style: TextStyle(
                                                                    //               fontSize: 18,
                                                                    //               fontWeight: FontWeight.w400,
                                                                    //             ),
                                                                    //           ),
                                                                    //           Text(
                                                                    //             '0',
                                                                    //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.appPrimaryColor),
                                                                    //           ),
                                                                    //         ],
                                                                    //       ),
                                                                    //       const Row(
                                                                    //         mainAxisAlignment:
                                                                    //             MainAxisAlignment.center,
                                                                    //         children: [
                                                                    //           Text(
                                                                    //             'ScreenShots',
                                                                    //             style: TextStyle(
                                                                    //               fontSize: 18,
                                                                    //               fontWeight: FontWeight.w400,
                                                                    //             ),
                                                                    //           ),
                                                                    //           Text(
                                                                    //             '0',
                                                                    //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.appPrimaryColor),
                                                                    //           ),
                                                                    //         ],
                                                                    //       ),
                                                                    //       const Row(
                                                                    //         mainAxisAlignment:
                                                                    //             MainAxisAlignment.center,
                                                                    //         children: [
                                                                    //           Text(
                                                                    //             'Earned Rates: ',
                                                                    //             style: TextStyle(
                                                                    //               fontSize: 18,
                                                                    //               fontWeight: FontWeight.w400,
                                                                    //             ),
                                                                    //           ),
                                                                    //           Text(
                                                                    //             '\$0.00',
                                                                    //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.appPrimaryColor),
                                                                    //           ),
                                                                    //         ],
                                                                    //       ),
                                                                    //       Padding(
                                                                    //         padding:
                                                                    //             const EdgeInsets.symmetric(vertical: 20),
                                                                    //         child: IconButtonWithLabel(
                                                                    //             text: 'Delete',
                                                                    //             icon: IconImages.delete,
                                                                    //             iconHeight: 15,
                                                                    //             iconColor: AppColors.appPrimaryColor,
                                                                    //             textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.appPrimaryColor),
                                                                    //             backgroundColor: Colors.transparent,
                                                                    //             borderColor: AppColors.appPrimaryColor,
                                                                    //             onTap: () {}),
                                                                    //       ),
                                                                    //     ],
                                                                    //   )
                                                                  ],
                                                                ),
                                                              ),
                                                            ));
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                                  const SizedBox(width: 30),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: double.infinity,
                                          child: Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.start,
                                            alignment:
                                                WrapAlignment.spaceBetween,
                                            runAlignment: WrapAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    'Figma: ',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      '00:27:58',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: AppColors
                                                              .appPrimaryColor),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      'Time Tracking: ',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      '00:27:58',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: AppColors
                                                              .appPrimaryColor),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        // const SizedBox(height: 11),
                                        const SizedBox(
                                          width: double.infinity,
                                          child: Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.start,
                                            alignment:
                                                WrapAlignment.spaceBetween,
                                            runAlignment: WrapAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    'docs.google.com: ',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      '00:27:58',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: AppColors
                                                              .appPrimaryColor),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      'Skype: ',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      '00:27:58',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: AppColors
                                                              .appPrimaryColor),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        // const SizedBox(height: 11),
                                        const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Microsoft Windows: ',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Flexible(
                                              child: Text(
                                                '00:27:58',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors
                                                        .appPrimaryColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 30),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 14, horizontal: 25),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            border: Border.all(
                                                color: AppColors.appDarkGrey),
                                          ),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  'Time Tracking: ',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors
                                                          .appDarkGrey),
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  '00:27:58',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors
                                                          .appPrimaryColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 14, horizontal: 25),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            border: Border.all(
                                                color: AppColors.appDarkGrey),
                                          ),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  'No Task: ',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors
                                                          .appDarkGrey),
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  '00:27:58',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors
                                                          .appPrimaryColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 14, horizontal: 25),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            border: Border.all(
                                                color: AppColors.appDarkGrey),
                                          ),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  'James Williams: ',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors
                                                          .appDarkGrey),
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  '00:27:58',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors
                                                          .appPrimaryColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20, bottom: 20),
                                          child: SizedBox(
                                            height: 29,
                                            width: 73,
                                            child: GlobalTextButton(
                                              text: 'View All',
                                              bachgroundColor:
                                                  Colors.transparent,
                                              borderColor:
                                                  AppColors.appDarkGrey,
                                              buttonTextColor:
                                                  AppColors.appDarkGrey,
                                              onTap: () {
                                                Provider.of<ReportProviderUserSide>(
                                                        context,
                                                        listen: false)
                                                    .changeSelectedTab(1);
                                              },
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                  color:
                                                      AppColors.appDarkGrey)),
                                          width: double.infinity,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    AppTexts.screenShots,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  SizedBox(
                                                    height: 29,
                                                    width: 73,
                                                    child: GlobalTextButton(
                                                      text: 'View All',
                                                      bachgroundColor:
                                                          Colors.transparent,
                                                      borderColor:
                                                          AppColors.appDarkGrey,
                                                      buttonTextColor:
                                                          AppColors.appDarkGrey,
                                                      onTap: () {
                                                        Provider.of<ReportProviderUserSide>(
                                                                context,
                                                                listen: false)
                                                            .changeSelectedTab(
                                                                1);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 30),
                                              Wrap(
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.start,
                                                alignment:
                                                    WrapAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Image.asset(
                                                            AppImages
                                                                .screenShotImage,
                                                            height: 40,
                                                          ),
                                                          Image.asset(
                                                            AppImages
                                                                .screenShotImage,
                                                            height: 40,
                                                          ),
                                                        ],
                                                      ),
                                                      const Text(
                                                        '15:29:00',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      )
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Image.asset(
                                                            AppImages
                                                                .screenShotImage,
                                                            height: 40,
                                                          ),
                                                          Image.asset(
                                                            AppImages
                                                                .screenShotImage,
                                                            height: 40,
                                                          ),
                                                        ],
                                                      ),
                                                      const Text(
                                                        '15:29:00',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      )
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Image.asset(
                                                            AppImages
                                                                .screenShotImage,
                                                            height: 40,
                                                          ),
                                                          Image.asset(
                                                            AppImages
                                                                .screenShotImage,
                                                            height: 40,
                                                          ),
                                                        ],
                                                      ),
                                                      const Text(
                                                        '15:29:00',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isExpanded = -1;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.keyboard_arrow_up,
                                        color: AppColors.appPrimaryColor,
                                      )),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink()
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class ChartData {
  ChartData(this.year, this.sales);
  final String year;
  final double sales;
}
