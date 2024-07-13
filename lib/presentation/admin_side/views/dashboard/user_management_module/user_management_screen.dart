// ignore_for_file: use_build_context_synchronously, iterable_contains_unrelated_type

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_icons.dart';
import 'package:time_tracker/constants/app_images.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/helpers/helper_functions.dart';
import 'package:time_tracker/helpers/media_query_helper.dart';
import 'package:time_tracker/main.dart';
import 'package:time_tracker/models/teams_model.dart';
import 'package:time_tracker/models/user_model.dart';
import 'package:time_tracker/providers/dash_board_provider.dart';
import 'package:time_tracker/providers/user_dash_board_provider.dart';
import 'package:time_tracker/providers/user_management_provider.dart';
import 'package:time_tracker/services/database_services.dart';
import 'package:time_tracker/widgets/add_team_popup_widget.dart';
import 'package:time_tracker/widgets/alert_dialog_widget.dart';
import 'package:time_tracker/widgets/custom_loading.dart';
import 'package:time_tracker/widgets/delete_userpopup_widget.dart';
import 'package:time_tracker/widgets/display_team_name_Container_widget.dart';
import 'package:time_tracker/widgets/dropdown_button_widget.dart';
import 'package:time_tracker/widgets/global_appbar_with_profile.dart';
import 'package:time_tracker/widgets/global_text_button.dart';
import 'package:time_tracker/widgets/icon_button_with_label.dart';
import 'package:time_tracker/widgets/loader_state_widget.dart';
import 'package:time_tracker/widgets/multi_select_dropdown_widget.dart';
import 'package:time_tracker/widgets/multiselect_dropdown_flutter.dart';
import 'package:time_tracker/widgets/my_popup_button.dart';
import 'package:time_tracker/widgets/rounded_text_field.dart';
import 'package:time_tracker/widgets/user_settings_popup_content_widget.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  DatabaseServices databaseServices = DatabaseServices();
  @override
  void initState() {
    Provider.of<UserManagementProvider>(context, listen: false).onInit();
    super.initState();
  }

  String selectedItem = 'Users';
  String selectedItemOfUSer = 'Users';
  String selectedTeam = 'Default Team';
  UserModel? selectedUser;
  String? selectedRole;
  List<String> roles = [
    'TL',
    'Viewer',
    'Collaborator',
  ];
  List<String> items = [
    'Users',
    'Admin',
    'Team',
  ];
  final List<String> teams = [
    'Default Team',
    'QA Team',
    'Support Team',
    'SEO Team',
    'Laravel Team',
    'UI/UX Team',
    'Front-End Team',
    'HR Team',
    'Flutter Team',
    'React JS Team',
  ];
  List<Map<String, String>> usersData = [
    {
      'username': 'James Williams',
      'usermail': 'jameswilliams@gmail.com',
      'id': '8416bdb486dbn641',
      'team': 'Default Team',
      'lastsynced': 'May.25 2023, 14:10:15',
      'owner': 'true',
      'userprofile': AppImages.profileImage
    },
    {
      'username': 'Kristin Watson',
      'usermail': 'kristinwaston@gmail.com',
      'id': '8416bdb486dbn641',
      'team': 'Default Team',
      'owner': 'false',
      'lastsynced': 'May.25 2023, 14:10:15',
      'userprofile': AppImages.kristinProfileImage
    },
    {
      'username': 'Jane Cooper',
      'usermail': 'janecooper@gmail.com',
      'id': '8416bdb486dbn641',
      'team': 'Default Team',
      'owner': 'true',
      'lastsynced': 'May.25 2023, 14:10:15',
      'userprofile': AppImages.janeProfileImage
    },
    {
      'username': 'Wade Warren',
      'usermail': 'wadewarren@gmail.com',
      'id': '8416bdb486dbn641',
      'team': 'Default Team',
      'owner': 'true',
      'lastsynced': 'May.25 2023, 14:10:15',
      'userprofile': AppImages.wadeProfileImage
    }
  ];
  Loader createTeam = Loader();
  final TextEditingController teamController = TextEditingController();
  final TextEditingController searchUserController = TextEditingController();
  final TextEditingController multilineTextInputController =
      TextEditingController();
  final GlobalKey<FormState> addUserKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final dashBoardProvider =
        Provider.of<DashBoardProvider>(context, listen: false);
    final userManagementProvider =
        Provider.of<UserManagementProvider>(context, listen: false);
    final userDashBoardProvider =
        Provider.of<UserDashBoardProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 50, right: 50),
              child: GlobalAppBarWithProfile(
                showTitle: true,
                title: AppTexts.userManagement,
                onStartBtn: () => userDashBoardProvider.startTimer(),
                onFinishBtn: () => userDashBoardProvider.stopTimer(),
                onMenuTap: () => dashBoardProvider.expandDrawerFunc(),
                onBreakBtn: () => userDashBoardProvider.startBreakTimer(),
                isSearchfieldShow: false,
                titleLefPadding: 0,
                titleRightPadding: 0,
                workTodayRightPad: 100,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 50, right: 50, top: 60),
              child: SizedBox(
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
                          'Search User',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 40,
                          decoration: boxDecorationForContainer(),
                          width: 250,
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
                    Padding(
                      padding:
                          EdgeInsets.only(right: context.w > 1030 ? 40 : 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'All Role',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration: boxDecorationForContainer(),
                            height: 40,
                            child: MultiSelectDropdownWidget(
                              width: 250,
                              splashColor: Colors.transparent,
                              includeSearch: false,
                              includeSelectAll: true,
                              initiallySelectedList: const [],
                              boxDecoration: boxDecorationForContainer(),
                              itemList: items,
                              onChange: (value) {},
                            ),
                          )
                        ],
                      ),
                    ),

                    Container(
                      decoration: boxDecorationForContainer(),
                      child: IconButtonWithLabel(
                        height: 40,
                        iconHeight: 15,
                        backgroundColor: Colors.white,
                        text: 'Add User',
                        borderColor: Colors.transparent,
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.appLightGrey),
                        icon: IconImages.plusIcon,
                        onTap: () async {
                          if (userManagementProvider.selectedTeam.isNotEmpty) {
                            showDialog(
                              barrierColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return Form(
                                  key: addUserKey,
                                  child: StatefulBuilder(
                                    builder: (context, setState1) =>
                                        AlertDialogWidget(
                                      title: 'Add New User',
                                      contentChild: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Select user',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: 440,
                                            child:
                                                DropDownButtonWidget<UserModel>(
                                              displayValueCallback: (item) =>
                                                  item.email,
                                              hint: 'Select user',
                                              validator: (p0) {
                                                if (p0?.email.isEmpty ?? true) {
                                                  return 'Select user';
                                                }
                                              },
                                              xOffset: 0,
                                              yOffset: -10,
                                              leftPadding: 10,
                                              rightPadding: 10,
                                              selectedItem: selectedUser,
                                              items: userManagementProvider
                                                  .usersList,
                                              onChanged: (value) {
                                                setState1(() {
                                                  selectedUser = value;
                                                });
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          const Text(
                                            'Select role',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: 440,
                                            child: DropDownButtonWidget<String>(
                                              displayValueCallback: (item) =>
                                                  item,
                                              validator: (p0) {
                                                if (p0?.isEmpty ?? true) {
                                                  return 'Select role';
                                                }
                                              },
                                              hint: 'Select role',
                                              xOffset: 0,
                                              yOffset: -10,
                                              leftPadding: 10,
                                              rightPadding: 10,
                                              selectedItem: selectedRole,
                                              items: roles,
                                              onChanged: (value) {
                                                setState1(() {
                                                  selectedRole = value;
                                                });
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 20,
                                            ),
                                            child: Center(
                                              child: SizedBox(
                                                width: 105,
                                                height: 40,
                                                child: GlobalTextButton(
                                                    bachgroundColor: AppColors
                                                        .appPrimaryColor,
                                                    buttonTextColor:
                                                        Colors.white,
                                                    text: 'Add User',
                                                    onTap: () {
                                                      if (addUserKey
                                                              .currentState
                                                              ?.validate() ??
                                                          false) {
                                                        addUserToTeam(
                                                            userManagementProvider);
                                                      }
                                                    }),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            context.showInfoSnackBar('Select team first');
                          }
                        },
                      ),
                    ),
                    // const SizedBox(width: 20),
                    Container(
                        height: 40,
                        width: 98,
                        decoration: boxDecorationForContainer(),
                        child: MyPopupButton(
                          titleIcon: IconImages.arrowDownSmall,
                          titleText: 'Users',
                          popupMenuItem: [
                            PopupMenuItem(
                              value: 1,
                              child: Row(
                                children: <Widget>[
                                  SvgPicture.asset(
                                    IconImages.export,
                                    color: AppColors.appDarkGrey,
                                  ),
                                  const SizedBox(width: 5),
                                  const Text('Export'),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 2,
                              child: Row(
                                children: <Widget>[
                                  SvgPicture.asset(
                                    IconImages.import,
                                    color: AppColors.appDarkGrey,
                                  ),
                                  const SizedBox(width: 5),
                                  const Text('Import'),
                                ],
                              ),
                            ),
                          ],
                          onChange: (value) {},
                        )),
                    // const SizedBox(width: 20),
                    Container(
                        height: 40,
                        width: 98,
                        decoration: boxDecorationForContainer(),
                        child: MyPopupButton(
                          titleIcon: IconImages.arrowDownSmall,
                          titleText: 'Users',
                          popupMenuItem: const [
                            PopupMenuItem(
                              value: 1,
                              child: Text(
                                'Users',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.appDarkGrey),
                              ),
                            ),
                            PopupMenuItem(
                              value: 2,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Hierarchy',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.appDarkGrey),
                                  ),
                                  Text(
                                    '(users)',
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.appDarkGrey),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 3,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Hierarchy',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.appDarkGrey),
                                  ),
                                  Text(
                                    '(Managers)',
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.appDarkGrey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          onChange: (value) {},
                        )),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 50, top: 30, bottom: 15),
                child: SizedBox(
                  width: 140,
                  height: 40,
                  child: IconButtonWithLabel(
                      text: 'User Setting',
                      icon: IconImages.user,
                      textColor: AppColors.appPrimaryColor,
                      iconHeight: 15,
                      borderColor: Colors.transparent,
                      onTap: () {
                        Provider.of<DashBoardProvider>(context, listen: false)
                            .changePage(8);
                      }),
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Container(
                      width: 200,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 20),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 20,
                                spreadRadius: 0,
                                offset: Offset(6, 2),
                                color: Color.fromRGBO(0, 0, 0, 0.08))
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(IconImages.threeUsers,
                                      color: AppColors.appPrimaryColor),
                                  const SizedBox(width: 10),
                                  const Text(
                                    'Add Team',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 25,
                                width: 25,
                                child: IconButton(
                                  style: IconButton.styleFrom(
                                      padding: const EdgeInsets.all(0),
                                      backgroundColor:
                                          AppColors.appPrimaryColor),
                                  icon: const Icon(
                                    Icons.add_rounded,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AddTeamPopUpWidget(
                                          title: 'Create Team',
                                          actionButtonName: 'Create',
                                          createTeamController: teamController,
                                          onCreateTap: () async {
                                            if (teamController.text
                                                .trim()
                                                .isNotEmpty) {
                                              try {
                                                Navigator.pop(context);
                                                await databaseServices.addTeams(
                                                    TeamModel(
                                                        teamName: teamController
                                                            .text
                                                            .trim()));
                                                teamController.clear();
                                                context.showSuccessSnackBar(
                                                    'Team added successfully!');
                                              } catch (e) {
                                                context.showErrorSnackBar(
                                                    e.toString());
                                                debugPrint(e.toString());
                                              }
                                            }
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Divider(
                              color: AppColors.appDarkGrey,
                            ),
                          ),
                          Flexible(
                            child: ScrollConfiguration(
                              behavior: ScrollConfiguration.of(context)
                                  .copyWith(scrollbars: false),
                              child: StreamBuilder(
                                stream: databaseServices.getTeams(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data?.docs.isEmpty ?? true) {
                                      return const Center(
                                        child: Text(
                                          'No Teams Found',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      );
                                    }
                                    return ListView.separated(
                                      padding: const EdgeInsets.only(top: 30),
                                      itemCount:
                                          snapshot.data?.docs.length ?? 0,
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                        height: 3,
                                      ),
                                      itemBuilder: (context, index) {
                                        return Consumer<UserManagementProvider>(
                                          builder: (context, userManagementProv,
                                                  child) =>
                                              DisplayTeamNameContainer(
                                            teamName: userManagementProvider
                                                .teamsList[index],
                                            selectedTeam:
                                                userManagementProv.selectedTeam,
                                            onTap: (p0) {
                                              userManagementProvider
                                                  .selectTeamFunc(p0);

                                              if (userManagementProvider
                                                  .selectedTeam.isNotEmpty) {
                                                userManagementProvider
                                                        .teamMembers =
                                                    userManagementProvider
                                                        .usersList
                                                        .where((element) {
                                                  final v = element.teams
                                                      ?.where((e) =>
                                                          e.teamId ==
                                                          userManagementProvider
                                                              .selectedTeam)
                                                      .toList();
                                                  if (v != null &&
                                                      v.isNotEmpty) {
                                                    return true;
                                                  }
                                                  return false;
                                                }).toList();
                                              }
                                            },
                                            onDeleteTap: () async {
                                              try {
                                                await databaseServices
                                                    .deleteTeam(
                                                  userManagementProv
                                                          .teamsList[index]
                                                          .id ??
                                                      '',
                                                );
                                                userManagementProv
                                                    .selectedTeam = '';
                                                Future.delayed(const Duration(
                                                    milliseconds: 200));
                                                context.showSuccessSnackBar(
                                                    'Team deleted successfully!');
                                              } catch (e) {
                                                context.showErrorSnackBar(
                                                    e.toString());
                                                debugPrint(e.toString());
                                              }
                                            },
                                            onEditTap: () async {
                                              await Future.delayed(
                                                  const Duration(
                                                      milliseconds: 100));
                                              showDialog(
                                                context: context,
                                                builder: (context1) {
                                                  teamController.text =
                                                      userManagementProv
                                                          .teamsList[index]
                                                          .teamName;
                                                  return AddTeamPopUpWidget(
                                                    title: 'Edit Team',
                                                    actionButtonName: 'Edit',
                                                    createTeamController:
                                                        teamController,
                                                    onCreateTap: () async {
                                                      if (teamController.text
                                                          .trim()
                                                          .isNotEmpty) {
                                                        try {
                                                          Navigator.pop(
                                                              context);
                                                          await databaseServices
                                                              .updateTeam(
                                                            TeamModel(
                                                              teamName:
                                                                  teamController
                                                                      .text
                                                                      .trim(),
                                                              id: userManagementProv
                                                                      .teamsList[
                                                                          index]
                                                                      .id ??
                                                                  '',
                                                            ),
                                                          );
                                                          teamController
                                                              .clear();
                                                          context
                                                              .showSuccessSnackBar(
                                                            'Team updated successfully!',
                                                          );
                                                        } catch (e) {
                                                          context
                                                              .showErrorSnackBar(
                                                            e.toString(),
                                                          );
                                                          debugPrint(
                                                            e.toString(),
                                                          );
                                                        }
                                                      }
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  }

                                  return const WaveLoadingWidget(
                                    color: AppColors.appPrimaryColor,
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Consumer<UserManagementProvider>(
                        builder: (context, userManagementProv, child) {
                          return userManagementProv.teamMembers.isEmpty
                              ? const Center(
                                  child: Text(
                                    'No users found!',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              : ListView.separated(
                                  itemCount:
                                      userManagementProv.teamMembers.length,
                                  itemBuilder: (context, index) {
                                    String role = userManagementProv
                                            .teamMembers[index].teams
                                            ?.firstWhere(
                                              (element) =>
                                                  element.teamId ==
                                                  userManagementProv
                                                      .selectedTeam,
                                            )
                                            .role ??
                                        '';

                                    return Padding(
                                      padding: EdgeInsets.only(
                                          left: 30,
                                          top: context.w > 1160 ? 0 : 20,
                                          bottom: context.w > 1160 ? 0 : 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              NetworkImageWidget(
                                                imageUrl: userManagementProv
                                                        .teamMembers[index]
                                                        .profile ??
                                                    '',
                                              ),
                                              const SizedBox(width: 30),
                                              context.w > 1160
                                                  ? SizedBox(
                                                      width: 250,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          top: 20,
                                                          bottom: 30,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              '${userManagementProv.teamMembers[index].firstName ?? ''} ${userManagementProv.teamMembers[index].lastName ?? ''}',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            Text(
                                                              userManagementProv
                                                                  .teamMembers[
                                                                      index]
                                                                  .email,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: AppColors
                                                                    .appLightGrey,
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                const Text(
                                                                  'Role: ',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                Text(
                                                                  (userManagementProv
                                                                              .teamMembers[
                                                                                  index]
                                                                              .teams
                                                                              ?.isEmpty ??
                                                                          true)
                                                                      ? ""
                                                                      : userManagementProv
                                                                              .teamMembers[index]
                                                                              .teams
                                                                              ?.firstWhere((element) => element.teamId == userManagementProv.selectedTeam)
                                                                              .role ??
                                                                          '',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 1,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: AppColors
                                                                          .appLightGrey),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                const Text(
                                                                  'Last Synced: ',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                Flexible(
                                                                  child: Text(
                                                                    usersData[index]
                                                                            [
                                                                            'lastsynced'] ??
                                                                        '',
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 1,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        color: AppColors
                                                                            .appLightGrey),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                  height: 35,
                                                  width: 75,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: AppColors
                                                            .appLightGrey,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  child: MyPopupButton(
                                                    titleText: role,
                                                    titleIcon: IconImages
                                                        .arrowDownSmall,
                                                    horizontalPadding: 0,
                                                    popupMenuItem: const [
                                                      PopupMenuItem(
                                                        value: 1,
                                                        child: Text(
                                                          'Viewer',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .appDarkGrey,
                                                          ),
                                                        ),
                                                      ),
                                                      PopupMenuItem(
                                                        value: 2,
                                                        child: Text(
                                                          'Collaborator',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .appDarkGrey,
                                                          ),
                                                        ),
                                                      ),
                                                      PopupMenuItem(
                                                        value: 3,
                                                        child: Text(
                                                          'TL',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .appDarkGrey,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                    onChange: (value) {
                                                      switch (value) {
                                                        case 1:
                                                          updateUserRole(
                                                              userManagementProvider,
                                                              index,
                                                              'Viewer');

                                                          break;
                                                        case 2:
                                                          updateUserRole(
                                                            userManagementProvider,
                                                            index,
                                                            'Collaborater',
                                                          );

                                                          break;
                                                        case 3:
                                                          updateUserRole(
                                                            userManagementProvider,
                                                            index,
                                                            'TL',
                                                          );

                                                          break;
                                                        default:
                                                      }
                                                    },
                                                  )),
                                              SizedBox(
                                                  width: context.w > 1350
                                                      ? 75
                                                      : context.w / 100),
                                              IconButton(
                                                icon: SvgPicture.asset(
                                                  IconImages.settings,
                                                  color: AppColors.appLightGrey,
                                                ),
                                                onPressed: () {
                                                  showDialog(
                                                    barrierColor:
                                                        Colors.transparent,
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialogWidget(
                                                        title: AppTexts
                                                            .userSettings,
                                                        contentChild:
                                                            UserSettingsPopupContentWidget(
                                                          onTapEnableTrackingWhenIdle:
                                                              () {
                                                            Provider.of<DashBoardProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .enableTrackingWhenIdle(
                                                                    true);
                                                          },
                                                          onTapDisableTrackingWhenIdle:
                                                              () {
                                                            Provider.of<DashBoardProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .enableTrackingWhenIdle(
                                                                    false);
                                                          },
                                                          onTapStopTrackingIdIdleXMinutes:
                                                              () {},
                                                          onTapEnableTakingSSWhileTracking:
                                                              () {
                                                            Provider.of<DashBoardProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .enableTakingSSWhileTracking(
                                                                    true);
                                                          },
                                                          onTapTakeSSEveryXMinutes:
                                                              () {},
                                                          onTapEnableAutomaticMode:
                                                              () {
                                                            Provider.of<DashBoardProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .enableAutomaticMode(
                                                                    true);
                                                          },
                                                          onTapDisableAutomaticMode:
                                                              () {
                                                            Provider.of<DashBoardProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .enableAutomaticMode(
                                                                    false);
                                                          },
                                                          onTapEnableStealthMode:
                                                              () {
                                                            Provider.of<DashBoardProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .enableStealthMode(
                                                                    true);
                                                          },
                                                          onTapDisableStealthMode:
                                                              () {
                                                            Provider.of<DashBoardProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .enableStealthMode(
                                                                    false);
                                                          },
                                                          onTapEnableTrackingAwayTime:
                                                              () {
                                                            Provider.of<DashBoardProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .allowTrackingAwayTime(
                                                                    AppTexts
                                                                        .enable);
                                                          },
                                                          onTapWhenTrackingTrackingAwayTime:
                                                              () {
                                                            Provider.of<DashBoardProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .allowTrackingAwayTime(
                                                                    AppTexts
                                                                        .whenTracking);
                                                          },
                                                          onTapNeverAllowTrackingAwayTime:
                                                              () {
                                                            Provider.of<DashBoardProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .allowTrackingAwayTime(
                                                                    AppTexts
                                                                        .never);
                                                          },
                                                          onTapEnableSendingWarningEmail:
                                                              () {
                                                            Provider.of<DashBoardProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .allowSendWarningEmailsToUSers(
                                                                    true);
                                                          },
                                                          onTapDisableSendingWarningEmail:
                                                              () {
                                                            Provider.of<DashBoardProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .allowSendWarningEmailsToUSers(
                                                                    false);
                                                          },
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                              SizedBox(
                                                  width: context.w > 1350
                                                      ? 75
                                                      : context.w / 100),
                                              // IconButton(
                                              //   icon: SvgPicture.asset(
                                              //     IconImages.userEdit,
                                              //     color: AppColors.appLightGrey,
                                              //   ),
                                              //   onPressed: () {
                                              //     showDialog(
                                              //       context: context,
                                              //       builder: (context) {
                                              //         return StatefulBuilder(
                                              //           builder: (context,
                                              //                   setState1) =>
                                              //               AlertDialogWidget(
                                              //             title:
                                              //                 AppTexts.editUser,
                                              //             contentChild:
                                              //                 EditUSerPopupContentWidget(
                                              //               selectedTeam:
                                              //                   selectedTeam,
                                              //               teams: teams,
                                              //               listOfIds: teams,
                                              //               selectedId:
                                              //                   selectedTeam,
                                              //               teamdropdownOnChanged:
                                              //                   (value) {
                                              //                 setState1(() {
                                              //                   selectedTeam =
                                              //                       value;
                                              //                 });
                                              //               },
                                              //               iddropdownOnChanged:
                                              //                   (value) {
                                              //                 setState1(() {
                                              //                   selectedTeam =
                                              //                       value;
                                              //                 });
                                              //               },
                                              //               onSaveTap: () {},
                                              //             ),
                                              //           ),
                                              //         );
                                              //       },
                                              //     );
                                              //   },
                                              // ),
                                              SizedBox(
                                                  width: context.w > 1350
                                                      ? 75
                                                      : context.w / 100),
                                              IconButton(
                                                icon: SvgPicture.asset(
                                                  IconImages.userDelete,
                                                ),
                                                onPressed: () {
                                                  showDialog(
                                                    barrierColor:
                                                        Colors.transparent,
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialogWidget(
                                                        title:
                                                            AppTexts.deleteUser,
                                                        // actionsAlignment:
                                                        //     MainAxisAlignment
                                                        //         .center,
                                                        contentChild:
                                                            DeleteUserPopupContentWidget(
                                                          onDeleteTap: () {
                                                            try {
                                                              databaseServices
                                                                  .deleteUserFromTeam(
                                                                teamId: userManagementProvider
                                                                    .selectedTeam,
                                                                userEmail:
                                                                    userManagementProv
                                                                        .teamMembers[
                                                                            index]
                                                                        .email,
                                                                role: userManagementProv
                                                                        .teamMembers[
                                                                            index]
                                                                        .teams
                                                                        ?.firstWhere((element) =>
                                                                            element.teamId ==
                                                                            userManagementProv.selectedTeam)
                                                                        .role ??
                                                                    '',
                                                              );
                                                              selectedUser =
                                                                  null;
                                                              context
                                                                  .showSuccessSnackBar(
                                                                'User deleted successfully!',
                                                              );

                                                              Navigator.pop(
                                                                  context);
                                                            } catch (e, s) {
                                                              context.showErrorSnackBar(
                                                                  e.toString());

                                                              log(
                                                                e.toString(),
                                                                stackTrace: s,
                                                              );
                                                            }
                                                          },
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                              const SizedBox(width: 20)
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const Divider(
                                        color: AppColors.appDarkGrey);
                                  },
                                );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 40),
          )
        ],
      ),
    );
  }

  addUserToTeam(UserManagementProvider userManagementProvider) {
    var val = userManagementProvider.teamMembers
        .any((element) => element.email == selectedUser?.email);

    try {
      if (val == true) {
        context.showInfoSnackBar(
          'User already exists in team',
        );
        selectedUser = null;
      } else {
        if (selectedUser == null) {
          context.showInfoSnackBar('Select user first');
        } else {
          Navigator.pop(context);
          databaseServices.addUserToTeam(
            userManagementProvider.selectedTeam,
            selectedUser?.email ?? '',
            selectedRole ?? '',
          );
          context.showSuccessSnackBar(
            'User added successfully!',
          );
          selectedUser = null;
        }
      }
    } catch (e, s) {
      context.showErrorSnackBar(e.toString());
      log(
        e.toString() + s.toString(),
      );
    }
  }

  updateUserRole(
    UserManagementProvider userManagementProvider,
    int index,
    String userRole,
  ) async {
    databaseServices.deleteUserFromTeam(
      teamId: userManagementProvider.selectedTeam,
      userEmail: userManagementProvider.teamMembers[index].email,
      role: userManagementProvider.teamMembers[index].teams
              ?.firstWhere((element) =>
                  element.teamId == userManagementProvider.selectedTeam)
              .role ??
          '',
    );
    databaseServices.updateUserRole(
      userManagementProvider.selectedTeam,
      userManagementProvider.teamMembers[index].email,
      userRole,
    );
  }
}

class NetworkImageWidget extends StatelessWidget {
  const NetworkImageWidget({
    super.key,
    required this.imageUrl,
    this.radius,
  });
  final String imageUrl;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      var img;
      if (imageUrl.isEmpty || imageUrl == '') {
        img = const ExactAssetImage('assets/images/man.png');
      } else {
        img = NetworkImage(imageUrl);
      }
      return CircleAvatar(
        radius: radius ?? 25,
        backgroundImage: img,
      );
    });
  }
}
