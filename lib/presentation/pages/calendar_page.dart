import 'package:auto_animated/auto_animated.dart';
import 'package:flutask/data/entities/entities.dart';
import 'package:flutask/logic/blocs/blocs.dart';
import 'package:flutask/presentation/utils/extensions.dart';
import 'package:flutask/presentation/utils/utils.dart';
import 'package:flutask/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime datePicked = DateTime.now();
  final ValueNotifier<int> totalTask = ValueNotifier(0);

  @override
  void initState() {
    _getTaskByDate();
    super.initState();
  }

  _getTaskByDate() {
    context
        .read<TaskBloc>()
        .add(WatchTaskByDate(dateTime: datePicked.toLocal()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
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
                          ValueListenableBuilder<int>(
                            valueListenable: totalTask,
                            builder: (context, value, child) => Text(
                              '$value Tasks on ${datePicked.format(FormatDate.dayDate)}',
                              style: AppTheme.text1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    RippleCircleButton(
                      onTap: () async {
                        final picked = await Helper.showDeadlineDatePicker(
                          context,
                          datePicked,
                        );
                        if (picked != null && picked != datePicked) {
                          setState(() {
                            datePicked = picked;
                            _getTaskByDate();
                          });
                        }
                      },
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
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  if(snapshot.hasData){
                    totalTask.value = snapshot.data!.taskWithCategoryList.length;
                  }
                });
                if (snapshot.hasError) {
                  return FailureWidget(message: snapshot.stackTrace.toString());
                } else if (!snapshot.hasData) {
                  return LoadingWidget();
                } else if (snapshot.data!.taskWithCategoryList.isEmpty) {
                  return EmptyWidget();
                } else {
                  return taskListView(snapshot.data!);
                }
              },
            );
          }
          return EmptyWidget();
        },
      ),
    );
  }

  Widget taskListView(TaskWithCategoryEntity data) {
    return LiveList.options(
      options: Helper.options,
      itemCount: data.taskWithCategoryList.length,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index, animation) {
        final item = data.taskWithCategoryList[index];
        return TaskItemWidget(
          task: item.taskItemEntity,
          category: item.taskCategoryItemEntity,
          animation: animation,
        );
      },
    );
  }
}
