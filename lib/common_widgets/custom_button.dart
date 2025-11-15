//create custom button with all dynamically added but based structure


import 'package:flutter/material.dart';
import '../utils/color_utils.dart';
import '../utils/text_utils.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onTap;

  final Color? color;
  final double? width;
  final double? height;
  final double radius;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;

  const CustomButton({
    Key? key,
    required this.buttonText,
    this.onTap,
    this.color,
    this.width,
    this.height,
    this.radius = 6,
    this.padding = const EdgeInsets.symmetric(vertical: 12),
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonWidth = width ?? MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: buttonWidth,
        height: height,
        padding: padding,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color ?? ColorUtils.BRAND_COLOR,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Text(
          buttonText,
          style: textStyle ?? TextUtils.buttonText,
        ),
      ),
    );

}
}