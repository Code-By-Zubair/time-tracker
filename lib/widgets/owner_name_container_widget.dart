import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_icons.dart';

class OwnerNameContainerWidget extends StatelessWidget {
  const OwnerNameContainerWidget({
    super.key,
    required this.ownerName,
    required this.isSelected,
    // required this.selectedProjectIndex,
    required this.onTap,
  });

  final String ownerName;
  final bool isSelected;
  // final int selectedProjectIndex;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          fixedSize: const Size(double.infinity, 60),
          backgroundColor:
              isSelected ? AppColors.appPrimaryColor : Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: SvgPicture.asset(
                IconImages.newProject,
                height: 20,
                color: isSelected ? Colors.white : AppColors.commonBlack,
              ),
            ),
            Flexible(
              child: Text(
                ownerName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : AppColors.commonBlack,
                ),
              ),
            ),
            
            isSelected
                ? SvgPicture.asset(
                    IconImages.arrowNextSmall,
                    height: 7,
                    color: isSelected ? Colors.white : AppColors.appLightGrey,
                  )
                : SvgPicture.asset(
                    IconImages.arrowDownSmall,
                    height: 7,
                    color: isSelected ? Colors.white : AppColors.appLightGrey,
                  )
          ],
        ),
      ),
      // child: ClipRRect(
      //   borderRadius: BorderRadius.circular(10),
      //   child: InkWell(
      //     onTap: onTap,
      //     child: Container(
      //       decoration: BoxDecoration(
      //           color: isSelected ? AppColors.appPrimaryColor : Colors.white,
      //           borderRadius: BorderRadius.circular(10)),
      //       padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      //       child: Row(
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Padding(
      //             padding: const EdgeInsets.only(right: 5),
      //             child: SvgPicture.asset(
      //               IconImages.newProject,
      //               height: 20,
      //               color: isSelected ? Colors.white : AppColors.commonBlack,
      //             ),
      //           ),
      //           Flexible(
      //             child: Text(
      //               ownerName,
      //               overflow: TextOverflow.ellipsis,
      //               maxLines: 1,
      //               style: TextStyle(
      //                 fontSize: 18,
      //                 fontWeight: FontWeight.w500,
      //                 color: isSelected ? Colors.white : AppColors.commonBlack,
      //               ),
      //             ),
      //           ),
      //           isSelected
      //               ? SvgPicture.asset(
      //                   IconImages.arrowDownSmall,
      //                   height: 7,
      //                   color:
      //                       isSelected ? Colors.white : AppColors.appLightGrey,
      //                 )
      //               : SvgPicture.asset(
      //                   IconImages.arrowNextSmall,
      //                   height: 7,
      //                   color:
      //                       isSelected ? Colors.white : AppColors.appLightGrey,
      //                 )
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
