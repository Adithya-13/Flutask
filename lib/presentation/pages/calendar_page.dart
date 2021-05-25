import 'package:flutask/data/entities/entities.dart';
import 'package:flutask/logic/blocs/blocs.dart';
import 'package:flutask/presentation/utils/extensions.dart';
import 'package:flutask/presentation/utils/utils.dart';
import 'package:flutask/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime datePicked = DateTime.now();

  @override
  void initState() {
    _getTaskByDate();
    super.initState();
  }

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
        _getTaskByDate();
      });
    }
  }

  _getTaskByDate(){
    context.read<TaskBloc>().add(WatchTaskByDate(dateTime: datePicked));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                  _getTaskByDate();
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
            _taskByDate(),
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

  _taskByDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<TaskBloc, TaskState>(
        buildWhen: (previous, current) {
          return current is TaskStream;
        },
        builder: (context, state) {
          if (state is TaskStream) {
            final entity = state.entity;
            return StreamBuilder<TaskWithCategoryEntity>(
              stream: entity,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return FailureWidget(message: snapshot.stackTrace.toString());
                } else if (!snapshot.hasData) {
                  return LoadingWidget();
                } else if (snapshot.data!.taskWithCategoryList.isEmpty) {
                  return EmptyWidget();
                }
                return taskListView(snapshot.data!);
              },
            );
          }
          return EmptyWidget();
        },
      ),
    );
  }

  Widget taskListView(TaskWithCategoryEntity data) {
    return ListView.builder(
      itemCount: data.taskWithCategoryList.length,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final item = data.taskWithCategoryList[index];
        return taskItemWidget(
            context, item.taskItemEntity, item.taskCategoryItemEntity);
      },
    );
  }

  Widget taskItemWidget(BuildContext context, TaskItemEntity item,
      TaskCategoryItemEntity category) {
    return GestureDetector(
      onTap: () {
        context.read<TaskCategoryBloc>().add(GetTaskCategory());
        showCupertinoModalBottomSheet(
          expand: false,
          context: context,
          enableDrag: true,
          topRadius: Radius.circular(20),
          backgroundColor: Colors.transparent,
          builder: (context) => UpdateTaskSheet(
              item: TaskWithCategoryItemEntity(
                taskItemEntity: item,
                taskCategoryItemEntity: category,
              )),
        );
      },
      child: Container(
        padding: EdgeInsets.all(24),
        margin: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(item.title, style: AppTheme.headline3),
              SizedBox(height: 16),
              Row(
                children: [
                  SvgPicture.asset(Resources.clock, width: 20),
                  SizedBox(width: 8),
                  Text(
                      item.deadline != null
                          ? item.deadline!.format(FormatDate.deadline)
                          : 'No Deadline',
                      style: AppTheme.text3),
                ],
              ),
              SizedBox(height: 16),
              Wrap(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.perano.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(category.title, style: AppTheme.text3),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: (item.isCompleted
                          ? AppTheme.greenPastel
                          : AppTheme.redPastel)
                          .withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(item.isCompleted ? 'Done' : 'On Going',
                        style: AppTheme.text3),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
