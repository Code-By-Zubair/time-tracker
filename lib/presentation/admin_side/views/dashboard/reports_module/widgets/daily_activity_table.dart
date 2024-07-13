import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_image_stack/flutter_image_stack.dart';
import 'package:flutter_svg/svg.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_icons.dart';
import 'package:time_tracker/constants/app_images.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/widgets/global_text_button.dart';

class DailyActivityTable extends StatefulWidget {
  const DailyActivityTable({
    Key? key,
    this.scrollController,
    this.childScrollController,
    required this.textController,
    required this.tableRowsList,
    required this.firstHeading,
    required this.secondHeading,
    required this.thirdHeading,
    required this.fourthHeading,
    this.firstHeaderWidth,
    this.secondHeaderWidth,
    this.thirdHeaderWidth,
    this.fourthHeaderWidth,
    this.firstRowWidth,
    this.secondRowWidth,
    this.thirdRowWidth,
    this.fourthRowWidth,
  }) : super(key: key);

  final ScrollController? scrollController;
  final ScrollController? childScrollController;

  final TextEditingController textController;
  final List tableRowsList;
  final String firstHeading;
  final String secondHeading;
  final String thirdHeading;
  final String fourthHeading;

  //header width
  final double? firstHeaderWidth;
  final double? secondHeaderWidth;
  final double? thirdHeaderWidth;
  final double? fourthHeaderWidth;

  //rows widht
  final double? firstRowWidth;
  final double? secondRowWidth;
  final double? thirdRowWidth;
  final double? fourthRowWidth;

  @override
  State<DailyActivityTable> createState() => _DailyActivityTableState();
}

