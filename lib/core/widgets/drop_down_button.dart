import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_colors.dart';

class DropDownButton extends StatelessWidget {
  const DropDownButton({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  final List<String> items;
  final String value;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.yellowColor),
      ),
      child: DropdownButton<String>(
        iconDisabledColor: Colors.white,
        iconEnabledColor: Colors.white,
        iconSize: 30,
        elevation: 10,
        isExpanded: true,
        padding: EdgeInsets.only(left: 16),
        dropdownColor: Colors.black,
        value: value,
        underline: SizedBox(),
        items: items
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
