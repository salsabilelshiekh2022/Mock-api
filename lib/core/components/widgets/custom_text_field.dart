import 'package:mock_api/core/helper/app_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../generated/app_assets.dart';
import '../../theme/app_colors.dart';
import 'custom_svg_builder.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.focusNode,
    this.isObscured,
    this.keyboardType,
    this.validator,
    this.controller,
    this.inputFormatters,
    this.enabled,
    this.onTap,
    this.maxLines = 1,
    this.isReadOnly,
    this.suffixWidget,
    this.suffixIcon,
    this.prefixWidget,
    this.textAlign,
    this.initialValue,
    this.color,
  });

  final String hintText;

  final FocusNode? focusNode;
  final bool? isObscured;
  final TextInputType? keyboardType;
  final Function(String?)? validator;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final bool? isReadOnly;
  final void Function()? onTap;
  final int maxLines;
  final Widget? suffixWidget;
  final String? prefixWidget;
  final String? initialValue;
  final bool? suffixIcon;
  final TextAlign? textAlign;
  final Color? color;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _showPassword = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      textAlign: widget.textAlign ?? TextAlign.start,
      maxLines: widget.maxLines,
      enabled: widget.enabled,
      readOnly: widget.isReadOnly ?? false,
      inputFormatters: widget.inputFormatters,
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: _showPassword,
      keyboardType: widget.keyboardType,
      cursorColor: widget.color ?? context.colors.whiteColor,
      cursorErrorColor: context.colors.redColor,
      style: context.textStyles.font16MediumSecondaryColor.copyWith(
        color: widget.color ?? context.colors.whiteColor,
      ),
      validator: (value) {
        if (widget.validator != null) {
          return widget.validator!(value);
        }
        return null;
      },
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        filled: true,
        hintText: widget.hintText,
        hintStyle: context.textStyles.font14MediumGrayColor.copyWith(
          color: widget.color ?? context.colors.whiteColor,
        ),

        prefixIcon: widget.prefixWidget == null
            ? null
            : CustomSvgBuilder(
                path: widget.prefixWidget!,
                width: 20,
                height: 20,
                fit: BoxFit.scaleDown,
              ),
        suffixIcon: widget.suffixIcon == true && widget.suffixWidget == null
            ? IconButton(
                padding: const EdgeInsets.all(0),
                icon: _showPassword
                    ? CustomSvgBuilder(
                        path: AppAssets.svgsEyeIcon,
                        width: 20,
                        height: 20,
                        color: widget.color ?? Colors.white,
                        fit: BoxFit.scaleDown,
                      )
                    : CustomSvgBuilder(
                        path: AppAssets.svgsEyeClosedIcon,
                        width: 20,
                        height: 20,
                        color: widget.color ?? Colors.white,
                        fit: BoxFit.scaleDown,
                      ),
                onPressed: () => setState(() => _showPassword = !_showPassword),
              )
            : widget.suffixWidget,
        enabledBorder: _defaultBorder(context.colors),
        disabledBorder: _defaultBorder(context.colors),
        focusedBorder: _focusedBorder(context.colors),
        errorBorder: _errorBorder(context.colors),
        focusedErrorBorder: _focusedBorder(context.colors),
      ),

      textAlignVertical: TextAlignVertical.center,
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      onTap: widget.onTap,
    );
  }

  OutlineInputBorder _defaultBorder(AppColors appColors) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0.r),
    borderSide: BorderSide(
      color: widget.color != null
          ? widget.color!.withValues(alpha: 0.5)
          : appColors.whiteColor.withValues(alpha: 0.6),
      width: 1,
    ),
  );

  OutlineInputBorder _focusedBorder(AppColors appColors) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0.r),
    borderSide: BorderSide(
      color: widget.color ?? appColors.whiteColor,
      width: 1,
    ),
  );

  OutlineInputBorder _errorBorder(AppColors appColors) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(14.0.r),
    borderSide: BorderSide(color: appColors.redColor, width: 1),
  );
}
