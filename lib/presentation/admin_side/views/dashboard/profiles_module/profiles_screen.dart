// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/models/share_pref_model.dart';
import 'package:time_tracker/models/user_model.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_icons.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/helpers/helper_functions.dart';
import 'package:time_tracker/helpers/media_query_helper.dart';
import 'package:time_tracker/providers/dash_board_provider.dart';
import 'package:time_tracker/providers/profile_provider.dart';
import 'package:time_tracker/providers/shared_pref_provider.dart';
import 'package:time_tracker/services/database_services.dart';
import 'package:time_tracker/services/shared_pref_services.dart';
import 'package:time_tracker/widgets/alert_dialog_widget.dart';
import 'package:time_tracker/widgets/app_checkbox.dart';
import 'package:time_tracker/widgets/dropdown_button_widget.dart';
import 'package:time_tracker/widgets/global_appbar_with_profile.dart';
import 'package:time_tracker/widgets/global_divider_widget.dart';
import 'package:time_tracker/widgets/global_text_button.dart';
import 'package:time_tracker/widgets/icon_button_with_label.dart';
import 'package:time_tracker/widgets/loader_state_widget.dart';
import 'package:time_tracker/widgets/rounded_text_field.dart';

class ProfilesScreen extends StatefulWidget {
  const ProfilesScreen({super.key});

  @override
  State<ProfilesScreen> createState() => _ProfilesScreenState();
}

class _ProfilesScreenState extends State<ProfilesScreen> {
  final formkey = GlobalKey<FormState>();

  bool iConfirm = false;
  // bool isLoading = false;
  String selectedTimeZone = 'Asia/Karachi';
  XFile? imageFile;

