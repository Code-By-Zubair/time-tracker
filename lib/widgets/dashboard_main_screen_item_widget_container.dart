import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/helpers/media_query_helper.dart';

class DashBoardMainScreenItemWidgetContainer extends StatelessWidget {
  DashBoardMainScreenItemWidgetContainer({
    super.key,
    required this.itemText,
    required this.icon,
    required this.text,
    required this.graphImage,
    required this.textColor,
    required this.graphColor,
  });
  final String itemText;
  final String icon;
  final String text;
  final String graphImage;
  final Color textColor;
  final Color graphColor;

  final List<ChartData> chartData = [
    ChartData(2010, 35),
    ChartData(2011, 28),
    ChartData(2012, 34),
    ChartData(2013, 32),
    ChartData(2014, 40)
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 135,
        minWidth: 241,
      ),
      // width: context.w < 900 ? context.w * 0.32 : context.w * 0.12,
      width: context.w < 900
          ? context.w * 0.001
          : context.w > 900 && context.w < 1700
              ? context.w * 0.17
              : context.w * 0.17,
      height: context.h * 0.15,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itemText, //
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              SvgPicture.asset(
                icon,
                height: 30,
                color: AppColors.appLightGrey,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text, //
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 24,
                      color: textColor), //Colors.green
                ),
                // const SizedBox(width: 20),
                SizedBox(
                  height: 35,
                  width: 90,
                  child: SfCartesianChart(
                      plotAreaBorderWidth: 0,
                      primaryXAxis: NumericAxis(
                        isVisible: false,
                      ),
                      primaryYAxis: NumericAxis(
                        isVisible: false,
                      ),
                      margin: EdgeInsets.zero,
                      series: <ChartSeries>[
                        AreaSeries<ChartData, int>(
                            color: graphColor,
                            dataSource: chartData,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: false)),
                      ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}
