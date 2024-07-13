import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_icons.dart';
import 'package:time_tracker/constants/app_images.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/helpers/helper_functions.dart';
import 'package:time_tracker/helpers/media_query_helper.dart';
import 'package:time_tracker/models/user_model.dart';
import 'package:time_tracker/providers/dash_board_provider.dart';
import 'package:time_tracker/providers/shared_pref_provider.dart';
import 'package:time_tracker/providers/user_dash_board_provider.dart';
import 'package:time_tracker/widgets/dashboard_main_screen_chart_container_widget.dart';
import 'package:time_tracker/widgets/dashboard_main_screen_item_widget_container.dart';
import 'package:time_tracker/widgets/global_appbar_with_profile.dart';

class DashboardMainContentScreen extends StatefulWidget {
  const DashboardMainContentScreen({super.key});

  @override
  State<DashboardMainContentScreen> createState() =>
      _DashboardMainContentScreenState();
}

class _DashboardMainContentScreenState
    extends State<DashboardMainContentScreen> {
  List<GraphData> data = [
    GraphData('Jan', 35),
    GraphData('Feb', 28),
    GraphData('Mar', 34),
    GraphData('Apr', 32),
    GraphData('May', 40)
  ];
  List<GraphData> data1 = [
    GraphData('Jan', 34),
    GraphData('Feb', 33),
    GraphData('Mar', 6),
    GraphData('Apr', 87),
    GraphData('May', 65)
  ];
  List<ChartSampleData> barChartData = <ChartSampleData>[
    ChartSampleData('Google', 0.541),
    ChartSampleData('Youtube', 0.818),
    ChartSampleData('Figma', 1.51),
  ];
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
  Widget build(BuildContext context) {
    final userDashBoardProvider =
        Provider.of<UserDashBoardProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30, left: 50, right: 50, bottom: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Consumer<DashBoardProvider>(
                builder: (context, dashBoardProvider, child) =>
                    GlobalAppBarWithProfile(
                  showTitle: false,
                  title: '',
                  onStartBtn: () => userDashBoardProvider.startTimer(),
                  onFinishBtn: () => userDashBoardProvider.stopTimer(),
                  onBreakBtn: () => userDashBoardProvider.startBreakTimer(),
                  onMenuTap: () => dashBoardProvider.expandDrawerFunc(),
                  isSearchfieldShow: true,
                  cursorHeight: 20,
                  hintText: 'Search',
                  showStartFinishRightMarg: 10,
                  workTodayRightPad: context.w * 0.02,
                ),
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
                        color: AppColors.appDarkGrey,
                      ),
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
              SizedBox(
                width: context.w,
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  direction: Axis.horizontal,
                  runSpacing: 20,
                  children: [
                    DashBoardMainScreenItemWidgetContainer(
                      text: '4:16 PM',
                      itemText: AppTexts.productiveTime,
                      icon: IconImages.userWithTime,
                      graphImage: AppImages.greenGraphImage,
                      textColor: AppColors.greenColor,
                      graphColor: AppColors.greenColor,
                    ),
                    DashBoardMainScreenItemWidgetContainer(
                      text: '13.05%',
                      itemText: AppTexts.effectiveness,
                      icon: IconImages.userWithCross,
                      graphImage: AppImages.greenGraphImage,
                      textColor: AppColors.redColor,
                      graphColor: AppColors.redColor,
                    ),
                    DashBoardMainScreenItemWidgetContainer(
                      text: '50',
                      itemText: AppTexts.screenShots,
                      icon: IconImages.screenshot,
                      graphImage: AppImages.greenGraphImage,
                      textColor: AppColors.greenColor,
                      graphColor: AppColors.greenColor,
                    ),
                    DashBoardMainScreenItemWidgetContainer(
                      text: '36GB',
                      itemText: AppTexts.internetUsage,
                      icon: IconImages.globeWithArrow,
                      graphImage: AppImages.greenGraphImage,
                      textColor: AppColors.greenColor,
                      graphColor: AppColors.greenColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              DashBoardMainScreenChartContainerWidget(
                chart: SfCartesianChart(
                    primaryYAxis: NumericAxis(
                        majorGridLines: const MajorGridLines(
                            width: 0.5, dashArray: [10, 2]),
                        isVisible: true,
                        labelStyle: const TextStyle(
                          color: Colors.transparent,
                          fontSize: 0,
                        )),
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
                          dataLabelSettings: const DataLabelSettings(
                            isVisible: false,
                          )),
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
                title: AppTexts.productivityBar,
                icon: IconImages.threeBar,
              ),
              const SizedBox(height: 30),
              DashBoardMainScreenChartContainerWidget(
                chart: SizedBox(
                    height: 200,
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(
                        majorGridLines: const MajorGridLines(
                            width: 0.5, dashArray: [10, 2]),
                      ),
                      primaryYAxis: NumericAxis(
                          majorGridLines: const MajorGridLines(
                              width: 0.5, dashArray: [10, 2]),
                          isVisible: true,
                          labelStyle: const TextStyle(
                            color: Colors.transparent,
                            fontSize: 0,
                          )),
                      series: [
                        ColumnSeries(
                          color: AppColors.appPrimaryColor,
                          width: 0.1,
                          spacing: 0.1,
                          dataSource: barChartData,
                          xValueMapper: (ChartSampleData sales, _) =>
                              sales.appName,
                          yValueMapper: (ChartSampleData sales, _) =>
                              sales.value,
                        ),
                      ],
                    )),
                showButton: false,
                title: AppTexts.appUsage,
                icon: IconImages.appUsage,
              ),
              // const SizedBox(height: 30),
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
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: false,
                      ),
                    ),
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
                  ],
                ),
                showButton: false,
                title: AppTexts.internetCharts,
                icon: IconImages.threeBar,
              ),
              const SizedBox(height: 30),
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

class ChartSampleData {
  final String appName;
  final double value;

  ChartSampleData(this.appName, this.value);
}

List<GraphData> createRandomData() {
  return List.generate(10, (index) {
    final time = DateFormat('HH a')
        .format(DateTime.now().subtract(Duration(hours: index)));
    return GraphData(time.toString(),
        Random().nextInt(50).toDouble() + Random().nextInt(50).toDouble());
  }).reversed.toList();
}

List<int> createRandomIntData() =>
    List.generate(15, (index) => Random().nextInt(50) + Random().nextInt(50));
