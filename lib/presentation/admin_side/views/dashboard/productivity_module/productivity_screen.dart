import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_icons.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/helpers/media_query_helper.dart';
import 'package:time_tracker/providers/dash_board_provider.dart';
import 'package:time_tracker/providers/user_dash_board_provider.dart';
import 'package:time_tracker/widgets/alert_dialog_widget.dart';
import 'package:time_tracker/widgets/app_checkbox.dart';
import 'package:time_tracker/widgets/dropdown_button_widget.dart';
import 'package:time_tracker/widgets/global_appbar_with_profile.dart';
import 'package:time_tracker/widgets/global_text_button.dart';
import 'package:time_tracker/widgets/icon_button_with_label.dart';
import 'package:time_tracker/widgets/rounded_text_field.dart';

class ProductivityScreen extends StatefulWidget {
  const ProductivityScreen({super.key});

  @override
  State<ProductivityScreen> createState() => _ProductivityScreenState();
}

class _ProductivityScreenState extends State<ProductivityScreen> {
  final List<Map<String, String>> appsList = [
    {'app': 'www.instagram.com', 'type': 'Productive'},
    {'app': 'www.google.com', 'type': 'Productive'},
    {'app': 'www.facebook.com', 'type': 'Productive'},
  ];
  String selectedUser = 'Users';
  List<String> items = [
    'Users',
    'Admin',
    'Team',
  ];
  bool checkbox = false;
  @override
  Widget build(BuildContext context) {
    final dashBoardProvider =
        Provider.of<DashBoardProvider>(context, listen: false);
    final userDashBoardProvider =
        Provider.of<UserDashBoardProvider>(context, listen: false);

    return Scaffold(
        backgroundColor: AppColors.bgColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 30,
              left: 50,
              right: 50,
            ),
            child: Column(
              children: [
                GlobalAppBarWithProfile(
                  titleRightPadding: context.w > 900 ? 0 : 100,
                  showTitle: true,
                  title: AppTexts.productivity,
                  onStartBtn: () => userDashBoardProvider.startTimer(),
                  onFinishBtn: () => userDashBoardProvider.stopTimer(),
                  onMenuTap: () => dashBoardProvider.expandDrawerFunc(),
                  onBreakBtn: () => userDashBoardProvider.startBreakTimer(),
                  isSearchfieldShow: false,
                  workTodayRightPad: 50,
                ),
                const SizedBox(height: 75),
                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Flexible(
                            child: Text(
                              AppTexts.productiveAndUnproductiveApp,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            height: 45,
                            width: 205,
                            child: IconButtonWithLabel(
                                text: AppTexts.addAnApporWebsite,
                                icon: IconImages.plusIcon,
                                textColor: AppColors.appPrimaryColor,
                                iconHeight: 15,
                                borderColor: AppColors.appPrimaryColor,
                                onTap: () {
                                  showDialog(
                                    barrierColor: Colors.transparent,
                                    context: context,
                                    builder: (context) {
                                      return StatefulBuilder(
                                        builder: (context, setState1) =>
                                            AddAppOrWebsitePopUPWidget(
                                          selectedItem: selectedUser,
                                          items: items,
                                          title: 'Add an App or Website',
                                          buttonText: 'Add',
                                          textFieldHint: 'Set A New Password',
                                          onCloseTap: () {
                                            Navigator.pop(context);
                                          },
                                          onDropdownChange: (value) {
                                            selectedUser = value;
                                            setState1(() {});
                                          },
                                          onSaveTap: () {
                                            Navigator.pop(context);
                                          },
                                          showCheckBox: false,
                                        ),
                                      );
                                    },
                                  );
                                }),
                          )
                        ],
                      ),
                      const SizedBox(height: 50),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.appDarkGrey),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ProductiveTableColumnWidget(
                                title: Padding(
                                  padding: const EdgeInsets.symmetric(
                                        vertical: 30,
                                      ) +
                                      EdgeInsets.only(
                                        left: context.w * 0.030,
                                      ),
                                  child: const Text(
                                    'Name',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                itemsToGenerate: List.generate(
                                  appsList.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                        ) +
                                        EdgeInsets.only(
                                          left: context.w * 0.030,
                                        ),
                                    child: Text(
                                      appsList[index]['app']!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.appDarkGrey),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ProductiveTableColumnWidget(
                                title: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 30,
                                  ),
                                  child: Text(
                                    'Type',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                itemsToGenerate: List.generate(
                                  appsList.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    child: Text(
                                      appsList[index]['type']!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.appDarkGrey),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Expanded(
                              child: ProductiveTableColumnWidget(
                                  title: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 30,
                                    ),
                                    child: Text(
                                      'Exclude',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  itemsToGenerate: []),
                            ),
                            Expanded(
                              child: ProductiveTableColumnWidget(
                                title: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 30,
                                  ),
                                  child: Text(
                                    'Actions',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                itemsToGenerate: List.generate(
                                  appsList.length,
                                  (index) => Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return StatefulBuilder(
                                                  builder: (context,
                                                          setState1) =>
                                                      AddAppOrWebsitePopUPWidget(
                                                    selectedItem: selectedUser,
                                                    items: items,
                                                    title: 'Edit',
                                                    textFieldLabel: 'Name',
                                                    buttonText: 'Update',
                                                    onCloseTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    onDropdownChange: (value) {
                                                      selectedUser = value;
                                                      setState1(() {});
                                                    },
                                                    onSaveTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    showCheckBox: true,
                                                    onCheckBoxTap: (value) {
                                                      setState1(() {
                                                        // log(checkbox
                                                        //     .toString());
                                                        checkbox = !checkbox;
                                                      });
                                                    },
                                                    checkboxSelected: checkbox,
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          icon: SvgPicture.asset(
                                            IconImages.userEdit,
                                            color: AppColors.appLightGrey,
                                          )),
                                      const SizedBox(width: 20),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              surfaceTintColor: Colors.white,
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      top: 10, bottom: 10),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                              content: const Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    'Are you sure want to remove this app?',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: AppColors
                                                            .appDarkGrey),
                                                  ),
                                                  SizedBox(height: 20),
                                                  SizedBox(
                                                    width: 500,
                                                    child: Divider(
                                                      color:
                                                          AppColors.appDarkGrey,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              actionsAlignment:
                                                  MainAxisAlignment.center,
                                              actions: [
                                                SizedBox(
                                                  height: 40,
                                                  width: 85,
                                                  child: GlobalTextButton(
                                                    buttonTextColor: AppColors
                                                        .appPrimaryColor,
                                                    borderColor: AppColors
                                                        .appPrimaryColor,
                                                    text: 'Close',
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 40,
                                                  width: 85,
                                                  child: GlobalTextButton(
                                                    buttonTextColor:
                                                        Colors.white,
                                                    borderColor: AppColors
                                                        .appPrimaryColor,
                                                    bachgroundColor: AppColors
                                                        .appPrimaryColor,
                                                    text: 'Confirm',
                                                    onTap: () {
                                                      appsList.removeAt(index);
                                                      Navigator.pop(context);
                                                      setState(() {});
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        icon: SvgPicture.asset(
                                          IconImages.userDelete,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class ProductiveTableColumnWidget extends StatelessWidget {
  const ProductiveTableColumnWidget({
    super.key,
    required this.title,
    required this.itemsToGenerate,
  });
  final Widget title;
  final List<Widget> itemsToGenerate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        const Divider(
          color: AppColors.appDarkGrey,
        ),
        ...itemsToGenerate,
      ],
    );
  }
}

class AddAppOrWebsitePopUPWidget extends StatelessWidget {
  const AddAppOrWebsitePopUPWidget({
    super.key,
    required this.items,
    required this.title,
    this.textFieldHint,
    this.textFieldLabel,
    required this.selectedItem,
    required this.onDropdownChange,
    required this.showCheckBox,
    required this.onCloseTap,
    required this.onSaveTap,
    this.checkboxSelected,
    this.onCheckBoxTap,
    required this.buttonText,
  });

  final List<String> items;
  final String title;
  final String? textFieldHint;
  final String? textFieldLabel;
  final String selectedItem;
  final String buttonText;
  final ValueChanged onDropdownChange;
  final bool showCheckBox;
  final bool? checkboxSelected;
  final VoidCallback onCloseTap;
  final VoidCallback onSaveTap;
  final ValueChanged? onCheckBoxTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialogWidget(
      title: title, //'Add an App or Website'
      contentChild: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 740,
              child: Divider(
                color: AppColors.appDarkGrey,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 370,
                  height: 40,
                  child: RoundedTextField(
                      textFieldColor: Colors.white,
                      borderColor: AppColors.appDarkGrey,
                      hintText: textFieldHint,
                      // contentPaddingbottom: 17,
                      labelText: textFieldLabel,
                      enableBorder: true,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: false),
                ),
                const SizedBox(width: 20),
                Flexible(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: AppColors.appDarkGrey)),
                    width: double.infinity,
                    child: DropDownButtonWidget(
                        displayValueCallback: (item) => 'jdfdf',
                        leftPadding: 10,
                        rightPadding: 10,
                        yOffset: -10,
                        selectedItem: selectedItem,
                        items: items,
                        onChanged: onDropdownChange),
                  ),
                )
              ],
            ),
            showCheckBox
                ? Padding(
                    padding:
                        const EdgeInsets.only(top: 20, bottom: 30, left: 5),
                    child: Row(
                      children: [
                        AppCheckbox(
                          checkbox: checkboxSelected ?? false,
                          onValueChanged: onCheckBoxTap ?? (value) {},
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          'Prevent Time Tracking from entering Break mode while the user is using this app.',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.appDarkGrey),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 30),
            const SizedBox(
              // width: 740,
              child: Divider(
                color: AppColors.appDarkGrey,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Exclude Teams or Users (optional):',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 30),
            Consumer<DashBoardProvider>(
              builder: (context, dashBoardProvider, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        onTap: () {
                          Provider.of<DashBoardProvider>(context, listen: false)
                              .excludeTeamsFunc();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Exclude Teams',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: dashBoardProvider.excludeTeams
                                      ? AppColors.appPrimaryColor
                                      : AppColors.appDarkGrey),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 135,
                              child: Divider(
                                color: dashBoardProvider.excludeTeams
                                    ? AppColors.appPrimaryColor
                                    : Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 50),
                      InkWell(
                        focusColor: Colors.transparent,
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        onTap: () {
                          Provider.of<DashBoardProvider>(context, listen: false)
                              .excludeUsers();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Exclude Users',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: dashBoardProvider.excludeTeams != true
                                      ? AppColors.appPrimaryColor
                                      : AppColors.appDarkGrey),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 135,
                              child: Divider(
                                color: dashBoardProvider.excludeTeams != true
                                    ? AppColors.appPrimaryColor
                                    : Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  dashBoardProvider.excludeTeams
                      ? const SizedBox.shrink()
                      : Row(
                          children: [
                            const Text(
                              'Team: ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.appDarkGrey,
                              ),
                            ),
                            const Text(
                              'Default Team',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.appDarkGrey,
                              ),
                            ),
                            const SizedBox(width: 30),
                            GlobalTextButton(
                              text: 'Select All',
                              bachgroundColor: Colors.white,
                              borderColor: Colors.white,
                              buttonTextColor: AppColors.blueColor,
                              onTap: () {},
                            )
                          ],
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                      border: Border.all(
                        color: AppColors.appDarkGrey,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            IconImages.circle,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            dashBoardProvider.excludeTeams
                                ? 'Default Team'
                                : 'Levihi163@gmai.com - (Muhmmad Umer)',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.appDarkGrey),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    color: AppColors.appDarkGrey,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 45,
                        width: 85,
                        child: GlobalTextButton(
                            borderColor: AppColors.appPrimaryColor,
                            buttonTextColor: AppColors.appPrimaryColor,
                            text: AppTexts.close,
                            onTap: onCloseTap),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        height: 45,
                        width: 85,
                        child: GlobalTextButton(
                          bachgroundColor: AppColors.appPrimaryColor,
                          borderColor: AppColors.appPrimaryColor,
                          buttonTextColor: Colors.white,
                          text: buttonText,
                          onTap: onSaveTap,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      // actionsAlignment: MainAxisAlignment.center,
      // actions: [
      // SizedBox(
      //   height: 40,
      //   width: 85,
      //   child: GlobalTextButton(
      //       borderColor: AppColors.appPrimaryColor,
      //       buttonTextColor: AppColors.appPrimaryColor,
      //       text: AppTexts.close,
      //       onTap: onCloseTap),
      // ),
      // SizedBox(
      //   height: 40,
      //   width: 85,
      //   child: GlobalTextButton(
      //     bachgroundColor: AppColors.appPrimaryColor,
      //     borderColor: AppColors.appPrimaryColor,
      //     buttonTextColor: Colors.white,
      //     text: buttonText,
      //     onTap: onSaveTap,
      //   ),
      // ),
      // ],
    );
  }
}
