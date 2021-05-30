import 'package:auto_animated/auto_animated.dart';
import 'package:flutask/data/entities/entities.dart';
import 'package:flutask/logic/blocs/blocs.dart';
import 'package:flutask/presentation/routes/routes.dart';
import 'package:flutask/presentation/utils/utils.dart';
import 'package:flutask/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DetailCategoryTaskPage extends StatefulWidget {
  final ArgumentBundle bundle;

  const DetailCategoryTaskPage({Key? key, required this.bundle})
      : super(key: key);

  @override
  _DetailCategoryTaskPageState createState() => _DetailCategoryTaskPageState();
}

class _DetailCategoryTaskPageState extends State<DetailCategoryTaskPage> {
  late TaskCategoryItemEntity categoryItem =
      widget.bundle.extras[Keys.categoryItem];
  final ValueNotifier<int> totalTasks = ValueNotifier(0);
  final ValueNotifier<int> completeTasks = ValueNotifier(0);
  late int index = widget.bundle.extras[Keys.index];

  @override
  void initState() {
    context.read<TaskBloc>().add(WatchTaskByCategory(id: categoryItem.id!));
    super.initState();
  }

  double percent(int totalTasks, int completeTasks) {
    try {
      final percentValue = completeTasks / totalTasks;
      if (percentValue.isNaN || percentValue.isInfinite) {
        return 0.0;
      }
      return percentValue;
    } catch (_) {
      return 0.0;
    }
  }

  void setCompleteAndTotalValue(
      AsyncSnapshot<TaskWithCategoryEntity> snapshot) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if(snapshot.hasData) {
        completeTasks.value = 0;
        totalTasks.value = 0;
        for (TaskWithCategoryItemEntity item
        in snapshot.data!.taskWithCategoryList) {
          if (item.taskCategoryItemEntity.id == categoryItem.id) {
            if (item.taskItemEntity.isCompleted == true) {
              completeTasks.value++;
            }
            totalTasks.value++;
          }
        }
      }
    });
  }

  @override
  void dispose() {
    completeTasks.value = 0;
    totalTasks.value = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          WideAppBar(
            tag: index.toString(),
            title: categoryItem.title,
            gradient: categoryItem.gradient,
            actions: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => Helper.showBottomSheet(
                  context,
                  categoryId: categoryItem.id!,
                ),
              ),
            ],
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                SizedBox(
                  height: 56,
                ),
                ValueListenableBuilder2<int, int>(
                  totalTasks,
                  completeTasks,
                  builder: (context, totalTasks, completeTasks, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Your Tasks',
                              style: AppTheme.headline2.withWhite,
                            ),
                            Text(
                              'Completed Tasks $completeTasks / $totalTasks',
                              style: AppTheme.text3.withWhite,
                            ),
                          ],
                        ),
                        CircularPercentIndicator(
                          radius: 120.0,
                          lineWidth: 13.0,
                          animation: true,
                          percent: percent(totalTasks, completeTasks),
                          center: Text(
                            "${(percent(totalTasks, completeTasks) * 100).toInt()}%",
                            style: AppTheme.headline3.withBlack,
                          ),
                          curve: Curves.easeOutExpo,
                          animationDuration: 3000,
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: AppTheme.boldColorFont,
                          backgroundColor: Colors.white,
                        ),
                      ],
                    );
                  }
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _taskList(),
            ]),
          ),
        ],
      ),
    );
  }

  _taskList() {
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
                setCompleteAndTotalValue(snapshot);
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
      physics: NeverScrollableScrollPhysics(),
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
