import 'package:flutter/material.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/widgets/global_text_button.dart';

class DeleteUserPopupContentWidget extends StatelessWidget {
  const DeleteUserPopupContentWidget({
    super.key,
    required this.onDeleteTap,
  });
  final VoidCallback onDeleteTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 90),
          child: Text(
            AppTexts.areYouSureYouWantToDeleteUSer,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.appDarkGrey),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 40,
          width: 120,
          child: GlobalTextButton(
              bachgroundColor: AppColors.appPrimaryColor,
              buttonTextColor: Colors.white,
              text: AppTexts.deleteUser,
              onTap: onDeleteTap),
        )
      ],
    );
  }
}
