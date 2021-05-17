import 'package:flutask/presentation/utils/utils.dart';
import 'package:flutter/material.dart';

class Helper {
  static showCustomSnackBar(BuildContext context,
      {required String content, required Color bgColor}) {
    final snackBar = SnackBar(
      content: Text(
        content,
        style: AppTheme.text1.withDarkPurple,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: bgColor.withOpacity(0.7),
      elevation: 0,
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
