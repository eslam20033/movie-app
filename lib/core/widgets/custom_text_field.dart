import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.controller,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.lightTextColor),
        filled: true,
        fillColor: AppColors.textFieldColor,
        prefixIcon: Icon(prefixIcon, color: AppColors.lightTextColor),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: AppColors.yellowColor, width: 1.5),
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