class _DailyActivityTableState extends State<DailyActivityTable> {
  final List<String> images = [
    AppImages.profileImage,
    AppImages.profileImage,
    AppImages.profileImage,
    AppImages.profileImage,
    AppImages.profileImage,
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Table(
          columnWidths: {
            0: widget.firstHeaderWidth != null
                ? FlexColumnWidth(widget.firstHeaderWidth!)
                : const FlexColumnWidth(),
            1: widget.secondHeaderWidth != null
                ? FlexColumnWidth(widget.secondHeaderWidth!)
                : const FlexColumnWidth(),
            2: widget.thirdHeaderWidth != null
                ? FlexColumnWidth(widget.thirdHeaderWidth!)
                : const FlexColumnWidth(),
            3: widget.fourthHeaderWidth != null
                ? FlexColumnWidth(widget.fourthHeaderWidth!)
                : const FlexColumnWidth(),
          },
          children: [
            TableRow(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(
                          color: AppColors.appLightGrey, width: 1.5))),
              //return table row in every loop
              children: [
                //table cells inside table row
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 15,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.firstHeading,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),

                        // size: 10,
                      ),
                    ),
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 3,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.secondHeading,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),

                        // size: 10,
                      ),
                    ),
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 3,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.thirdHeading,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),

                        // size: 10,
                      ),
                    ),
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 5,
                    ),
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 3,
                      right: 15,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.fourthHeading,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),

                        // size: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          // height: 400.h,
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: NotificationListener(
            onNotification: (scrollState) {
              if (scrollState is ScrollEndNotification &&
                  scrollState.metrics.pixels ==
                      scrollState.metrics.maxScrollExtent) {
                // Future.delayed(const Duration(milliseconds: 100), () {})
                //     .then((s) {
                widget.scrollController!.animateTo(
                    // 160,
                    widget.scrollController!.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 1200),
                    curve: Curves.easeOut);
                // });
              } else if (scrollState is ScrollStartNotification) {
                if (scrollState.metrics.pixels ==
                    scrollState.metrics.minScrollExtent) {
                  log("reached top");
                  widget.scrollController?.animateTo(
                    300,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                  );
                }
              }
              return false;
            },

            // (ScrollNotification notification) {
            //   if (notification is ScrollUpdateNotification) {
            //     if (notification.metrics.pixels ==
            //         notification.metrics.maxScrollExtent) {
            //       log("reached bottom");
            //       widget.scrollController?.animateTo(
            //         widget.scrollController!.position.maxScrollExtent,
            //         duration: const Duration(seconds: 2),
            //         curve: Curves.easeOut,
            //       );
            //     } else if (notification.metrics.pixels ==
            //         notification.metrics.minScrollExtent) {
            //       log("reached to TOP");
            //       widget.scrollController?.animateTo(
            //         widget.scrollController!.position.minScrollExtent,
            //         duration: const Duration(seconds: 3),
            //         curve: Curves.easeIn,
            //       );
            //     }
            //   }
            //   return true;
            // },

            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              controller: widget.childScrollController,
              child: Table(
                columnWidths: {
                  0: widget.firstRowWidth != null
                      ? FlexColumnWidth(widget.firstRowWidth!)
                      : const FlexColumnWidth(),
                  1: widget.secondRowWidth != null
                      ? FlexColumnWidth(widget.secondRowWidth!)
                      : const FlexColumnWidth(),
                  2: widget.thirdRowWidth != null
                      ? FlexColumnWidth(widget.thirdRowWidth!)
                      : const FlexColumnWidth(),
                  3: widget.fourthRowWidth != null
                      ? FlexColumnWidth(widget.fourthRowWidth!)
                      : const FlexColumnWidth(),
                },

                //if data is loaded then show table
                children: List<TableRow>.generate(
                  5, //widget.tableRowsList.length
                  (index) =>
                      //display data dynamically from namelist List.
                      TableRow(
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                    ),
                    //return table row in every loop
                    children: [
                      //table cells inside table row
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 10, bottom: 10),
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
                        // Container(
                        //   margin: const EdgeInsets.symmetric(
                        //       vertical: 2, horizontal: 5),
                        //   padding: const EdgeInsets.only(
                        //     top: 10,
                        //     bottom: 10,
                        //     left: 15,
                        //   ),
                        //   child: Text(
                        //     widget.tableRowsList[index].name.toString(),
                        //     style: const TextStyle(
                        //       color: Colors.orange,
                        //       fontWeight: FontWeight.w500,
                        //     ),

                        //     // size: 10,
                        //   ),
                        // ),
                      ),
                      TableCell(
                        // verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: FlutterImageStack(
                            imageList: images,
                            itemBorderColor: Colors.transparent,
                            itemBorderWidth: 0,
                            imageSource: ImageSource.asset,
                            totalCount: images.length,
                            showTotalCount: false,
                            itemCount: images.length,
                            itemRadius: 10,
                          ),
                        ),
                        // Container(
                        //     margin: const EdgeInsets.symmetric(
                        //       vertical: 2,
                        //       horizontal: 5,
                        //     ),
                        //     padding: EdgeInsets.only(
                        //       top: widget.tableRowsList[index].name
                        //               .contains('Total')
                        //           ? 10
                        //           : 0,
                        //       bottom: widget.tableRowsList[index].name
                        //               .contains('Total')
                        //           ? 10
                        //           : 0,
                        //       left: 3,
                        //     ),
                        //     child: widget.tableRowsList[index].name
                        //             .contains('Total')
                        //         ? Text(
                        //             widget.tableRowsList[index].amount ?? '0',
                        //             style: const TextStyle(
                        //               color: Colors.orange,
                        //               fontWeight: FontWeight.w500,
                        //             ),

                        //             // size: 10,
                        //           )
                        //         : Container(
                        //             color: Colors.orange,
                        //             height: 20,
                        //           )),
                      ),
                      const TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            '00:00:04',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.appDarkGrey),
                          ),
                        ),
                        // Container(
                        //     margin: const EdgeInsets.symmetric(
                        //         vertical: 2, horizontal: 5),
                        //     padding: const EdgeInsets.only(
                        //       top: 10,
                        //       bottom: 10,
                        //       left: 3,
                        //     ),
                        //     child: Text(
                        //       widget.tableRowsList[index].monthly ?? '0',
                        //       style: const TextStyle(
                        //         color: Colors.orange,
                        //         fontWeight: FontWeight.w500,
                        //       ),

                        //       // size: 10,
                        //     )),
                      ),
                      const TableCell(
                          child: GlobalTextButton(
                        text: 'See By Users',
                        bachgroundColor: Colors.transparent,
                        borderColor: AppColors.appPrimaryColor,
                        buttonTextColor: AppColors.appPrimaryColor,
                      )
                          //  Container(
                          //     margin: const EdgeInsets.symmetric(
                          //         vertical: 2, horizontal: 5),
                          //     padding: const EdgeInsets.only(
                          //       top: 10,
                          //       bottom: 10,
                          //       left: 3,
                          //       right: 15,
                          //     ),
                          //     child: Text(
                          //       widget.tableRowsList[index].year.toString(),
                          //       style: const TextStyle(
                          //         color: Colors.orange,
                          //         fontWeight: FontWeight.w500,
                          //       ),

                          //       // size: 10,
                          //     )),
                          ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


/// use in your  widget

// Padding(
//            padding: EdgeInsets.only(
//           left:
//            14.w,
//            right:
//            14.w),
//             child:
//                DailyActivityTable(
//                   childScrollController:childScrollController,
//                    scrollController:_parentScrollController,
//                    textController:controller.amountController,
//                   firstHeading: 'Head',
//                   secondHeading: 'Amount (\$)',
//                    thirdHeading:'${controller.dailyActivityList[0].month} (\$)',
//                    fourthHeading:'${controller.dailyActivityList[0].year}-Total (\$)',
//                    tableRowsList:controller.dailyActivityList[0].data,
//                    firstHeaderWidth: 1.2,
//                    firstRowWidth:1.2,
//                    secondHeaderWidth: 0.8,
//                   secondRowWidth: 0.8,
//                  ),
// )