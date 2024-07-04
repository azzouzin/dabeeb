import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/config/theme/light_theme_colors.dart';
import '../../../config/translations/strings_enum.dart';

import 'custom_text.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintTxt;
  final String? label;
  final String? initValue;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function? onPressedPrefixIcon;
  final VoidCallback? onPressedSuffixIcon;
  final Function? onChange;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Color? fillColor;
  final bool? obscureText;
  final bool? enable;
  final int? minLines;
  final int? maxLines;
  final double? horizontalPadding;
  final double? verticalPadding;
  final TextAlign? textAlign;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextFormField({
    super.key,
    this.hintTxt,
    this.label = "",
    this.onPressedPrefixIcon,
    this.keyboardType,
    this.controller,
    this.onChange,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.prefixIcon,
    this.fillColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.enable = true,
    this.onPressedSuffixIcon,
    this.suffixIcon,
    this.initValue = "",
    this.inputFormatters,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          txt: label ?? "",
          fontSize: 16.sp,
          color: LightThemeColors.primaryColor,
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.bold,
        ),
        8.verticalSpace,
        TextFormField(
          inputFormatters: inputFormatters,
          style: TextStyle(
            color: Theme.of(context).textTheme.labelLarge!.color,
          ),
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return Strings.enterValidData;
            }
            return null;
          },
          enabled: enable,
          minLines: minLines,
          maxLines: maxLines,
          textAlign: textAlign ?? TextAlign.start,
          decoration: InputDecoration(
            hintText: (hintTxt ?? "").tr,

            /*  label: CustomText(
              txt: label ?? "",
              fontSize: 14.sp,
              overflow: TextOverflow.ellipsis,
            ),*/
            fillColor: fillColor ?? Theme.of(context).colorScheme.surface,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
              ),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 134, 133, 133).withOpacity(0.5),
                width: 1.5.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(
                color: LightThemeColors.primaryColor,
                width: 2.w,
              ),
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
          onChanged: (value) => onChange ?? () {},
          keyboardType: keyboardType,
          obscureText: obscureText!,
        ),
      ],
    );
  }
}
