import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final Widget? suffixIcon, prefixIconWidget;
  final bool obscureText;
  final Color? filledColor;
  final String? Function(String?)? validator;
  final void Function(String)? onChange, onFieldSubmitted;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.controller,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
    this.prefixIconWidget,
    this.filledColor,
    this.onChange,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange != null ? (value) => onChange!(value) : null,
      onFieldSubmitted:
          onFieldSubmitted != null ? (value) => onFieldSubmitted!(value) : null,
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.lightTextColor),
        filled: true,
        fillColor: filledColor,
        prefixIcon: prefixIconWidget,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: AppColors.yellowColor,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }
}
