import 'package:flutask/presentation/utils/utils.dart';
import 'package:flutter/material.dart';

class Helper {
  static showCustomSnackBar(BuildContext context,
      {required String content,
      required bool isHasAction,
      VoidCallback? onPressed}) {
    final snackBar = SnackBar(
      content: Text(
        content,
        style: AppTheme.text1,
      ),
      action:
          isHasAction ? SnackBarAction(label: '', onPressed: onPressed!) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
