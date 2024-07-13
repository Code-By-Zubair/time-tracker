import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_icons.dart';
import 'package:time_tracker/widgets/global_text_button.dart';
import 'package:time_tracker/widgets/rounded_text_field.dart';

class AddTeamPopUpWidget extends StatelessWidget {
  const AddTeamPopUpWidget({
    super.key,
    required this.createTeamController,
    required this.onCreateTap,
    required this.title,
    required this.actionButtonName,
  });

  final TextEditingController createTeamController;
  // final Function onCreateTap;
  final VoidCallback onCreateTap;
  final String title;
  final String actionButtonName;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: SvgPicture.asset(IconImages.cross))
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(
            color: AppColors.appDarkGrey,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 500,
            height: 45,
            child: RoundedTextField(
              borderColor: AppColors.appDarkGrey,
              textController: createTeamController,
              textFieldColor: Colors.white,
              hintText: 'Team Name',
              keyboardType: TextInputType.text,
              showBorder: true,
              obscureText: false,
            ),
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
              width: 85,
              child: GlobalTextButton(
                text: 'Cancel',
                bachgroundColor: Colors.white,
                buttonTextColor: AppColors.appPrimaryColor,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(width: 20),
            SizedBox(
              height: 40,
              width: 85,
              child: GlobalTextButton(
                text: actionButtonName,
                bachgroundColor: AppColors.appPrimaryColor,
                borderColor: Colors.white,
                buttonTextColor: Colors.white,
                onTap: onCreateTap,
              ),
            ),
          ],
        )
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}
