import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:time_tracker/constants/app_icons.dart';
import 'package:time_tracker/constants/app_text.dart';

class GlobalTimeTrackingTextWithIcon extends StatelessWidget {
  const GlobalTimeTrackingTextWithIcon({
    super.key,
    required this.mainAxisAlignment,
    this.textStyle,
  });
  final MainAxisAlignment mainAxisAlignment;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        SvgPicture.asset(
          IconImages.radar,
          height: 30,
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            AppTexts.timeTracking,
            overflow: TextOverflow.ellipsis,
            style: textStyle ??
                const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}
