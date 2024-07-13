// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_icons.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/helpers/helper_functions.dart';
import 'package:time_tracker/helpers/media_query_helper.dart';
import 'package:time_tracker/models/share_pref_model.dart';
import 'package:time_tracker/models/user_model.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/settings_module/setting_screen.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/settings_module/widgets/enable_disable_button_row_widget.dart';
import 'package:time_tracker/providers/settings_provider_user_side.dart';
import 'package:time_tracker/providers/shared_pref_provider.dart';
import 'package:time_tracker/providers/user_dash_board_provider.dart';
import 'package:time_tracker/services/database_services.dart';
import 'package:time_tracker/services/shared_pref_services.dart';
import 'package:time_tracker/widgets/global_appbar_with_profile.dart';
import 'package:time_tracker/widgets/global_divider_widget.dart';
import 'package:time_tracker/widgets/global_text_button.dart';
import 'package:time_tracker/widgets/loader_state_widget.dart';
import 'package:time_tracker/widgets/rounded_text_field.dart';

class SettingsScreenUserSide extends StatefulWidget {
  const SettingsScreenUserSide({super.key});

  @override
  State<SettingsScreenUserSide> createState() => _SettingsScreenUserSide();
}

class _SettingsScreenUserSide extends State<SettingsScreenUserSide> {
  final formKey = GlobalKey<FormState>();
  String firstNameErrorTxt = '';
  String lastNameErrorTxt = '';
  String emailErrorTxt = '';
  XFile? imageFile;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  Loader loader = Loader();
  UserModel? userData;
  List items = [
    {'icons': IconImages.user, 'text': AppTexts.users},
    {'icons': IconImages.userEditFill, 'text': AppTexts.editUser},
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
    final userDashBoardProvider =
        Provider.of<UserDashBoardProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50, top: 30),
          child: Column(
            children: [
              Consumer<SettingsProviderUserSide>(
                builder: (context, settingsProviderUserSide, child) =>
                    GlobalAppBarWithProfile(
                  title: settingsProviderUserSide.selectedTabTitle,
                  isSearchfieldShow: false,
                  titleRightPadding: context.w * 0.36,
                  onStartBtn: () {},
                  onFinishBtn: () {},
                  onBreakBtn: () {},
                  onMenuTap: () => userDashBoardProvider.expandDrawerFunc(),
                  showTitle: true,
                  showStartFinishBtn: false,
                  showWorkBreakTime: false,
                ),
              ),
              const SizedBox(height: 60),
              Consumer<SettingsProviderUserSide>(
                builder: (context, settingsProviderUserSide, child) => Stack(
                  alignment: Alignment.bottomLeft,
                  fit: StackFit.loose,
                  children: [
                    const SizedBox(
                      child: Divider(
                        color: AppColors.appDarkGrey,
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    SizedBox(
                      height: 64,
                      child: ListView.builder(
                        controller: scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: CustomTabItemWidget(
                              providerSelectedTab:
                                  settingsProviderUserSide.selectedTab,
                              icon: items[index]['icons'],
                              text: items[index]['text'],
                              selectedTab: index,
                              onTabPress: () {
                                Provider.of<SettingsProviderUserSide>(context,
                                        listen: false)
                                    .changeTab(index);
                                Provider.of<SettingsProviderUserSide>(context,
                                        listen: false)
                                    .changeSelectedTabTitle(index);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Consumer<SettingsProviderUserSide>(
                builder: (context, settingsProviderUserSide, child) {
                  return settingsProviderUserSide.selectedTab == 0
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 30,
                          ),
                          child: Column(
                            children: [
                              EnableDisableButtonRowWidget(
                                text: 'Receive Weekly Report',
                                showDefaultButton: false,
                                checkWith: settingsProviderUserSide
                                    .receiveWeeklyReport,
                                onDisableTap: () =>
                                    Provider.of<SettingsProviderUserSide>(
                                            context,
                                            listen: false)
                                        .changeWeeklyReport('disable'),
                                onEnableTap: () =>
                                    Provider.of<SettingsProviderUserSide>(
                                            context,
                                            listen: false)
                                        .changeWeeklyReport('enable'),
                              ),
                              const SizedBox(height: 20),
                              EnableDisableButtonRowWidget(
                                text: 'Receive Daily Report',
                                showDefaultButton: false,
                                checkWith:
                                    settingsProviderUserSide.receiveDailyReport,
                                onDisableTap: () =>
                                    Provider.of<SettingsProviderUserSide>(
                                            context,
                                            listen: false)
                                        .changeDailyReport('disable'),
                                onEnableTap: () =>
                                    Provider.of<SettingsProviderUserSide>(
                                            context,
                                            listen: false)
                                        .changeDailyReport('enable'),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )
                      : StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc(Provider.of<SharedPrefProvider>(context,
                                      listen: false)
                                  .data
                                  ?.email)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              userData = UserModel.fromJson(snapshot.data
                                  ?.data() as Map<String, dynamic>);
                              firstNameController = TextEditingController(
                                  text: userData?.firstName);
                              lastNameController = TextEditingController(
                                  text: userData?.lastName);
                              emailController =
                                  TextEditingController(text: userData?.email);
                            }
                            return Container(
                              margin: const EdgeInsets.only(
                                top: 30,
                                bottom: 40,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              width: double.infinity,
                              child: Center(
                                child: Form(
                                  autovalidateMode: AutovalidateMode.disabled,
                                  key: formKey,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 50,
                                          bottom: 40,
                                        ),
                                        child: Stack(
                                          alignment: Alignment.bottomRight,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                                  AppColors.bgColor,
                                              radius: 50,
                                              backgroundImage:
                                                  buildProfileImage(
                                                      userData: userData,
                                                      imageFile: imageFile,
                                                      hasProfileImage:
                                                          hasProfileImage),
                                            ),
                                            GestureDetector(
                                                onTap: () async {
                                                  imageFile = await pickImage();
                                                  setState(() {});
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
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
                                              textController:
                                                  firstNameController,
                                              hintText: AppTexts.firstName,
                                              keyboardType: TextInputType.name,
                                              obscureText: false,
                                              errorText: firstNameErrorTxt,
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
                                              textController:
                                                  lastNameController,
                                              hintText: AppTexts.lasttName,
                                              keyboardType: TextInputType.name,
                                              obscureText: false,
                                              errorText: lastNameErrorTxt,
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
                                              textController: emailController,
                                              readOnly: true,
                                              filled: true,
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
                                        child: ValueListenableBuilder(
                                          valueListenable: loader.isLoading,
                                          builder: (context, value, child) =>
                                              GlobalTextButton(
                                            isLoading: value,
                                            borderRadius: 30,
                                            bachgroundColor:
                                                AppColors.appPrimaryColor,
                                            buttonTextColor: Colors.white,
                                            text: AppTexts.save,
                                            onTap: () async {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                updateProfile();
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          top: 30,
                                          bottom: 40,
                                        ),
                                        child: GlobalDividerWidget(
                                          dividerColor: AppColors.appDarkGrey,
                                          width: 400,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 230,
                                        child: GlobalTextButton(
                                          bachgroundColor: Colors.transparent,
                                          buttonTextColor: AppColors.blueColor,
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
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
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

  updateProfile() async {
    String iamgeUrl = '';
    loader.loadingState(true);
    try {
      if (imageFile != null) {
        iamgeUrl = await DatabaseServices()
            .uploadProfileToStorage(File(imageFile!.path))
            .then((value) {
          loader.loadingState(false);
          return value;
        });
      }
      DatabaseServices().updateUser(UserModel(
        email: emailController.text.trim(),
        role: userData?.role ?? '',
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.toString(),
        organizationUserName: userData?.organizationUserName,
        profile: imageFile == null ? userData?.profile : iamgeUrl,
      ));
      SharedPrefServices().saveUserDataLoacally(SharePrefModel(
        role: userData?.role ?? '',
        email: emailController.text.trim(),
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        loginMethod: SharedPrefProvider().data?.loginMethod ?? '',
        profile: imageFile == null ? userData?.profile : iamgeUrl,
      ));
      SharedPrefProvider().getPrefData();
      loader.loadingState(false);
      context.showSuccessSnackBar('Profile updated successfully');
    } catch (e) {
      loader.loadingState(false);
      context.showErrorSnackBar(e.toString());
      print(e);
    }
  }
}
