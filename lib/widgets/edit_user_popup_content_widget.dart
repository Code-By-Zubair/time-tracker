import 'package:flutter/material.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/widgets/dropdown_button_widget.dart';
import 'package:time_tracker/widgets/global_text_button.dart';
import 'package:time_tracker/widgets/rounded_text_field.dart';

class EditUSerPopupContentWidget extends StatelessWidget {
  const EditUSerPopupContentWidget({
    super.key,
    required this.selectedTeam,
    required this.teams,
    required this.selectedId,
    required this.listOfIds,
    required this.teamdropdownOnChanged,
    required this.iddropdownOnChanged,
    required this.onSaveTap,
  });

  final String selectedTeam;
  final String selectedId;
  final List<String> listOfIds;
  final List<String> teams;
  final ValueChanged teamdropdownOnChanged;
  final ValueChanged iddropdownOnChanged;
  final VoidCallback onSaveTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
            width: 740,
            child: Divider(
              color: AppColors.appDarkGrey,
            )),
        const SizedBox(height: 30),
        const SizedBox(
          width: 740,
          child: RoundedTextField(
              labelText: AppTexts.firstName,
              labelTextStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.appDarkGrey),
              // showBorder: true,
              enableBorder: true,
              hintText: AppTexts.firstName,
              textFieldColor: Colors.white,
              keyboardType: TextInputType.text,
              obscureText: false),
        ),
        const SizedBox(height: 20),
        const SizedBox(
          width: 740,
          child: RoundedTextField(
              labelText: AppTexts.lasttName,
              labelTextStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.appDarkGrey),
              // showBorder: true,
              enableBorder: true,
              hintText: AppTexts.lasttName,
              textFieldColor: Colors.white,
              keyboardType: TextInputType.text,
              obscureText: false),
        ),
        const SizedBox(height: 20),
        const SizedBox(
          width: 740,
          child: RoundedTextField(
              labelText: AppTexts.userMail,
              labelTextStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.appDarkGrey),
              // showBorder: true,
              enableBorder: true,
              hintText: AppTexts.userMail,
              textFieldColor: Colors.white,
              keyboardType: TextInputType.emailAddress,
              obscureText: false),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Divider(
            color: AppColors.appDarkGrey,
          ),
        ),
        const Row(
          children: [
            Text(
              AppTexts.teamOptional,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            SizedBox(width: 5),
            Text(
              AppTexts.teamOfficeLocation,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.appLightGrey),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          width: 740,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppColors.appLightGrey)),
          child: DropDownButtonWidget(
            displayValueCallback: (item) => 'jdfdf',
            rightPadding: 10,
            yOffset: -10,
            selectedItem: selectedTeam,
            items: teams,
            onChanged: teamdropdownOnChanged,
          ),
        ),
        const SizedBox(height: 20),
        const Row(
          children: [
            Text(
              AppTexts.idOptional,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            SizedBox(width: 5),
            Text(
              AppTexts.idOfTheUserInYourOrg,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.appLightGrey),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          width: 740,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppColors.appLightGrey)),
          child: DropDownButtonWidget(
            displayValueCallback: (item) => 'jdfdf',
            rightPadding: 10,
            yOffset: -10,
            selectedItem: selectedTeam,
            items: teams,
            onChanged: iddropdownOnChanged,
          ),
        ),
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Divider(
              color: AppColors.appDarkGrey,
            )),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppColors.appDarkGrey)),
          height: 40,
          child: RoundedTextField(
              // enableBorder: false,
              textFieldColor: Colors.white,
              borderColor: AppColors.appDarkGrey.withOpacity(0),
              hintText: AppTexts.setANewPassword,
              keyboardType: TextInputType.text,
              obscureText: false),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 40, bottom: 10),
          child: Center(
            child: Text(
              AppTexts.deactivate,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.redColor),
            ),
          ),
        ),
        const Center(
          child: Text(
            AppTexts.youllNotBeCharged,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.appDarkGrey),
          ),
        ),
        const SizedBox(height: 30),
        const SizedBox(
            width: 740,
            child: Divider(
              color: AppColors.appDarkGrey,
            )),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 85,
              height: 40,
              child: GlobalTextButton(
                  bachgroundColor: Colors.white,
                  borderColor: AppColors.appPrimaryColor,
                  buttonTextColor: AppColors.appPrimaryColor,
                  text: AppTexts.close,
                  onTap: () => Navigator.pop(context)),
            ),
            const SizedBox(width: 20),
            SizedBox(
              width: 85,
              height: 40,
              child: GlobalTextButton(
                  bachgroundColor: AppColors.appPrimaryColor,
                  buttonTextColor: Colors.white,
                  text: AppTexts.save,
                  onTap: onSaveTap),
            ),
          ],
        )
      ],
    );
  }
}
