import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:time_tracker/constants/app_icons.dart';

class CustomCheckBox extends StatefulWidget {
  final bool isSelected;
  final ValueChanged<bool> onChanged;

  const CustomCheckBox({
    Key? key,
    required this.isSelected,
    required this.onChanged,
  }) : super(key: key);

  @override
  State createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: OutlinedButton(
        onPressed: () {
          widget.onChanged(!widget.isSelected);
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.all(0),
          shape: const CircleBorder(),
          side: const BorderSide(
            width: 0,
            color: Colors.transparent,
          ),
        ),
        child: widget.isSelected
            ? SvgPicture.asset(IconImages.selectedCircle)
            : SvgPicture.asset(IconImages.circle),
      ),
    );
  }
}
