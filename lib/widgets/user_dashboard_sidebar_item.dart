import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/helpers/media_query_helper.dart';
import 'package:time_tracker/providers/user_dash_board_provider.dart';

class USerDashboardSideBarItemWidget extends StatefulWidget {
  const USerDashboardSideBarItemWidget({
    super.key,
    required this.dashBoardProvider,
    required this.sidebarItems,
    required this.currentIndex,
    required this.onTap,
  });
  final UserDashBoardProvider dashBoardProvider;
  final List<Map<String, String>> sidebarItems;
  final int currentIndex;
  final VoidCallback onTap;

  @override
  State<USerDashboardSideBarItemWidget> createState() =>
      _USerDashboardSideBarItemWidget();
}

class _USerDashboardSideBarItemWidget
    extends State<USerDashboardSideBarItemWidget> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final userDashBoardProv =
        Provider.of<UserDashBoardProvider>(context, listen: false);
    return InkWell(
      hoverColor: Colors.black,
      onHover: (value) {
        setState(() {
          isHover = value;
        });
      },
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Stack(
          children: [
            widget.dashBoardProvider.isClicked == widget.currentIndex &&
                    context.w > 900 &&
                    userDashBoardProv.expandDrawer == true
                ? Image.asset(
                    'assets/images/menu_bg.png',
                  )
                : const SizedBox.shrink(),
            Container(
              padding: EdgeInsets.only(
                  left: 15,
                  top: context.w > 900 && userDashBoardProv.expandDrawer == true
                      ? 20
                      : 0),
              height: 50,
              // alignment: Alignment.center,
              decoration: BoxDecoration(
                shape:
                    widget.dashBoardProvider.isClicked == widget.currentIndex &&
                            (context.w < 900 ||
                                userDashBoardProv.expandDrawer == false)
                        ? BoxShape.circle
                        : BoxShape.rectangle,
                color:
                    widget.dashBoardProvider.isClicked == widget.currentIndex &&
                            (context.w < 900 ||
                                userDashBoardProv.expandDrawer == false)
                        ? AppColors.bgColor
                        : Colors.transparent,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal:
                      context.w < 900 || userDashBoardProv.expandDrawer == false
                          ? 20
                          : 5,
                  vertical:
                      context.w < 900 || userDashBoardProv.expandDrawer == false
                          ? 17
                          : 0,
                ),
                child: Transform.scale(
                  scale: isHover ? 1.1 : 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        widget.sidebarItems[widget.currentIndex]['Icon'] ?? '',
                        color: widget.dashBoardProvider.isClicked ==
                                    widget.currentIndex ||
                                isHover == true
                            ? AppColors.appPrimaryColor
                            : Colors.white,
                        height: 16,
                      ),
                      if (context.w >= 900) const SizedBox(width: 10),
                      if (context.w >= 900)
                        Flexible(
                          child: Text(
                            widget.sidebarItems[widget.currentIndex]['text'] ??
                                '',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: widget.dashBoardProvider.isClicked ==
                                          widget.currentIndex ||
                                      isHover == true
                                  ? AppColors.appPrimaryColor
                                  : Colors.white,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
