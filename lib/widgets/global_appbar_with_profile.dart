import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_icons.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/helpers/media_query_helper.dart';
import 'package:time_tracker/models/user_model.dart';
import 'package:time_tracker/providers/shared_pref_provider.dart';
import 'package:time_tracker/providers/user_dash_board_provider.dart';
import 'package:time_tracker/widgets/icon_button_with_label.dart';
import 'package:time_tracker/widgets/rounded_text_field.dart';

class GlobalAppBarWithProfile extends StatelessWidget {
  const GlobalAppBarWithProfile({
    super.key,
    required this.title,
    required this.isSearchfieldShow,
    required this.onStartBtn,
    required this.onFinishBtn,
    required this.showTitle,
    this.textController,
    this.titleRightPadding,
    this.titleLefPadding,
    this.showStartFinishBtn = true,
    this.showWorkBreakTime = true,
    this.workTodayRightPad,
    this.hintText,
    this.searchFieldLeftpadding,
    this.searchFieldRightpadding,
    this.workTodayLeftPad,
    this.showStartFinishRightMarg,
    this.showStartFinishLefttMarg,
    this.cursorHeight,
    required this.onMenuTap,
    required this.onBreakBtn,
  });
  final String title;
  final bool isSearchfieldShow;
  final VoidCallback onStartBtn;
  final VoidCallback onFinishBtn;
  final VoidCallback onBreakBtn;

  final bool showTitle;
  final TextEditingController? textController;
  final double? titleRightPadding;
  final double? titleLefPadding;
  final bool showStartFinishBtn;
  final bool showWorkBreakTime;
  final double? workTodayRightPad;
  final String? hintText;
  final double? searchFieldLeftpadding;
  final double? searchFieldRightpadding;
  final double? workTodayLeftPad;

  final double? showStartFinishRightMarg;
  final double? showStartFinishLefttMarg;
  final double? cursorHeight;
  final VoidCallback onMenuTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.w,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.spaceBetween,
        runSpacing: 15,
        children: [
          IconButton(
            onPressed: context.w > 900 ? onMenuTap : null,
            icon: SvgPicture.asset(
              IconImages.menu,
              height: 15,
            ),
          ),
          showTitle
              ? Padding(
                  padding: EdgeInsets.only(
                    right: titleRightPadding ?? 0,
                    left: titleLefPadding ?? 0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),

          isSearchfieldShow
              ? Padding(
                  padding: const EdgeInsets.only(),
                  child: SizedBox(
                    width: 250,
                    height: 40,
                    child: RoundedTextField(
                      showBorder: true,
                      filled: true,
                      iconHeight: 14,
                      hintTextColor: Colors.black,
                      textController: textController,
                      keyboardType: TextInputType.name,
                      obscureText: false,
                      textFieldColor: Colors.white,
                      icon: IconImages.search,
                      hintText: hintText,
                      enableBorder: true,
                      borderColor: Colors.white,
                    ),
                  ))
              : const SizedBox.shrink(),
          showStartFinishBtn
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButtonWithLabel(
                        borderRadius: 20,
                        iconHeight: 10,
                        text: AppTexts.start,
                        icon: IconImages.play,
                        borderColor: AppColors.purpleColor,
                        textStyle: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.purpleColor,
                        ),
                        onTap: onStartBtn,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Consumer<UserDashBoardProvider>(
                          builder: (context, value, child) =>
                              IconButtonWithLabel(
                            borderRadius: 20,
                            iconHeight: 10,
                            iconColor: AppColors.appPrimaryColor,
                            text: AppTexts.Break,
                            icon: (value.breakTimer?.isActive ?? false)
                                ? IconImages.pause
                                : IconImages.play,
                            borderColor: Colors.transparent,
                            textStyle: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: AppColors.appPrimaryColor,
                            ),
                            onTap: onBreakBtn,
                          ),
                        ),
                      ),
                      IconButtonWithLabel(
                          borderRadius: 20,
                          iconHeight: 10,
                          text: AppTexts.finish,
                          icon: IconImages.finish,
                          borderColor: AppColors.purpleColor,
                          textStyle: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: AppColors.purpleColor),
                          onTap: onFinishBtn)
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          // const SizedBox(width: 10),
          showWorkBreakTime
              ? Consumer<UserDashBoardProvider>(
                  builder: (context, value, child) => Padding(
                    padding: EdgeInsets.only(
                      right: context.w * 0.09,
                    ),
                    child: SizedBox(
                      width: 180,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('Worked today: '),
                              Text(value.workedTodayFormatedTime), //'00:03:52'
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('On break today: '),
                              Text(value.breakTodayFormatedTime), //'00:00:00'
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          FutureBuilder(
            future: Provider.of<SharedPrefProvider>(context, listen: false)
                .getPrefData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(Provider.of<SharedPrefProvider>(context,
                                listen: false)
                            .data
                            ?.email)
                        .snapshots(),
                    builder: (
                      BuildContext context,
                      AsyncSnapshot snapshot,
                    ) {
                      if (snapshot.hasData) {
                        UserModel userData =
                            UserModel.fromJson(snapshot.data.data() ?? {});
                        String userName =
                            '${userData.firstName ?? ''} ${userData.lastName ?? ''}';
                        String orgName = userData.organizationUserName ?? '';
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    userName.length >= 10
                                        ? '${userName.substring(0, 10)}...'
                                        : userName,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    orgName.length >= 10
                                        ? '${orgName.substring(0, 10)}...'
                                        : orgName,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.appLightGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.5),
                              radius: 22,
                              backgroundImage: getProfileImage(userData),
                            )
                          ],
                        );
                      }
                      return const CircularProgressIndicator(
                        color: AppColors.appPrimaryColor,
                      );
                    });
              }
              return const CircularProgressIndicator();
            },
          )
        ],
      ),
    );
  }

  ImageProvider<Object> getProfileImage(UserModel userData) {
    if (userData.profile == null || (userData.profile?.isEmpty ?? true)) {
      return const ExactAssetImage('assets/images/man.png');
    } else {
      return NetworkImage(userData.profile!);
    }
  }
}
