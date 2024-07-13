import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_icons.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/helpers/helper_functions.dart';
import 'package:time_tracker/helpers/media_query_helper.dart';
import 'package:time_tracker/widgets/global_text_button.dart';
import 'package:time_tracker/widgets/multi_select_dropdown_widget.dart';
import 'package:time_tracker/widgets/rounded_text_field.dart';

class UserTabUpperContent extends StatefulWidget {
  const UserTabUpperContent({
    super.key,
  });

  @override
  State<UserTabUpperContent> createState() => _UserTabUpperContentState();
}

class _UserTabUpperContentState extends State<UserTabUpperContent> {
  TextEditingController searchUserController = TextEditingController();
  DateTime? picked;
  DateTimeRange? selectedDateRange;
  String selectedproject = 'All Team';
  String selectedSortType = 'Name';
  String selectedType = 'Ascending';
  List<String> selectedTypeList = ['Ascending', 'Descending'];
  List<String> projects = ['All Team', 'App Team', 'Flutter Team'];
  List<String> sortByList = ['Name', 'Age'];

  String _formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime.toLocal());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: boxDecorationForContainer(),
                    width: 250,
                    height: 40,
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
                      includeSearch: false,
                      includeSelectAll: true,
                      initiallySelectedList: const [],
                      boxDecoration: boxDecorationForContainer(),
                      itemList: projects,
                      onChange: (value) {},
                    ),
                  ),
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
                                    '${_formatDate(selectedDateRange!.start)} - ${_formatDate(selectedDateRange!.end)}')
                                : const Text('Nov 15,2023 - Dec 22,2023')),
                        IconButton(
                            onPressed: () {
                              selectDateRange(context);
                            },
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
                    onTap: () {},
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 30),
        Wrap(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  AppTexts.sortBy,
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
                    includeSearch: false,
                    includeSelectAll: true,
                    initiallySelectedList: const [],
                    boxDecoration: boxDecorationForContainer(),
                    itemList: sortByList,
                    onChange: (value) {},
                  ),
                ),
              ],
            ),
            SizedBox(width: context.w * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(''),
                const SizedBox(height: 10),
                Container(
                  height: 40,
                  width: 250,
                  decoration: boxDecorationForContainer(),
                  child: MultiSelectDropdownWidget(
                    width: 250,
                    splashColor: Colors.transparent,
                    includeSearch: false,
                    includeSelectAll: true,
                    initiallySelectedList: const [],
                    boxDecoration: boxDecorationForContainer(),
                    itemList: sortByList,
                    onChange: (value) {},
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
