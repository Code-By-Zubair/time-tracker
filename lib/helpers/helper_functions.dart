import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_icons.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/helpers/media_query_helper.dart';
import 'package:time_tracker/widgets/alert_dialog_widget.dart';
import 'package:time_tracker/widgets/global_divider_widget.dart';
import 'package:time_tracker/widgets/global_text_button.dart';

moveList(String scrollPosition, ScrollController scrollController) {
  scrollController.animateTo(
    scrollPosition == 'start'
        ? scrollController.position.minScrollExtent
        : scrollController.position.maxScrollExtent,
    duration: const Duration(seconds: 1),
    curve: Curves.easeInToLinear,
  );
}

String formatDate(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd').format(dateTime.toLocal());
}

Future<DateTimeRange?> selectDateRange(BuildContext context) async {
  final picked = await showDateRangePicker(
    context: context,
    firstDate: DateTime(2022),
    lastDate: DateTime(2023),
    builder: (context, child) => Padding(
      padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.15, vertical: context.h * 0.10),
      child: child,
    ),
  );
  return picked;
}

showDownloadPreviewDialog(BuildContext context) {
  showDialog(
    barrierColor: Colors.transparent,
    context: context,
    builder: (context) => AlertDialogWidget(
      title: 'Background Task',
      contentChild: Column(
        children: [
          const Text(
            'Action In Progress',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: SpinKitSpinningLines(
                color: AppColors.appPrimaryColor, lineWidth: 3, itemCount: 10),
          ),
          const SizedBox(
            width: 721,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
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
            padding: EdgeInsets.only(top: 15, bottom: 30),
            child: GlobalDividerWidget(
              dividerColor: AppColors.appDarkGrey,
              width: double.infinity,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    IconImages.appUsageCircle,
                    height: 14,
                    color: AppColors.appLightGrey,
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
                    color: AppColors.appLightGrey,
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
                  IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(IconImages.delete))
                ],
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 15, bottom: 30),
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
              bachgroundColor: AppColors.appPrimaryColor,
              buttonTextColor: Colors.white,
              onTap: () => Navigator.pop(context),
            ),
          )
        ],
      ),
    ),
  );
}

Decoration boxDecorationForContainer() {
  return BoxDecoration(boxShadow: [
    BoxShadow(
        blurRadius: 20,
        spreadRadius: 0,
        offset: const Offset(2, 2),
        color: AppColors.appLightGrey.withOpacity(0.3))
  ], borderRadius: BorderRadius.circular(25), color: Colors.white);
}

bool isValidEmail(String email) {
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  return emailRegex.hasMatch(email);
}

pickImage() async {
  final ImagePicker picker = ImagePicker();
  return await picker.pickImage(source: ImageSource.gallery);
}

Color getStatusColor(String status) {
    switch (status) {
      case 'priority':
        return Colors.red;
      case 'inprogress':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'todo':
        return Colors.grey;
      case 'pending':
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }
String getGreeting() {
    var hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }