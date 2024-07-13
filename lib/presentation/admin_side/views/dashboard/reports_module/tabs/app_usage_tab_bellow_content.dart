import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_icons.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/helpers/helper_functions.dart';
import 'package:time_tracker/providers/reports_provider.dart';
import 'package:time_tracker/widgets/alert_dialog_widget.dart';
import 'package:time_tracker/widgets/global_divider_widget.dart';
import 'package:time_tracker/widgets/global_text_button.dart';
import 'package:time_tracker/widgets/icon_button_with_label.dart';

class AppUsageTabBellowContent extends StatefulWidget {
  const AppUsageTabBellowContent(
      {super.key,
      required this.usageTabIndex,
      required this.onByUserTap,
      required this.onByAppTap,
      required this.isAdminSide});
  final int usageTabIndex;
  final VoidCallback onByUserTap;
  final VoidCallback onByAppTap;
  final bool isAdminSide;

  @override
  State<AppUsageTabBellowContent> createState() =>
      _AppUsageTabBellowContentState();
}

class _AppUsageTabBellowContentState extends State<AppUsageTabBellowContent> {
  final List<ChartData> chartData = [ChartData(1, 40)];
  final List<ChartData2> chartData2 = [
    ChartData2('Google.com', 25, Colors.orange),
    ChartData2('Pichon', 38, Colors.green),
    ChartData2('Figma', 34, Colors.purple),
    ChartData2('Microsoft', 52, Colors.blue),
    ChartData2('Skype', 45, Colors.red),
    ChartData2('Pichon', 48, Colors.pink),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.white),
          child: Consumer<ReportProvider>(
            builder: (context, reportProvider, child) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    const GlobalDividerWidget(
                      dividerColor: AppColors.appDarkGrey,
                      width: 240,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: widget.onByUserTap,
                              child: Text(
                                'By User',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: widget.usageTabIndex == 0
                                        ? AppColors.appPrimaryColor
                                        : AppColors.appDarkGrey),
                              ),
                            ),
                            // const SizedBox(height: 25),
                            SizedBox(
                                width: 85,
                                child: Divider(
                                  color: widget.usageTabIndex == 0
                                      ? AppColors.appPrimaryColor
                                      : Colors.transparent,
                                ))
                          ],
                        ),
                        const SizedBox(width: 70),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: widget.onByAppTap,
                              child: Text(
                                'By Apps',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: widget.usageTabIndex == 1
                                      ? AppColors.appPrimaryColor
                                      : AppColors.appDarkGrey,
                                ),
                              ),
                            ),
                            SizedBox(
                                width: 85,
                                child: Divider(
                                  color: widget.usageTabIndex == 1
                                      ? AppColors.appPrimaryColor
                                      : Colors.transparent,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                if (widget.usageTabIndex == 1)
                  IconButtonWithLabel(
                      text: 'Download CSV',
                      iconHeight: 14,
                      backgroundColor: AppColors.appPrimaryColor,
                      borderColor: AppColors.appPrimaryColor,
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                      icon: IconImages.download,
                      onTap: () {
                        showDownloadPreviewDialog(context);
                      })
              ],
            ),
          ),
        ),
        const SizedBox(height: 50),
        Consumer<ReportProvider>(
          builder: (context, reportProvider, child) => Container(
              padding: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.white),
              child: widget.usageTabIndex == 0
                  ? Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 45, vertical: 20),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              color: AppColors.appPrimaryColor),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Time Tracking',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Total Use: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    ' 00:00:00',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    padding: const EdgeInsets.only(
                                        top: 30, left: 20, right: 20),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.appDarkGrey),
                                      borderRadius: BorderRadius.circular(15),
                                      // color: Colors.yellow,
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Time Tracking Usage',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 90,
                                            left: 20,
                                          ),
                                          child: SizedBox(
                                            height: 200,
                                            child: SfCartesianChart(
                                                tooltipBehavior:
                                                    TooltipBehavior(
                                                  enable: true,
                                                  activationMode:
                                                      ActivationMode.singleTap,
                                                ),
                                                primaryYAxis: NumericAxis(
                                                  title: AxisTitle(
                                                    text: 'App Users',
                                                  ),
                                                ),
                                                primaryXAxis: CategoryAxis(
                                                    isVisible: false),
                                                series: <ChartSeries>[
                                                  BarSeries<ChartData, double>(
                                                      width: 0.3,
                                                      gradient:
                                                          LinearGradient(colors: [
                                                        AppColors.greenColor,
                                                        AppColors.greenColor
                                                            .withOpacity(0.2)
                                                      ]),
                                                      dataSource: chartData,
                                                      xAxisName: 'App Usage',
                                                      isVisible: true,
                                                      xValueMapper:
                                                          (ChartData data, _) =>
                                                              data.x,
                                                      yValueMapper:
                                                          (ChartData data, _) =>
                                                              data.y,
                                                      borderRadius:
                                                          const BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(30),
                                                              bottomRight:
                                                                  Radius.circular(
                                                                      30)))
                                                ]),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: GlobalTextButton(
                                            text: 'See More',
                                            bachgroundColor: Colors.transparent,
                                            borderColor: AppColors.appDarkGrey,
                                            buttonTextColor:
                                                AppColors.appDarkGrey,
                                            onTap: () {
                                              showDialog(
                                                barrierColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialogWidget(
                                                  title: 'Time Tracking Users',
                                                  contentChild: Column(
                                                    children: [
                                                      SizedBox(
                                                        width: 740,
                                                        height: 300,
                                                        child: SfCartesianChart(
                                                            tooltipBehavior:
                                                                TooltipBehavior(
                                                              enable: true,
                                                              activationMode:
                                                                  ActivationMode
                                                                      .singleTap,
                                                            ),
                                                            primaryYAxis:
                                                                NumericAxis(
                                                              title: AxisTitle(
                                                                text:
                                                                    'App Users',
                                                              ),
                                                            ),
                                                            primaryXAxis:
                                                                CategoryAxis(
                                                              isVisible: false,
                                                            ),
                                                            series: <ChartSeries>[
                                                              BarSeries<ChartData,
                                                                      double>(
                                                                  width: 0.3,
                                                                  gradient:
                                                                      LinearGradient(
                                                                          colors: [
                                                                        AppColors
                                                                            .greenColor,
                                                                        AppColors
                                                                            .greenColor
                                                                            .withOpacity(
                                                                          0.2,
                                                                        )
                                                                      ]),
                                                                  dataSource:
                                                                      chartData,
                                                                  xAxisName:
                                                                      'App Usage',
                                                                  isVisible:
                                                                      true,
                                                                  xValueMapper:
                                                                      (ChartData
                                                                                  data,
                                                                              _) =>
                                                                          data
                                                                              .x,
                                                                  yValueMapper:
                                                                      (ChartData
                                                                                  data,
                                                                              _) =>
                                                                          data
                                                                              .y,
                                                                  borderRadius: const BorderRadius
                                                                      .only(
                                                                      topRight:
                                                                          Radius.circular(
                                                                              30),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              30)))
                                                            ]),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                      ],
                                    ),
                                  )),
                              const SizedBox(width: 20),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15, top: 20),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.appDarkGrey),
                                      borderRadius: BorderRadius.circular(15),
                                      // color: Colors.orange,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'User',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                'Duration',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                            top: 20,
                                            bottom: 15,
                                          ),
                                          child: GlobalDividerWidget(
                                            width: double.infinity,
                                            dividerColor: AppColors.appDarkGrey,
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'james',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.appDarkGrey,
                                                ),
                                              ),
                                              Text(
                                                '00:00:00',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.appDarkGrey,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Kyle',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.appDarkGrey,
                                                ),
                                              ),
                                              Text(
                                                '00:00:00',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.appDarkGrey,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 60, bottom: 20),
                                          child: GlobalDividerWidget(
                                            width: double.infinity,
                                            dividerColor: AppColors.appDarkGrey,
                                          ),
                                        ),
                                        GlobalTextButton(
                                          text: 'See More',
                                          bachgroundColor: Colors.transparent,
                                          borderColor: AppColors.appDarkGrey,
                                          buttonTextColor:
                                              AppColors.appDarkGrey,
                                          onTap: () {
                                            showDialog(
                                              barrierColor: Colors.transparent,
                                              context: context,
                                              builder: (context) =>
                                                  AlertDialogWidget(
                                                title:
                                                    'All Users Of Time Tracking',
                                                contentChild: Column(
                                                  children: [
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'User',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Duration',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        vertical: 15,
                                                      ),
                                                      child:
                                                          GlobalDividerWidget(
                                                        width: double.infinity,
                                                        dividerColor: AppColors
                                                            .appDarkGrey,
                                                      ),
                                                    ),
                                                    ...List.generate(
                                                      3,
                                                      (index) => const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          horizontal: 10,
                                                          vertical: 10,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Kyle',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: AppColors
                                                                    .appDarkGrey,
                                                              ),
                                                            ),
                                                            Text(
                                                              '00:00:00',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: AppColors
                                                                    .appDarkGrey,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 30),
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        )
                      ],
                    )
                  : Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 45,
                            vertical: 20,
                          ),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                15,
                              ),
                              topRight: Radius.circular(
                                15,
                              ),
                            ),
                            color: AppColors.appPrimaryColor,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  AppTexts.jamesWilliams,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Work Time: ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        ' 00:00:00',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    ' - ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Break Time: ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        '00:00:00',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      top: 10,
                                    ),
                                    padding: const EdgeInsets.only(
                                      top: 30,
                                      left: 20,
                                      right: 20,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.appDarkGrey),
                                      borderRadius: BorderRadius.circular(
                                        15,
                                      ),
                                      // color: Colors.yellow,
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Most Used Apps',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                              right: 90,
                                              left: 20,
                                            ),
                                            child: SizedBox(
                                              height: 200,
                                              child: SfCircularChart(
                                                  legend:
                                                      Legend(isVisible: true),
                                                  series: <CircularSeries>[
                                                    DoughnutSeries<ChartData2,
                                                        String>(
                                                      explode: true,
                                                      dataLabelMapper:
                                                          (datum, index) =>
                                                              datum.x,
                                                      dataLabelSettings:
                                                          const DataLabelSettings(
                                                              isVisible: true,
                                                              labelPosition:
                                                                  ChartDataLabelPosition
                                                                      .outside,
                                                              connectorLineSettings:
                                                                  ConnectorLineSettings(
                                                                      // Type of the connector line
                                                                      type: ConnectorType
                                                                          .curve)),
                                                      dataSource: chartData2,
                                                      pointColorMapper:
                                                          (ChartData2 data,
                                                                  _) =>
                                                              data.color,
                                                      xValueMapper:
                                                          (ChartData2 data,
                                                                  _) =>
                                                              data.x,
                                                      yValueMapper:
                                                          (ChartData2 data,
                                                                  _) =>
                                                              data.y,
                                                    )
                                                  ]),
                                            )),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: GlobalTextButton(
                                            text: 'See More',
                                            bachgroundColor: Colors.transparent,
                                            borderColor: AppColors.appDarkGrey,
                                            buttonTextColor:
                                                AppColors.appDarkGrey,
                                            onTap: () {
                                              showDialog(
                                                barrierColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialogWidget(
                                                  title: 'Time Tracking Users',
                                                  contentChild: Column(
                                                    children: [
                                                      SizedBox(
                                                        width: 740,
                                                        height: 300,
                                                        child: SfCircularChart(
                                                            series: <CircularSeries>[
                                                              DoughnutSeries<
                                                                  ChartData2,
                                                                  String>(
                                                                dataLabelMapper:
                                                                    (datum, index) =>
                                                                        datum.x,
                                                                dataLabelSettings:
                                                                    const DataLabelSettings(
                                                                        isVisible:
                                                                            true,
                                                                        labelPosition:
                                                                            ChartDataLabelPosition.outside,
                                                                        connectorLineSettings: ConnectorLineSettings(
                                                                            // Type of the connector line
                                                                            type: ConnectorType.curve)),
                                                                dataSource:
                                                                    chartData2,
                                                                pointColorMapper:
                                                                    (ChartData2 data,
                                                                            _) =>
                                                                        data.color,
                                                                xValueMapper:
                                                                    (ChartData2 data,
                                                                            _) =>
                                                                        data.x,
                                                                yValueMapper:
                                                                    (ChartData2 data,
                                                                            _) =>
                                                                        data.y,
                                                              )
                                                            ]),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  )),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                      top: 10,
                                    ),
                                    padding: const EdgeInsets.only(
                                      left: 15,
                                      right: 15,
                                      top: 20,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.appDarkGrey,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        15,
                                      ),
                                      // color: Colors.orange,
                                    ),
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Apps',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                'Duration',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                            top: 20,
                                            bottom: 15,
                                          ),
                                          child: GlobalDividerWidget(
                                            width: double.infinity,
                                            dividerColor: AppColors.appDarkGrey,
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  'Google.com',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        AppColors.appDarkGrey,
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  '00:00:00',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        AppColors.appDarkGrey,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Skype',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        AppColors.appDarkGrey),
                                              ),
                                              Text(
                                                '00:00:00',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.appDarkGrey,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 60, bottom: 20),
                                          child: GlobalDividerWidget(
                                            width: double.infinity,
                                            dividerColor: AppColors.appDarkGrey,
                                          ),
                                        ),
                                        Wrap(
                                          alignment: WrapAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.start,
                                          runAlignment: WrapAlignment.start,
                                          runSpacing: 15,
                                          spacing: 35,
                                          children: [
                                            GlobalTextButton(
                                              text: 'Show Detailed Log',
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
                                                      AlertDialogWidget(
                                                    title:
                                                        'App Usage Log For Muhammad',
                                                    contentChild: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        IconButtonWithLabel(
                                                            text:
                                                                'Download CSV',
                                                            iconHeight: 14,
                                                            backgroundColor:
                                                                AppColors
                                                                    .appPrimaryColor,
                                                            borderColor: AppColors
                                                                .appPrimaryColor,
                                                            textStyle:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Colors
                                                                        .white),
                                                            icon: IconImages
                                                                .download,
                                                            onTap: () {
                                                              showDialog(
                                                                barrierColor: Colors
                                                                    .transparent,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        AlertDialogWidget(
                                                                  title:
                                                                      'Background Task',
                                                                  contentChild:
                                                                      Column(
                                                                    children: [
                                                                      const Text(
                                                                        'Action In Progress',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                22,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                      const SpinKitSpinningLines(
                                                                          color: AppColors
                                                                              .appPrimaryColor,
                                                                          lineWidth:
                                                                              3,
                                                                          itemCount:
                                                                              10),
                                                                      const SizedBox(
                                                                        width:
                                                                            721,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.symmetric(horizontal: 10),
                                                                          child:
                                                                              Text(
                                                                            'You can safely close this window & continue with other tasks or activities. The background task will continue to execute uninterrupted, & you can check back at any time to see the status & progress of the task.',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w400,
                                                                                color: AppColors.appDarkGrey),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const Padding(
                                                                        padding: EdgeInsets.only(
                                                                            top:
                                                                                15,
                                                                            bottom:
                                                                                30),
                                                                        child:
                                                                            GlobalDividerWidget(
                                                                          dividerColor:
                                                                              AppColors.appDarkGrey,
                                                                          width:
                                                                              double.infinity,
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
                                                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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
                                                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              GlobalTextButton(
                                                                                text: 'Download File',
                                                                                bachgroundColor: Colors.transparent,
                                                                                buttonTextColor: AppColors.appPrimaryColor,
                                                                                onTap: () {},
                                                                              ),
                                                                              const SizedBox(width: 40),
                                                                              IconButton(onPressed: () {}, icon: SvgPicture.asset(IconImages.delete))
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const Padding(
                                                                        padding: EdgeInsets.only(
                                                                            top:
                                                                                15,
                                                                            bottom:
                                                                                30),
                                                                        child:
                                                                            GlobalDividerWidget(
                                                                          dividerColor:
                                                                              AppColors.appDarkGrey,
                                                                          width:
                                                                              double.infinity,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            40,
                                                                        width:
                                                                            105,
                                                                        child:
                                                                            GlobalTextButton(
                                                                          text:
                                                                              AppTexts.close,
                                                                          bachgroundColor:
                                                                              AppColors.appPrimaryColor,
                                                                          buttonTextColor:
                                                                              Colors.white,
                                                                          onTap:
                                                                              () {},
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                        const SizedBox(
                                                            height: 30),
                                                        const Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'URL',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              SizedBox(
                                                                  width: 100),
                                                              Text(
                                                                'Start Time',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              Text(
                                                                'End Time',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              Text(
                                                                'Duration',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        const GlobalDividerWidget(
                                                          width: 740,
                                                          dividerColor:
                                                              AppColors
                                                                  .appDarkGrey,
                                                        ),
                                                        const Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Time Tracking',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: AppColors
                                                                      .appDarkGrey),
                                                            ),
                                                            SizedBox(width: 5),
                                                            Text(
                                                              '08:45 AM',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: AppColors
                                                                      .appDarkGrey),
                                                            ),
                                                            Text(
                                                              '08:45 AM',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: AppColors
                                                                      .appDarkGrey),
                                                            ),
                                                            Text(
                                                              '00:00:00',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: AppColors
                                                                      .appDarkGrey),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                            GlobalTextButton(
                                              text: 'See Full List',
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
                                                      AlertDialogWidget(
                                                    title:
                                                        'All Apps Muhammad Used',
                                                    contentChild: Column(
                                                      children: [
                                                        const Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'App',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              Text(
                                                                'Duration',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        const Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 15),
                                                          child:
                                                              GlobalDividerWidget(
                                                            width:
                                                                double.infinity,
                                                            dividerColor:
                                                                AppColors
                                                                    .appDarkGrey,
                                                          ),
                                                        ),
                                                        ...List.generate(
                                                          3,
                                                          (index) =>
                                                              const Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        10),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  'Google.com',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: AppColors
                                                                          .appDarkGrey),
                                                                ),
                                                                Text(
                                                                  '00:00:00',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: AppColors
                                                                          .appDarkGrey),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 30),
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        )
                      ],
                    )),
        )
      ],
    );
  }
}

class ChartData {
  final double x;
  final int y;

  ChartData(this.x, this.y);
}

class ChartData2 {
  ChartData2(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
