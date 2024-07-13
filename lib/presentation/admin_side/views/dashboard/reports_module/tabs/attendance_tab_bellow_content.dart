import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_icons.dart';
import 'package:time_tracker/constants/app_images.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/helpers/helper_functions.dart';
import 'package:time_tracker/widgets/global_divider_widget.dart';
import 'package:time_tracker/widgets/icon_button_with_label.dart';

class AttendanceTabBellowContent extends StatefulWidget {
  const AttendanceTabBellowContent({super.key});

  @override
  State<AttendanceTabBellowContent> createState() =>
      _AttendanceTabBellowContentState();
}

class _AttendanceTabBellowContentState
    extends State<AttendanceTabBellowContent> {
  final List<ChartData> chartData = [
    ChartData(2010, 35),
    ChartData(2011, 28),
    ChartData(2012, 34),
    ChartData(2013, 32),
    ChartData(2014, 40)
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
                height: 40,
                child: IconButtonWithLabel(
                  icon: IconImages.download,
                  onTap: () {
                    showDownloadPreviewDialog(context);
                  },
                  backgroundColor: AppColors.appPrimaryColor,
                  borderColor: AppColors.appPrimaryColor,
                  text: 'Download Details',
                  iconHeight: 14,
                  textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                )),
            const SizedBox(width: 30),
            SizedBox(
              height: 40,
              child: IconButtonWithLabel(
                backgroundColor: AppColors.appPrimaryColor,
                borderColor: AppColors.appPrimaryColor,
                text: 'Download Overview',
                iconHeight: 14,
                textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
                icon: IconImages.download,
                onTap: () {
                  showDownloadPreviewDialog(context);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        ...List.generate(
            3,
            (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: double.infinity,
                            child: Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              runSpacing: 15,
                              children: [
                                Text(
                                  AppTexts.jamesWilliams,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Wrap(
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Total Work Time: ',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.appDarkGrey,
                                          ),
                                        ),
                                        Text(
                                          '00:00:00',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.appPrimaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 100,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Total Break Time: ',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.appDarkGrey,
                                          ),
                                        ),
                                        Text(
                                          '00:00:00',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.appPrimaryColor,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          const Padding(
                            padding:
                                EdgeInsetsDirectional.symmetric(vertical: 20),
                            child: GlobalDividerWidget(
                              width: double.infinity,
                              dividerColor: AppColors.appDarkGrey,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                  right: 100,
                                ),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundImage: AssetImage(
                                        AppImages.profileImage,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      AppTexts.jamesWilliams,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
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
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 55,
                                  width: double.infinity,
                                  child: SfCartesianChart(
                                      plotAreaBorderWidth: 2,
                                      primaryXAxis: NumericAxis(
                                        isVisible: true,
                                        majorGridLines: const MajorGridLines(
                                          width: 0,
                                        ),
                                        minorGridLines: const MinorGridLines(
                                          width: 0,
                                        ),
                                      ),
                                      primaryYAxis: NumericAxis(
                                        isVisible: false,
                                      ),
                                      margin: EdgeInsets.zero,
                                      series: <ChartSeries>[
                                        AreaSeries<ChartData, int>(
                                            color: AppColors.greenColor,
                                            gradient: LinearGradient(
                                                colors: <Color>[
                                                  AppColors.greenColor
                                                      .withOpacity(0.3),
                                                  AppColors.greenColor
                                                ],
                                                stops: const <double>[
                                                  0.2,
                                                  0.8
                                                ],
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter),
                                            dataSource: chartData,
                                            xValueMapper: (ChartData data, _) =>
                                                data.x,
                                            yValueMapper: (ChartData data, _) =>
                                                data.y,
                                            dataLabelSettings:
                                                const DataLabelSettings(
                                                    isVisible: false)),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: GlobalDividerWidget(
                              width: double.infinity,
                              dividerColor: AppColors.appDarkGrey,
                            ),
                          ),
                          const SizedBox(
                            width: 500,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Started At: ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      '08:30',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.appPrimaryColor),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Finished At: ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      '08:30',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.appPrimaryColor),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ))
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}
