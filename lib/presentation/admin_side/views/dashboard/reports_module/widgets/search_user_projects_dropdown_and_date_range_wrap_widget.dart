import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_icons.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/helpers/helper_functions.dart';
import 'package:time_tracker/widgets/global_text_button.dart';
import 'package:time_tracker/widgets/multi_select_dropdown_widget.dart';
import 'package:time_tracker/widgets/rounded_text_field.dart';

class SearchUserProjectsDropDownAndDateRangeWrapWidget extends StatelessWidget {
  const SearchUserProjectsDropDownAndDateRangeWrapWidget({
    super.key,
    required this.searchUserController,
    required this.selectedproject,
    required this.projects,
    required this.onDropDownTap,
    this.selectedDateRange,
    required this.onDatePickTap,
    required this.onGenerateTap,
  });

  final TextEditingController searchUserController;
  final String selectedproject;
  final List<String> projects;
  final ValueChanged onDropDownTap;
  final DateTimeRange? selectedDateRange;
  final VoidCallback onDatePickTap;
  final VoidCallback onGenerateTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.end,
        runAlignment: WrapAlignment.spaceBetween,
        runSpacing: 15,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                AppTexts.searchUser,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 250,
                height: 40,
                decoration: boxDecorationForContainer(),
                child: RoundedTextField(
                  borderColor: Colors.white,
                  textController: searchUserController,
                  hintText: 'Search User',
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  textFieldColor: Colors.white,
                  icon: IconImages.search,
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                AppTexts.projects,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              Container(
                height: 40,
                width: 250,
                decoration: boxDecorationForContainer(),
                child: MultiSelectDropdownWidget(
                  width: 250,
                  splashColor: Colors.transparent,
                  includeSearch: true,
                  includeSelectAll: true,
                  initiallySelectedList: const [],
                  boxDecoration: boxDecorationForContainer(),
                  itemList: projects,
                  onChange: (value) {},
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                AppTexts.dateRange,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              Container(
                height: 40,
                width: 250,
                decoration: boxDecorationForContainer(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: selectedDateRange != null
                            ? Text(
                                '${formatDate(selectedDateRange!.start)} - ${formatDate(selectedDateRange!.end)}')
                            : const Text('Nov 15,2023 - Dec 22,2023')),
                    IconButton(
                        onPressed: onDatePickTap,
                        icon: SvgPicture.asset(
                          IconImages.calender,
                          color: AppColors.appDarkGrey,
                        ))
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 50),
            child: SizedBox(
              height: 40,
              width: 122,
              child: GlobalTextButton(
                text: 'Generate',
                bachgroundColor: AppColors.appPrimaryColor,
                buttonTextColor: Colors.white,
                onTap: onGenerateTap,
              ),
            ),
          )
        ],
      ),
    );
  }
}
