// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_icons.dart';
import 'package:time_tracker/helpers/media_query_helper.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/user_management_module/user_management_screen.dart';

class ProjectDetailsWidget extends StatelessWidget {
  const ProjectDetailsWidget({
    super.key,
    required this.title,
    required this.priority,
    required this.status,
    required this.onStartBtnTap,
    required this.onEditBtnTap,
    required this.onDeleteBtnTap,
    this.image,
    required this.onStatusChanged,
    this.onTitleTap,
  });
  final String title;
  final String priority;
  final String status;
  final String? image;
  final VoidCallback onStartBtnTap;
  final VoidCallback? onTitleTap;
  final VoidCallback onEditBtnTap;
  final VoidCallback onDeleteBtnTap;
  final ValueChanged onStatusChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: context.w * 0.03,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: InkWell(
                onTap: onTitleTap,
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.appDarkGrey,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NetworkImageWidget(
                  imageUrl: image ?? '',
                  radius: 15,
                ),
                SizedBox(
                  width: context.w * 0.03,
                ),
                SizedBox(
                  width: 85,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.flag,
                        color: priority == 'High'
                            ? Colors.red
                            : priority == 'Medium'
                                ? Colors.yellow
                                : Colors.green,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        priority,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.blueColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: context.w * 0.03,
                ),
                PopupMenuButton(
                  tooltip: status.isEmpty ? 'todo' : status,
                  child: Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius:
                          const BorderRadiusDirectional.all(Radius.circular(3)),
                      color: getStatusColor(status),
                    ),
                  ),
                  itemBuilder: (context) {
                    return [
                      popupMenuItemBuilder('In progress', Colors.blue),
                      popupMenuItemBuilder('Completed', Colors.green),
                      popupMenuItemBuilder('Pending', Colors.yellow),
                      popupMenuItemBuilder('Priority', Colors.red),
                      popupMenuItemBuilder('Todo', Colors.grey),
                    ];
                  },
                  onSelected: onStatusChanged,
                ),
                IconButton(
                  onPressed: onEditBtnTap,
                  icon: SvgPicture.asset(
                    IconImages.edit,
                  ),
                ),
                IconButton(
                  onPressed: onDeleteBtnTap,
                  icon: SvgPicture.asset(
                    IconImages.delete,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'priority':
        return Colors.red;
      case 'inprogress':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'todo':
        return Colors.grey;
      case 'pending':
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }

  PopupMenuItem<String> popupMenuItemBuilder(String text, Color color) {
    return PopupMenuItem(
        value: text.replaceAll(' ', '').toLowerCase(),
        child: Row(
          children: [
            Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius:
                    const BorderRadiusDirectional.all(Radius.circular(3)),
                color: color,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(text)
          ],
        ));
  }
}
