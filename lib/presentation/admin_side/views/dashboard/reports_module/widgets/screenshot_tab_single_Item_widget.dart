import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_icons.dart';
import 'package:time_tracker/helpers/media_query_helper.dart';
import 'package:time_tracker/widgets/alert_dialog_widget.dart';
import 'package:time_tracker/widgets/app_checkbox.dart';
import 'package:time_tracker/widgets/icon_button_with_label.dart';

class ScreenShotSingleItemWidget extends StatefulWidget {
  const ScreenShotSingleItemWidget({
    super.key,
    required this.selectedImages,
    required this.itemDate,
    required this.startDate,
    required this.endDate,
    required this.time,
    required this.onCheckBox,
  });

  final Set<int> selectedImages;
  final String itemDate;
  final String startDate;
  final String endDate;
  final String time;
  final Function(int) onCheckBox;

  @override
  State<ScreenShotSingleItemWidget> createState() =>
      _ScreenShotSingleItemWidgetState();
}

class _ScreenShotSingleItemWidgetState
    extends State<ScreenShotSingleItemWidget> {
  ScrollController scrollController = ScrollController();

  List<String> images = [];
  int selectedImage = 0;
  @override
  void initState() {
    images = List.generate(21, (index) => "assets/dummy/a (${index + 1}).jpg");
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
    scrollController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 40,
            bottom: 20,
          ),
          child: Text(
            widget.itemDate,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            top: 30,
            bottom: 30,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              15,
            ),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                ),
                child: Row(
                  children: [
                    Text(
                      widget.startDate,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'to',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      widget.endDate,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 30,
                          right: 30,
                        ),
                        child: RawScrollbar(
                          controller: scrollController,
                          interactive: true,
                          thumbColor: AppColors.appDarkGrey.withOpacity(0.3),
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            controller: scrollController,
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.only(bottom: 15),
                            itemCount: images.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  right: 20,
                                ),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        selectedImage = index;
                                        setState(() {});
                                        showDialog(
                                          barrierColor: Colors.transparent,
                                          context: context,
                                          builder: (context) => StatefulBuilder(
                                            builder: (context, setState1) =>
                                                AlertDialog(
                                              backgroundColor:
                                                  Colors.transparent,
                                              contentPadding: EdgeInsets.zero,
                                              content: SizedBox(
                                                height: context.h * 0.50,
                                                width: context.w * 0.45,
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 20) +
                                                          const EdgeInsets.only(
                                                              bottom: 45),
                                                      child: Image.asset(
                                                        images[selectedImage],
                                                        fit: BoxFit.cover,
                                                        height:
                                                            context.h * 0.50,
                                                        width: context.w * 0.45,
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        IconButton(
                                                            style: IconButton.styleFrom(
                                                                disabledBackgroundColor:
                                                                    AppColors
                                                                        .appDarkGrey
                                                                        .withOpacity(
                                                                            0.3),
                                                                backgroundColor:
                                                                    AppColors
                                                                        .appPrimaryColor),
                                                            onPressed:
                                                                selectedImage ==
                                                                        0
                                                                    ? null
                                                                    : () {
                                                                        if (selectedImage ==
                                                                            0) {
                                                                          selectedImage =
                                                                              0;

                                                                          setState1(
                                                                              () {});
                                                                        } else if (selectedImage >
                                                                            0) {
                                                                          selectedImage--;

                                                                          setState1(
                                                                              () {});
                                                                        }
                                                                      },
                                                            icon: const Icon(
                                                              Icons
                                                                  .keyboard_arrow_left,
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                        IconButton(
                                                            style: IconButton.styleFrom(
                                                                disabledBackgroundColor: AppColors
                                                                    .appDarkGrey
                                                                    .withOpacity(
                                                                        0.3),
                                                                backgroundColor:
                                                                    AppColors
                                                                        .appPrimaryColor),
                                                            onPressed:
                                                                selectedImage ==
                                                                        images.length -
                                                                            1
                                                                    ? null
                                                                    : () {
                                                                        if (selectedImage ==
                                                                            images
                                                                                .length) {
                                                                          selectedImage =
                                                                              images.length;

                                                                          setState1(
                                                                              () {});
                                                                        } else if (selectedImage <
                                                                            images.length -
                                                                                1) {
                                                                          selectedImage++;

                                                                          setState1(
                                                                              () {});
                                                                        }
                                                                      },
                                                            icon: const Icon(
                                                              Icons
                                                                  .keyboard_arrow_right,
                                                              color:
                                                                  Colors.white,
                                                            ))
                                                      ],
                                                    ),
                                                    Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 20),
                                                        child: Container(
                                                          width:
                                                              context.w * 0.45,
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 5,
                                                                  horizontal:
                                                                      20),
                                                          color: AppColors
                                                              .appPrimaryColor
                                                              .withOpacity(0.5),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              const Row(
                                                                children: [
                                                                  Text(
                                                                    '24, May 2023',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          20),
                                                                  Text(
                                                                    '13:00 PM',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: Colors
                                                                            .white),
                                                                  )
                                                                ],
                                                              ),
                                                              IconButtonWithLabel(
                                                                  text:
                                                                      'Download',
                                                                  icon: IconImages
                                                                      .downloadArrowDown,
                                                                  iconHeight:
                                                                      11,
                                                                  backgroundColor:
                                                                      AppColors
                                                                          .appPrimaryColor,
                                                                  borderColor:
                                                                      AppColors
                                                                          .appPrimaryColor,
                                                                  iconColor:
                                                                      Colors
                                                                          .white,
                                                                  onTap: () {})
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      child: SizedBox(
                                        height: 140,
                                        width: 202,
                                        child: Image.asset(
                                          images[index],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 202,
                                      decoration: BoxDecoration(
                                          color: AppColors.appPrimaryColor
                                              .withOpacity(0.25),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Row(
                                        children: [
                                          AppCheckbox(
                                            checkbox: widget.selectedImages
                                                    .contains(index)
                                                ? true
                                                : false,
                                            onValueChanged: (value) {
                                              widget.onCheckBox(index);
                                              if (widget.selectedImages
                                                  .contains(index)) {
                                                widget.selectedImages
                                                    .remove(index);
                                                setState(() {});
                                              } else {
                                                widget.selectedImages
                                                    .add(index);
                                                setState(() {});
                                              }
                                            },
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            widget.time,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      )),
                  if (scrollController.hasClients)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Transform.translate(
                            offset: const Offset(0, 0),
                            child: IconButton(
                                style: IconButton.styleFrom(
                                    disabledBackgroundColor:
                                        AppColors.appDarkGrey.withOpacity(0.3),
                                    backgroundColor: AppColors.appPrimaryColor),
                                onPressed: (scrollController.offset == 0)
                                    ? null
                                    : () {
                                        scrollController.animateTo(
                                          scrollController.offset -
                                              (context.w * 0.4),
                                          duration:
                                              const Duration(milliseconds: 100),
                                          curve: Curves.ease,
                                        );
                                      },
                                icon: const Icon(
                                  Icons.keyboard_arrow_left,
                                  color: Colors.white,
                                )),
                          ),
                          Transform.translate(
                            offset: const Offset(0, 0),
                            child: IconButton(
                                style: IconButton.styleFrom(
                                    disabledBackgroundColor:
                                        AppColors.appDarkGrey.withOpacity(0.3),
                                    backgroundColor: AppColors.appPrimaryColor),
                                onPressed: (scrollController.offset ==
                                        scrollController
                                            .position.maxScrollExtent)
                                    ? null
                                    : () {
                                        print(scrollController.offset +
                                            (context.w * 0.4));
                                        scrollController.animateTo(
                                          scrollController.offset +
                                              (context.w * 0.4),
                                          duration:
                                              const Duration(milliseconds: 100),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                icon: const Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.white,
                                )),
                          )
                        ],
                      ),
                    )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
