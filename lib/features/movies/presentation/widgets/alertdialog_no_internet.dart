import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class AlertDialogInternetConnection extends StatelessWidget {
  final String text;
  final Function() onTap;

  const AlertDialogInternetConnection({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.yellowColor,
      title: Text(
        text,
        style: TextStyle(
          color: Colors.red,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        'Check your internet connection Or server "yts.mx’s" DNS address could not be found and try again.',
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              onTap();
            },
            child: Text(
              'Retry',
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ),
      ],
      scrollable: true,
    );
  }
}