  String firstNameErrorTxt = '';
  String lastNameErrorTxt = '';
  String emailErrorTxt = '';
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Loader loader = Loader();
  UserModel? userData;
  List<String> timezones = [
    'Asia/Karachi',
    'Africa/Accra',
    '	Africa/Addis_Ababa',
    '	Africa/Algiers'
  ];
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(
            Provider.of<SharedPrefProvider>(context, listen: false).data?.email)
        .get();
    userData = UserModel.fromJson(data.data() as Map<String, dynamic>);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final hasProfileImage =
        (userData?.profile != null && userData?.profile != '') &&
            imageFile == null;
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, top: 30),
        child: Column(
          children: [
            GlobalAppBarWithProfile(
              title: AppTexts.profile,
              isSearchfieldShow: false,
              titleRightPadding: context.w * 0.36,
              onStartBtn: () {},
              onFinishBtn: () {},
              onMenuTap: () =>
                  Provider.of<DashBoardProvider>(context, listen: false)
                      .expandDrawerFunc(),
              onBreakBtn: () {},
              showTitle: true,
              showStartFinishBtn: false,
              showWorkBreakTime: false,
            ),
            const SizedBox(height: 60),
            Consumer<ProfileProvider>(
              builder: (context, profileProvider, child) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      const GlobalDividerWidget(
                        dividerColor: AppColors.appDarkGrey,
                        width: 285,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                onTap: () {
                                  Provider.of<ProfileProvider>(context,
                                          listen: false)
                                      .openUSerProfile();
                                  Provider.of<ProfileProvider>(context,
                                          listen: false)
                                      .changeTab(0);
                                },
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      IconImages.userEditFill,
                                      color: profileProvider.userProfile
                                          ? AppColors.appPrimaryColor
                                          : AppColors.appDarkGrey,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      AppTexts.me,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: profileProvider.userProfile
                                              ? AppColors.appPrimaryColor
                                              : AppColors.appDarkGrey),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 25),
                              SizedBox(
                                  width: 80,
                                  child: Divider(
                                    color: profileProvider.userProfile
                                        ? AppColors.appPrimaryColor
                                        : Colors.transparent,
                                  ))
                            ],
                          ),
                          const SizedBox(width: 70),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                onTap: () {
                                  Provider.of<ProfileProvider>(context,
                                          listen: false)
                                      .openOrganizationProfile();
                                  Provider.of<ProfileProvider>(context,
                                          listen: false)
                                      .changeTab(1);
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      IconImages.organization,
                                      color: profileProvider.userProfile
                                          ? AppColors.appDarkGrey
                                          : AppColors.appPrimaryColor,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      AppTexts.organization,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: profileProvider.userProfile
                                            ? AppColors.appDarkGrey
                                            : AppColors.appPrimaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 25),
                              SizedBox(
                                  width: 135,
                                  child: Divider(
                                    color: profileProvider.userProfile
                                        ? Colors.transparent
                                        : AppColors.appPrimaryColor,
                                  )),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  profileProvider.userProfile
                      ? const SizedBox.shrink()
                      : SizedBox(
                          width: 145,
                          height: 40,
                          child: GlobalTextButton(
                            bachgroundColor: AppColors.appPrimaryColor,
                            buttonTextColor: Colors.white,
                            text: AppTexts.deleteAccount,
                            onTap: () {
                              showDialog(
                                barrierColor: Colors.transparent,
                                context: context,
                                builder: (context) => StatefulBuilder(
                                  builder: (context, setState1) =>
                                      AlertDialogWidget(
                                    title: AppTexts.areYouSureToDeleteYourAcc,
                                    // actionsAlignment: MainAxisAlignment.end,
                                    contentChild: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const GlobalDividerWidget(
                                          dividerColor: AppColors.appDarkGrey,
                                          width: 740,
                                        ),
                                        const SizedBox(height: 20),
                                        const SizedBox(
                                          width: 740,
                                          child: Text(
                                            AppTexts.thisActionWillErase,
                                            // maxLines: 1,
                                            // overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AppCheckbox(
                                              checkbox: iConfirm,
                                              onValueChanged: (value) {
                                                setState1(() {
                                                  iConfirm = !iConfirm;
                                                });
                                              },
                                            ),
                                            const SizedBox(width: 5),
                                            const SizedBox(
                                              width: 700,
                                              child: Text(
                                                AppTexts.iConfirmIWantToDelete,
                                                // maxLines: 1,
                                                // overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: 178,
                                              height: 40,
                                              child: GlobalTextButton(
                                                text: 'Remove My Account',
                                                borderColor: Colors.transparent,
                                                bachgroundColor:
                                                    AppColors.darkRedColor,
                                                buttonTextColor: Colors.white,
                                                onTap: () {},
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            SizedBox(
                                              width: 87,
                                              height: 40,
                                              child: GlobalTextButton(
                                                bachgroundColor:
                                                    Colors.transparent,
                                                buttonTextColor:
                                                    AppColors.appPrimaryColor,
                                                borderColor:
                                                    AppColors.appPrimaryColor,
                                                text: 'Cancel',
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    // actions: [

                                    // ],
                                  ),
                                ),
                              );
                            },
                          ))
                ],
              ),
            ),
            Consumer<ProfileProvider>(
              builder: (context, profileProvider, child) {
                return profileProvider.userProfile
                    ? StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(Provider.of<SharedPrefProvider>(context,
                                    listen: false)
                                .data
                                ?.email)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            userData = UserModel.fromJson(
                                snapshot.data?.data() as Map<String, dynamic>);
                            firstNameController = TextEditingController(
                                text: userData?.firstName);
                            lastNameController =
                                TextEditingController(text: userData?.lastName);
                            emailController =
                                TextEditingController(text: userData?.email);
                          }
                          return Container(
                            margin: const EdgeInsets.only(top: 30, bottom: 40),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: double.infinity,
                            child: Center(
                              child: Form(
                                key: formkey,
                                autovalidateMode: AutovalidateMode.disabled,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 50, bottom: 40),
                                      child: Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: AppColors.bgColor,
                                            radius: 50,
                                            backgroundImage: buildProfileImage(
                                              userData: userData,
                                              imageFile: imageFile,
                                              hasProfileImage: hasProfileImage,
                                            ),
                                          ),
                                          GestureDetector(
                                              onTap: () async {
                                                imageFile = await pickImage();
                                                setState(() {});
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  bottom: 5,
                                                ),
                                                child: SvgPicture.asset(
                                                  IconImages.pickImage,
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                            left: 20,
                                            bottom: 10,
                                          ),
                                          child: Text(
                                            AppTexts.firstName,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: context.w * 0.4,
                                          child: RoundedTextField(
                                            filled: true,
                                            textFieldColor: AppColors
                                                .appDarkGrey
                                                .withOpacity(
                                              0.1,
                                            ),
                                            hintText: AppTexts.firstName,
                                            keyboardType: TextInputType.name,
                                            obscureText: false,
                                            errorText: firstNameErrorTxt,
                                            textController: firstNameController,
                                            validator: (p0) {
                                              if (p0!.isEmpty) {
                                                return 'First Name Required';
                                              }
                                              return null;
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                            left: 20,
                                            bottom: 10,
                                          ),
                                          child: Text(
                                            AppTexts.lasttName,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: context.w * 0.4,
                                          child: RoundedTextField(
                                            filled: true,
                                            textFieldColor: AppColors
                                                .appDarkGrey
                                                .withOpacity(
                                              0.1,
                                            ),
                                            hintText: AppTexts.lasttName,
                                            keyboardType: TextInputType.name,
                                            obscureText: false,
                                            errorText: lastNameErrorTxt,
                                            textController: lastNameController,
                                            validator: (p0) {
                                              if (p0!.isEmpty) {
                                                return 'Last Name Required';
                                              }
                                              return null;
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                            left: 20,
                                            bottom: 10,
                                          ),
                                          child: Text(
                                            'Email',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: context.w * 0.4,
                                          child: RoundedTextField(
                                            filled: true,
                                            textController: emailController,
                                            textFieldColor: AppColors
                                                .appDarkGrey
                                                .withOpacity(
                                              0.1,
                                            ),
                                            readOnly: true,
                                            hintText: 'Email',
                                            keyboardType: TextInputType.name,
                                            obscureText: false,
                                            errorText: emailErrorTxt,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter your email address.';
                                              }
                                              if (!isValidEmail(value)) {
                                                return 'Please enter a valid email address';
                                              }
                                              return null;
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 60,
                                    ),
                                    SizedBox(
                                      width: context.w * 0.4,
                                      height: 50,
                                      child: ValueListenableBuilder<bool>(
                                        valueListenable: loader.isLoading,
                                        builder: (context, value, child) =>
                                            GlobalTextButton(
                                          borderRadius: 30,
                                          bachgroundColor:
                                              AppColors.appPrimaryColor,
                                          text: AppTexts.save,
                                          isLoading: value,
                                          textStyle: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                          onTap: () async => updateProfile(),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 30, bottom: 40),
                                      child: GlobalDividerWidget(
                                        dividerColor: AppColors.appDarkGrey,
                                        width: 400,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 270,
                                      child: GlobalTextButton(
                                        bachgroundColor: Colors.transparent,
                                        textStyle: const TextStyle(
                                          fontSize: 18,
                                          color: AppColors.blueColor,
                                        ),
                                        borderColor: Colors.transparent,
                                        text: 'Change Account Password',
                                        onTap: () {},
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : Container(
                        margin: const EdgeInsets.only(top: 30, bottom: 40),
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    AppTexts.organizationProfile,
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 145,
                                    child: IconButtonWithLabel(
                                      borderColor: AppColors.appPrimaryColor,
                                      textColor: AppColors.appPrimaryColor,
                                      text: 'Upload Logo',
                                      icon: IconImages.edit,
                                      iconHeight: 15,
                                      onTap: () {},
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 30),
                              const Text(
                                AppTexts.youMayNeedTORestart,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 15),
                              const Text(
                                AppTexts.youMayNeedTOReload,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 35, bottom: 30),
                                child: GlobalDividerWidget(
                                  dividerColor: AppColors.appDarkGrey,
                                  width: double.infinity,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 30, bottom: 10),
                                        child: Text(
                                          AppTexts.organization,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Container(
                                        width: context.w * 0.25,
                                        height: 40,
                                        padding: const EdgeInsets.only(
                                            left: 20, top: 10),
                                        decoration: BoxDecoration(
                                            color: AppColors.appDarkGrey
                                                .withOpacity(.1),
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: const Text('Time Tracking'),
                                      )
                                    ],
                                  ),
                                  SizedBox(width: context.w * 0.021),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 30, bottom: 10),
                                        child: Text(
                                          AppTexts.timeZone,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Container(
                                        width: context.w * 0.25,
                                        height: 50,
                                        padding: const EdgeInsets.only(
                                            left: 5, top: 10),
                                        child: DropDownButtonWidget(
                                          displayValueCallback: (item) => item,
                                          width: context.w * 0.23,
                                          filled: true,
                                          selectedItem: selectedTimeZone,
                                          yOffset: -10,
                                          rightPadding: 5,
                                          bottomPadding: 10,
                                          items: timezones,
                                          onChanged: (value) {
                                            selectedTimeZone = value;
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 50),
                              Center(
                                child: SizedBox(
                                  height: 40,
                                  width: 145,
                                  child: GlobalTextButton(
                                    bachgroundColor: AppColors.appPrimaryColor,
                                    buttonTextColor: Colors.white,
                                    text: AppTexts.saveChanges,
                                    onTap: () {},
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              const GlobalDividerWidget(
                                width: double.infinity,
                                dividerColor: AppColors.appDarkGrey,
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                AppTexts.twoFactorAuthentication,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                AppTexts.requireUserToVerity,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.appDarkGrey),
                              ),
                              const Row(
                                children: [
                                  Text(
                                    AppTexts.note,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Flexible(
                                    child: Text(
                                      AppTexts.youNeedTimeTrackingAppversion,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.appDarkGrey),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              Consumer<ProfileProvider>(
                                builder: (context, profileProvider, child) =>
                                    SizedBox(
                                  width: 400,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        AppTexts.owner,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 72,
                                            height: 32,
                                            child: GlobalTextButton(
                                                bachgroundColor: profileProvider
                                                        .enableOwner
                                                    ? AppColors.appPrimaryColor
                                                    : Colors.white,
                                                buttonTextColor:
                                                    profileProvider.enableOwner
                                                        ? Colors.white
                                                        : AppColors.appDarkGrey,
                                                borderColor: profileProvider
                                                        .enableOwner
                                                    ? AppColors.appPrimaryColor
                                                    : AppColors.appDarkGrey,
                                                onTap: () {
                                                  Provider.of<ProfileProvider>(
                                                          context,
                                                          listen: false)
                                                      .enableOwnerFunc();
                                                },
                                                text: AppTexts.enable),
                                          ),
                                          const SizedBox(width: 15),
                                          SizedBox(
                                            width: 72,
                                            height: 32,
                                            child: GlobalTextButton(
                                                bachgroundColor: profileProvider
                                                        .enableOwner
                                                    ? Colors.white
                                                    : AppColors.appPrimaryColor,
                                                buttonTextColor:
                                                    profileProvider.enableOwner
                                                        ? AppColors.appDarkGrey
                                                        : Colors.white,
                                                borderColor: profileProvider
                                                        .enableOwner
                                                    ? AppColors.appDarkGrey
                                                    : AppColors.appPrimaryColor,
                                                onTap: () {
                                                  Provider.of<ProfileProvider>(
                                                          context,
                                                          listen: false)
                                                      .disableOwnerFunc();
                                                },
                                                text: AppTexts.disable),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Consumer<ProfileProvider>(
                                builder: (context, profileProvider, child) =>
                                    SizedBox(
                                  width: 400,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        AppTexts.admin,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 72,
                                            height: 32,
                                            child: GlobalTextButton(
                                                bachgroundColor: profileProvider
                                                        .enableAdmin
                                                    ? AppColors.appPrimaryColor
                                                    : Colors.white,
                                                buttonTextColor:
                                                    profileProvider.enableAdmin
                                                        ? Colors.white
                                                        : AppColors.appDarkGrey,
                                                borderColor: profileProvider
                                                        .enableAdmin
                                                    ? AppColors.appPrimaryColor
                                                    : AppColors.appDarkGrey,
                                                onTap: () {
                                                  Provider.of<ProfileProvider>(
                                                          context,
                                                          listen: false)
                                                      .enableAdminFunc();
                                                },
                                                text: AppTexts.enable),
                                          ),
                                          const SizedBox(width: 15),
                                          SizedBox(
                                            width: 72,
                                            height: 32,
                                            child: GlobalTextButton(
                                                bachgroundColor: profileProvider
                                                        .enableAdmin
                                                    ? Colors.white
                                                    : AppColors.appPrimaryColor,
                                                buttonTextColor:
                                                    profileProvider.enableAdmin
                                                        ? AppColors.appDarkGrey
                                                        : Colors.white,
                                                borderColor: profileProvider
                                                        .enableAdmin
                                                    ? AppColors.appDarkGrey
                                                    : AppColors.appPrimaryColor,
                                                onTap: () {
                                                  Provider.of<ProfileProvider>(
                                                          context,
                                                          listen: false)
                                                      .disableAdminFunc();
                                                },
                                                text: AppTexts.disable),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Consumer<ProfileProvider>(
                                builder: (context, profileProvider, child) =>
                                    SizedBox(
                                  width: 400,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        AppTexts.manager,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 72,
                                            height: 32,
                                            child: GlobalTextButton(
                                                bachgroundColor: profileProvider
                                                        .enableManager
                                                    ? AppColors.appPrimaryColor
                                                    : Colors.white,
                                                buttonTextColor: profileProvider
                                                        .enableManager
                                                    ? Colors.white
                                                    : AppColors.appDarkGrey,
                                                borderColor: profileProvider
                                                        .enableManager
                                                    ? AppColors.appPrimaryColor
                                                    : AppColors.appDarkGrey,
                                                onTap: () {
                                                  Provider.of<ProfileProvider>(
                                                          context,
                                                          listen: false)
                                                      .enableManagerFunc();
                                                },
                                                text: AppTexts.enable),
                                          ),
                                          const SizedBox(width: 15),
                                          SizedBox(
                                            width: 72,
                                            height: 32,
                                            child: GlobalTextButton(
                                                bachgroundColor: profileProvider
                                                        .enableManager
                                                    ? Colors.white
                                                    : AppColors.appPrimaryColor,
                                                buttonTextColor: profileProvider
                                                        .enableManager
                                                    ? AppColors.appDarkGrey
                                                    : Colors.white,
                                                borderColor: profileProvider
                                                        .enableManager
                                                    ? AppColors.appDarkGrey
                                                    : AppColors.appPrimaryColor,
                                                onTap: () {
                                                  Provider.of<ProfileProvider>(
                                                          context,
                                                          listen: false)
                                                      .disableManagerFunc();
                                                },
                                                text: AppTexts.disable),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: 400,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      AppTexts.user,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 72,
                                          height: 32,
                                          child: GlobalTextButton(
                                              bachgroundColor: profileProvider
                                                      .enableUser
                                                  ? AppColors.appPrimaryColor
                                                  : Colors.white,
                                              buttonTextColor:
                                                  profileProvider.enableUser
                                                      ? Colors.white
                                                      : AppColors.appDarkGrey,
                                              borderColor: profileProvider
                                                      .enableUser
                                                  ? AppColors.appPrimaryColor
                                                  : AppColors.appDarkGrey,
                                              onTap: () {
                                                Provider.of<ProfileProvider>(
                                                        context,
                                                        listen: false)
                                                    .enableUserFunc();
                                              },
                                              text: AppTexts.enable),
                                        ),
                                        const SizedBox(width: 15),
                                        SizedBox(
                                          width: 72,
                                          height: 32,
                                          child: GlobalTextButton(
                                              bachgroundColor: profileProvider
                                                      .enableUser
                                                  ? Colors.white
                                                  : AppColors.appPrimaryColor,
                                              buttonTextColor:
                                                  profileProvider.enableUser
                                                      ? AppColors.appDarkGrey
                                                      : Colors.white,
                                              borderColor: profileProvider
                                                      .enableUser
                                                  ? AppColors.appDarkGrey
                                                  : AppColors.appPrimaryColor,
                                              onTap: () {
                                                Provider.of<ProfileProvider>(
                                                        context,
                                                        listen: false)
                                                    .disableUSerFunc();
                                              },
                                              text: AppTexts.disable),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                            ]),
                      );
              },
            )
          ],
        ),
      ),
    ));
  }

  updateProfile() async {
    if (formkey.currentState!.validate()) {
      String imageUrl = '';
      loader.loadingState(true);
      try {
        if (imageFile != null) {
          imageUrl = await DatabaseServices()
              .uploadProfileToStorage(File(imageFile!.path))
              .then((value) {
            loader.loadingState(false);

            return value;
          });
        }
        await DatabaseServices().updateUser(UserModel(
          email: emailController.text.trim(),
          role: userData?.role ?? '',
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          organizationUserName: userData?.organizationUserName,
          profile: imageFile == null ? userData?.profile : imageUrl,
        ));
        loader.loadingState(false);
        SharedPrefServices().saveUserDataLoacally(SharePrefModel(
          role: userData?.role ?? '',
          email: emailController.text.trim(),
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          loginMethod: SharedPrefProvider().data?.loginMethod ?? '',
          profile: imageFile == null ? userData?.profile : imageUrl,
        ));
        SharedPrefProvider().getPrefData();
        context.showSuccessSnackBar('Profile updated successfully');
      } catch (e, s) {
        loader.loadingState(false);

        context.showErrorSnackBar(e.toString());
        print(s.toString() + e.toString());
      }
    }
  }

  buildProfileImage({
    UserModel? userData,
    XFile? imageFile,
    bool hasProfileImage = false,
  }) {
    if ((userData?.profile != null && userData?.profile != '') &&
        imageFile == null) {
      return NetworkImage(
        userData?.profile ?? '',
      );
    } else if (imageFile != null) {
      return FileImage(
        File(imageFile.path),
      );
    } else if (!hasProfileImage && imageFile == null) {
      return const ExactAssetImage('assets/images/man.png');
    }

    return const ExactAssetImage('assets/images/man.png');
  }
}
