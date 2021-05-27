import 'package:flutask/data/entities/entities.dart';
import 'package:flutask/logic/blocs/blocs.dart';
import 'package:flutask/presentation/utils/utils.dart';
import 'package:flutask/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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

  static showBottomSheet(
    BuildContext context, {
    TaskWithCategoryItemEntity? task,
    int? categoryId,
    bool isUpdate = false,
  }) {
    context.read<TaskCategoryBloc>().add(GetTaskCategory());
    showCupertinoModalBottomSheet(
      expand: false,
      context: context,
      enableDrag: true,
      topRadius: Radius.circular(20),
      backgroundColor: Colors.transparent,
      builder: (context) => TaskSheet(
        task: task,
        categoryId: categoryId,
        isUpdate: isUpdate,
      ),
    );
  }
}
