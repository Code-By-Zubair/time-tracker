import 'package:flutter/material.dart';
import 'package:time_tracker/helpers/helper_functions.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/reports_module/widgets/screenshot_tab_single_Item_widget.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_icons.dart';
import 'package:time_tracker/widgets/icon_button_with_label.dart';

class ScreenShotTabBottomContent extends StatefulWidget {
  const ScreenShotTabBottomContent({super.key});

  @override
  State<ScreenShotTabBottomContent> createState() =>
      _ScreenShotTabBottomContentState();
}

class _ScreenShotTabBottomContentState
    extends State<ScreenShotTabBottomContent> {
  List<Set<int>> selectedImages = [];
  ScrollController scrollController = ScrollController();
  List<Map<String, dynamic>> selectedItemsMap = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'James screenshots',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 40,
                child: IconButtonWithLabel(
                  backgroundColor: AppColors.appPrimaryColor,
                  borderColor: AppColors.appPrimaryColor,
                  text: 'Download Screenshots',
                  iconHeight: 14,
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                  icon: IconImages.download,
                  onTap: () {
                    showDownloadPreviewDialog(context);
                  },
                ),
              ),
            ],
          ),
        ),
        Column(
          children: List.generate(5, (i) {
            return ScreenShotSingleItemWidget(
              selectedImages:
                  selectedImages.isNotEmpty ? selectedImages[i] : {},
              startDate: 'Fri, Nov 19',
              endDate: 'Fri, Nov 19',
              itemDate: 'Fri, Nov 19',
              onCheckBox: (value) {},
              time: '09:16 AM',
            );
          }),
        )
      ],
    );
  }
}
