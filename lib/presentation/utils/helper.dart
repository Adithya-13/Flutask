import 'dart:io';
import 'package:auto_animated/auto_animated.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:flutask/data/entities/entities.dart';
import 'package:flutask/logic/blocs/blocs.dart';
import 'package:flutask/presentation/utils/utils.dart';
import 'package:flutask/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'utils.dart';

class Helper {
  static showCustomSnackBar(BuildContext context,
      {required String content, required Color bgColor}) {
    final snackBar = SnackBar(
      content: Text(
        content,
        style: AppTheme.text1.withBlack,
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

  static Future<DateTime?> showDeadlineDatePicker(
    BuildContext context,
    DateTime datePicked,
  ) async {
    if(Platform.isIOS){
      DateTime? pickedDate = await showModalBottomSheet<DateTime>(
        context: context,
        builder: (context) {
          DateTime tempPickedDate = DateTime.now();
          return Container(
            height: 250,
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CupertinoButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      CupertinoButton(
                        child: Text('Done'),
                        onPressed: () {
                          Navigator.of(context).pop(tempPickedDate);
                        },
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 0,
                  thickness: 1,
                ),
                Expanded(
                  child: Container(
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: datePicked,
                      onDateTimeChanged: (DateTime dateTime) {
                        tempPickedDate = dateTime;
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
      if (pickedDate != null && pickedDate != datePicked) {
        return pickedDate;
      }
    } else {
      final DateTime? picked = await showCustomDatePicker(
        context: context,
        initialDate: datePicked,
        firstDate: DateTime(2019),
        lastDate: DateTime(2025),
        helpText: 'Select Deadline Date',
        confirmText: 'Select',
        cancelText: 'No Deadline',
        builder: (context, child) {
          return Theme(
            data: ThemeData(fontFamily: 'Gotham').copyWith(
              colorScheme: ColorScheme.light().copyWith(
                primary: AppTheme.cornflowerBlue,
              ),
            ), // This will change to light theme.
            child: child!,
          );
        },
      );
      return picked;
    }
  }

  static void showDeadlineTimePicker(
    BuildContext context,
    TimeOfDay timePicked, {
    required Function(TimeOfDay timeOfDay) onTimeChanged,
  }) async {
    Navigator.of(context).push(
      showPicker(
        context: context,
        value: timePicked,
        onChange: onTimeChanged,
        is24HrFormat: true,
        accentColor: AppTheme.cornflowerBlue,
        unselectedColor: AppTheme.perano,
        iosStylePicker: Platform.isIOS,
        blurredBackground: true,
        borderRadius: 20,
        minuteInterval: MinuteInterval.ONE,
        disableHour: false,
        disableMinute: false,
      ),
    );
  }

  static void unfocus() {
    WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();
  }

  static LiveOptions get options => LiveOptions(
    // Start animation after (default zero)
    delay: Duration(seconds: 0),

    // Show each item through (default 250)
    showItemInterval: Duration(milliseconds: 50),

    // Animation duration (default 250)
    showItemDuration: Duration(milliseconds: 100),

    // Animations starts at 0.05 visible
    // item fraction in sight (default 0.025)
    visibleFraction: 0.05,

    // Repeat the animation of the appearance
    // when scrolling in the opposite direction (default false)
    // To get the effect as in a showcase for ListView, set true
    reAnimateOnVisibility: false,

  );
}
