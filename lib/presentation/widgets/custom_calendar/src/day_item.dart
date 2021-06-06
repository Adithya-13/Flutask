import 'package:flutask/presentation/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutask/presentation/utils/extensions.dart';

/// Creates a Widget representing the day.
class DayItem extends StatelessWidget {
  final int dayNumber;
  final String shortName;
  final bool isSelected;
  final Function onTap;
  final Color? dayColor;
  final Color? activeDayColor;
  final Color? activeDayBackgroundColor;
  final LinearGradient dayColorGradient;
  final bool available;
  final Color? dotsColor;
  final Color? dayNameColor;

  const DayItem({
    Key? key,
    required this.dayNumber,
    required this.shortName,
    required this.onTap,
    this.isSelected = false,
    this.dayColor,
    this.activeDayColor,
    this.activeDayBackgroundColor,
    this.available = true,
    this.dayColorGradient = AppTheme.orangeGradient,
    this.dotsColor,
    this.dayNameColor,
  }) : super(key: key);

  final double height = 124;
  final double width = 72;

  ///? I united both widgets to increase the touch target of non selected days by using a transparent box decorator.
  ///? Now if the user click close to the number but not straight on top it will still select the date. (ONLY INFORMATION - ERASE)
  _buildDay(BuildContext context) {
    final dateStyle = AppTheme.headline1;
    final selectedDateStyle = AppTheme.headline1.withWhite;

    final dayStyle = AppTheme.text3.bold.withBlack;
    final selectedDayStyle = AppTheme.text3.withWhite.bold;

    return GestureDetector(
      onTap: available ? onTap as void Function()? : null,
      child: Container(
        decoration: isSelected
            ? BoxDecoration(
                gradient: dayColorGradient.withDiagonalGradient,
                borderRadius: BorderRadius.circular(40),
                boxShadow:
                    AppTheme.getShadow(dayColorGradient.colors[1]),
              )
            : BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
        height: height,
        width: width,
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              dayNumber.toString(),
              style: isSelected ? selectedDateStyle : dateStyle,
            ),
            SizedBox(height: 8),
            Text(
              shortName,
              style: isSelected ? selectedDayStyle : dayStyle,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildDay(context);
  }
}
