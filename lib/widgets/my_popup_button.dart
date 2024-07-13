import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:time_tracker/constants/app_colors.dart';

class MyPopupButton extends StatelessWidget {
  final List<PopupMenuEntry<int>> popupMenuItem;
  final ValueChanged<int> onChange;
  final String titleText;
  final String titleIcon;
  final double? horizontalPadding;
  const MyPopupButton(
      {super.key,
      required this.popupMenuItem,
      required this.onChange,
      required this.titleText,
      required this.titleIcon,
      this.horizontalPadding});

  @override
  Widget build(BuildContext context) {
    return TooltipVisibility(
      visible: false,
      child: PopupMenuButton(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        icon: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  titleText,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.appDarkGrey,
                  ),
                ),
              ),
              SvgPicture.asset(
                titleIcon,
                color: AppColors.appDarkGrey,
              )
            ],
          ),
        ),
        offset: const Offset(0, 50),
        itemBuilder: (context) => popupMenuItem,
        onSelected: onChange,
      ),
    );
  }
}