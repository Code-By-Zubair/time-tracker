import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_tracker/helpers/helper_functions.dart';
import 'package:time_tracker/models/user_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_icons.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/helpers/media_query_helper.dart';
import 'package:time_tracker/providers/shared_pref_provider.dart';
import 'package:time_tracker/providers/user_dash_board_provider.dart';
import 'package:time_tracker/widgets/dashboard_main_screen_chart_container_widget.dart';
import 'package:time_tracker/widgets/global_appbar_with_profile.dart';
import 'package:time_tracker/widgets/global_divider_widget.dart';

class DashBoardMainScreenUserSide extends StatefulWidget {
  const DashBoardMainScreenUserSide({super.key});

  @override
  State<DashBoardMainScreenUserSide> createState() =>
      _DashBoardMainScreenUserSide();
}

class _DashBoardMainScreenUserSide extends State<DashBoardMainScreenUserSide> {
  DateTime? pickedDate;
  String formattedDate = '';
  pickDateNow() async {
    pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    SharedPrefProvider().getPrefData();
  }

  @override
  Widget build(BuildContext context) {
    final userDashBoardProvider =
        Provider.of<UserDashBoardProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30, left: 50, right: 50, bottom: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              GlobalAppBarWithProfile(
                showTitle: false,
                title: '',
                onStartBtn: () => userDashBoardProvider.startTimer(),
                onFinishBtn: () => userDashBoardProvider.stopTimer(),
                onMenuTap: () => userDashBoardProvider.expandDrawerFunc(),
                onBreakBtn: () => userDashBoardProvider.startBreakTimer(),
                isSearchfieldShow: true,
                cursorHeight: 20,
                hintText: 'Search',
                showStartFinishRightMarg: 10,
                workTodayRightPad: context.w * 0.02,
              ),
              const SizedBox(height: 20),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(Provider.of<SharedPrefProvider>(context, listen: false)
                            .data
                            ?.email ??
                        '')
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    UserModel user =
                        UserModel.fromJson(snapshot.data.data() ?? {});
                    return Text(
                      '${getGreeting()} ${user.firstName ?? ''} ${user.lastName ?? ''}',
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: AppColors.appDarkGrey),
                    );
                  }
                  return const CircularProgressIndicator(
                    color: AppColors.appPrimaryColor,
                  );
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    AppTexts.dashboard,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        formattedDate,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: AppColors.appLightGrey),
                      ),
                      const SizedBox(width: 5),
                      IconButton(
                          onPressed: () async {
                            pickDateNow();
                            if (pickedDate != null) {
                              setState(() {
                                formattedDate =
                                    DateFormat.yMMMMd().format(pickedDate!);
                              });
                              setState(() {});
                            } else {
                              print("Date is not selected");
                            }
                          },
                          icon: SvgPicture.asset(IconImages.calender)),
                      IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(IconImages.previous)),
                      IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(IconImages.next)),
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: IconButton(
                            style: IconButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                padding: const EdgeInsets.all(0),
                                backgroundColor:
                                    AppColors.appPrimaryColor.withOpacity(0.2)),
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              IconImages.detail,
                            )),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Container(
                    height: 260,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              color: AppColors.appPrimaryColor),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                IconImages.organizationBoxy,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Flexible(
                                child: Text(
                                  AppTexts.organization,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    IconImages.radar,
                                    height: 15,
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  const Flexible(
                                    child: Text(
                                      AppTexts.timeTracking,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    IconImages.timeZone,
                                    height: 15,
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  const Flexible(
                                    child: Text(
                                      'Time Zone: ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.appDarkGrey),
                                    ),
                                  ),
                                  const Flexible(
                                    child: Text(
                                      'Asia/Karachi',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    IconImages.organizationBoxy,
                                    color: AppColors.appPrimaryColor,
                                    height: 15,
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  const Flexible(
                                    child: Text(
                                      'Organization Time',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    IconImages.clock,
                                    color: AppColors.appPrimaryColor,
                                    height: 15,
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  const Flexible(
                                    child: Text(
                                      '10:09 AM',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.appDarkGrey,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
                  const SizedBox(width: 40),
                  Expanded(
                      child: Container(
                    height: 260,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              color: AppColors.appPrimaryColor),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                IconImages.workTrackingUser,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Flexible(
                                child: Text(
                                  'Work Tracking',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: context.w * 0.01, top: 40),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                IconImages.locationWithCircle,
                                color: AppColors.appPrimaryColor,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Flexible(
                                child: Text(
                                  'Tracking Mode: ',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Flexible(
                                child: Text(
                                  'Automatic',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                          child: GlobalDividerWidget(
                            width: double.infinity,
                            dividerColor:
                                AppColors.appDarkGrey.withOpacity(0.2),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: context.w * 0.025),
                          child: const Text(
                            'Tracking has been Stopped',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.appDarkGrey,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: context.w * 0.025),
                          child: const Text(
                            'No data is being collected',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.appDarkGrey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                  const SizedBox(width: 40),
                  Expanded(
                      child: Container(
                    height: 260,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                            top: 20,
                            bottom: 20,
                            left: 20,
                          ),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              color: AppColors.appPrimaryColor),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                IconImages.workTrackingUser,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Flexible(
                                child: Text(
                                  'Synchronization to the cloud',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 40, left: context.w * 0.01),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                IconImages.reload,
                                height: 15,
                                color: Colors.orange,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Flexible(
                                child: Text(
                                  'Last synced to the cloud:',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: context.w * 0.027),
                          child: const Text(
                            'May 29, 2023 10:15:28',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.appDarkGrey,
                            ),
                          ),
                        ),
                        GlobalDividerWidget(
                          width: double.infinity,
                          dividerColor: AppColors.appDarkGrey.withOpacity(0.2),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: context.w * 0.027,
                          ),
                          child: const Text(
                            'Tracking data is in sync.',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
              const SizedBox(height: 30),
              DashBoardMainScreenChartContainerWidget(
                chart: SfCartesianChart(
                    primaryYAxis: NumericAxis(
                      labelStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    primaryXAxis: CategoryAxis(
                      labelStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    legend: const Legend(isVisible: false),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <ChartSeries<GraphData, String>>[
                      LineSeries<GraphData, String>(
                          markerSettings: const MarkerSettings(
                            shape: DataMarkerType.circle,
                            isVisible: true,
                          ),
                          color: AppColors.appPrimaryColor,
                          dataSource: createRandomData(),
                          xValueMapper: (GraphData sales, _) => sales.time,
                          yValueMapper: (GraphData sales, _) => sales.value,
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: false)),
                      LineSeries<GraphData, String>(
                          markerSettings: const MarkerSettings(
                            shape: DataMarkerType.circle,
                            isVisible: true,
                          ),
                          dataSource: createRandomData(),
                          color: AppColors.purpleColor,
                          xValueMapper: (GraphData sales, _) => sales.time,
                          yValueMapper: (GraphData sales, _) => sales.value,
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: false)),
                      LineSeries<GraphData, String>(
                          markerSettings: const MarkerSettings(
                            shape: DataMarkerType.circle,
                            isVisible: true,
                          ),
                          color: Colors.blue,
                          dataSource: createRandomData(),
                          xValueMapper: (GraphData sales, _) => sales.time,
                          yValueMapper: (GraphData sales, _) => sales.value,
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: false)),
                    ]),
                showButton: true,
                title: 'Last 30 days',
                icon: IconImages.threeBar,
                // chartImage: AppImages.productivityBarImage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GraphData {
  GraphData(this.time, this.value);

  final String time;
  final double value;
}

List<GraphData> createRandomData() {
  return List.generate(10, (index) {
    final time = DateFormat('HH a')
        .format(DateTime.now().subtract(Duration(hours: index)));
    return GraphData(time.toString(),
        Random().nextInt(50).toDouble() + Random().nextInt(50).toDouble());
  }).reversed.toList();
}

// List<int> createRandomIntData() =>
//     List.generate(15, (index) => Random().nextInt(50) + Random().nextInt(50));
