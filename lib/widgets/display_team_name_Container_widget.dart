import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focusable_control_builder/focusable_control_builder.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_icons.dart';
import 'package:time_tracker/helpers/media_query_helper.dart';
import 'package:time_tracker/models/teams_model.dart';

class DisplayTeamNameContainer extends StatelessWidget {
  DisplayTeamNameContainer({
    super.key,
    required this.teamName,
    required this.onDeleteTap,
    required this.onEditTap,
    required this.selectedTeam,
    required this.onTap,
  });

  final TeamModel teamName;
  final String selectedTeam;
  final VoidCallback onDeleteTap;
  final VoidCallback onEditTap;
  final Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return FocusableControlBuilder(builder: (_, FocusableControlState control) {
      return Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned.fill(
              child: AnimatedOpacity(
            opacity: control.isHovered ? 0.9 : 0.0,
            duration: const Duration(milliseconds: 600),
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.lightBlack,
                  borderRadius: BorderRadius.circular(20)),
            ),
          )),
          TextButton(
            style: TextButton.styleFrom(
                backgroundColor: selectedTeam == teamName.id
                    ? AppColors.appPrimaryColor
                    : null),
            onPressed: () {
              onTap(teamName.id ?? '');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    teamName.teamName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: selectedTeam == teamName.id || control.isHovered
                          ? Colors.white
                          : AppColors.appLightGrey,
                    ),
                  ),
                ),
                Center(
                    child: TooltipVisibility(
                  visible: false,
                  child: PopupMenuButton(
                    tooltip: null,
                    enableFeedback: false,
                    icon: SvgPicture.asset(
                      IconImages.menuStar,
                      color: selectedTeam == teamName.id || control.isHovered
                          ? Colors.white
                          : AppColors.appLightGrey,
                    ),
                    color: Colors.white,
                    surfaceTintColor: Colors.white,
                    elevation: 5,
                    position: PopupMenuPosition.under,
                    itemBuilder: (context) => [
                      PopupMenuItem(
                          onTap: onDeleteTap,
                          child: Row(
                            children: [
                              SvgPicture.asset(IconImages.delete),
                              const SizedBox(width: 10),
                              const Text('Delete',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14)),
                            ],
                          )),
                      PopupMenuItem(
                          onTap: onEditTap,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                IconImages.userEdit,
                                color: AppColors.appLightGrey,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Edit',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ],
      );
    });
  }
}
