import 'package:flutter/material.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/reports_module/widgets/search_user_projects_dropdown_and_date_range_wrap_widget.dart';
import 'package:time_tracker/helpers/helper_functions.dart';

class ProductivityTabUpperContent extends StatefulWidget {
  const ProductivityTabUpperContent({super.key});

  @override
  State<ProductivityTabUpperContent> createState() =>
      _ProductivityTabUpperContentState();
}

class _ProductivityTabUpperContentState
    extends State<ProductivityTabUpperContent> {
  TextEditingController searchUserController = TextEditingController();
  DateTime? picked;
  DateTimeRange? selectedDateRange;
  String selectedproject = 'All Team';
  List<String> projects = ['All Team', 'App Team', 'Flutter Team'];

  @override
  Widget build(BuildContext context) {
    return SearchUserProjectsDropDownAndDateRangeWrapWidget(
      searchUserController: searchUserController,
      selectedproject: selectedproject,
      projects: projects,
      selectedDateRange: selectedDateRange,
      onDatePickTap: () async {
        var val = await selectDateRange(context);
        if (val != null && val != selectedDateRange) {
          selectedDateRange = val;
          setState(() {});
        }
      },
      onDropDownTap: (value) {
        setState(() {
          selectedproject = value;
        });
      },
      onGenerateTap: () {},
    );
  }
}
