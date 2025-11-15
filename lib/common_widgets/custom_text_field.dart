import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:testing/utils/text_utils.dart';

import '../utils/color_utils.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final Rx<Color>? inactiveColor;

  final String? Function(String?)? validator;
  final TextInputType keyBoardtype;
  final bool readOnly;
  final bool obscureText;

  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final Icon? icon;
  final VoidCallback? onTap;
  final bool formatInput;

  final FocusNode? focusNode;

  const CustomTextField({
    Key? key,
    this.label,
    this.controller,
    this.inactiveColor,
    this.validator,
    this.keyBoardtype = TextInputType.text,
    this.readOnly = false,
    this.obscureText = false,
    this.onSaved,
    this.onChanged,
    this.focusNode,
    this.icon,
    this.onTap,
    this.formatInput = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> _buildFormatters() {
      // CARD NUMBER: maximum 16 digits
      if (label!.toLowerCase() == 'CARD NUMBER'.toLowerCase()) {
        return <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(16),
        ];
      }

      // CVV: maximum 3 digits
      if (label == 'CVV'.tr) {
        return <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(3),
        ];
      }

      // Old behaviour: numeric with 6 digits max when formatInput = true
      if (formatInput) {
        return <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(6),
        ];
      }

      return <TextInputFormatter>[];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label == null || label!.isEmpty ? '' : label!,
          style: TextUtils.textLabelheadings
        ),
        const SizedBox(height: 6),
        TextFormField(
          style: const TextStyle(color: ColorUtils.GREY_COLOR_PLACEHOLDER),
          controller: controller,
          readOnly: readOnly,
          obscureText: obscureText,

          keyboardType: keyBoardtype,
          cursorColor: ColorUtils.GREY_COLOR_PLACEHOLDER,
          inputFormatters: _buildFormatters(),
          validator: validator,
          onTap: onTap,
          onSaved: onSaved,
          focusNode: focusNode,
          onChanged: (value) {
            // send value up so card can update
            if (onChanged != null) {
              onChanged!(value);
            }

            // keep simple inactiveColor behaviour if provided
            if (inactiveColor != null) {
              inactiveColor!.value = ColorUtils.BRAND_COLOR;
            }
          },
          decoration: InputDecoration(
            hoverColor: ColorUtils.WHITE_COLOR_BACKGROUND,
            labelStyle: TextUtils.labelStyle,
            focusColor: ColorUtils.WHITE_COLOR_BACKGROUND,
            alignLabelWithHint: true,
            filled: true,
            fillColor: ColorUtils.WHITE_COLOR_BACKGROUND,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 2,
                color: ColorUtils.GREY_DOTTED,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 2,
                color: ColorUtils.GREY_DOTTED,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 2,
                color: ColorUtils.ERROR_RED,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 2,
                color: ColorUtils.ERROR_RED,
              ),
            ),
            isDense: false,
            prefixIcon: icon,
            errorStyle: const TextStyle(
              color: ColorUtils.ERROR_RED,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
