import 'package:flutask/presentation/utils/extensions.dart';
import 'package:flutask/presentation/utils/utils.dart';
import 'package:flutask/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime datePicked = DateTime.now();

  _showDeadlineDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: datePicked,
      firstDate: DateTime(2019),
      lastDate: DateTime(2025),
      helpText: 'Select Date',
      confirmText: 'Select',
      cancelText: 'Cancel',
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
    if (picked != null && picked != datePicked) {
      setState(() {
        datePicked = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _topBar(),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          datePicked.format(FormatDate.monthYear),
                          style: AppTheme.headline2,
                        ),
                        SizedBox(height: 8),
                        Text(
                          '10 Tasks on ${datePicked.format(FormatDate.dayDate)}',
                          style: AppTheme.text1,
                        ),
                      ],
                    ),
                  ),
                  RippleCircleButton(
                    onTap: () => _showDeadlineDatePicker(),
                    child: SvgPicture.asset(Resources.date,
                        color: Colors.white, width: 20),
                  ),
                ],
              ),
            ),
            CalendarTimeline(
              initialDate: datePicked,
              firstDate: DateTime(2019, 1, 15),
              lastDate: DateTime(2025, 11, 20),
              onDateSelected: (date) {
                setState(() {
                  datePicked = date!;
                });
              },
              leftMargin: 20,
              monthColor: Colors.blueGrey,
              dayColor: Colors.teal[200],
              activeDayColor: Colors.white,
              activeBackgroundDayColor: Colors.redAccent[100],
              dotsColor: Color(0xFF333A47),
              locale: 'en_US',
            ),
          ],
        ),
      ),
    );
  }

  _topBar() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        'Calendar Tasks',
        style: AppTheme.headline3,
        textAlign: TextAlign.center,
      ),
    );
  }
}
