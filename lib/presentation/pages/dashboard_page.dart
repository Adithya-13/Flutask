import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutask/data/entities/entities.dart';
import 'package:flutask/logic/blocs/blocs.dart';
import 'package:flutask/presentation/utils/utils.dart';
import 'package:flutask/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    context.read<TaskCategoryBloc>().add(WatchTaskCategory());
    // context.read<TaskCategoryBloc>().add(InsertTaskCategory(
    //       taskCategoryItemEntity: TaskCategoryItemEntity(
    //           id: 0,
    //           title: "Mobile App Design",
    //           totalTask: 10,
    //           startColor: AppTheme.pinkGradient.colors[0].value,
    //           endColor: AppTheme.pinkGradient.colors[1].value),
    //     ));
    // context.read<TaskCategoryBloc>().add(InsertTaskCategory(
    //       taskCategoryItemEntity: TaskCategoryItemEntity(
    //           id: 1,
    //           title: "Pending",
    //           totalTask: 26,
    //           startColor: AppTheme.orangeGradient.colors[0].value,
    //           endColor: AppTheme.orangeGradient.colors[1].value),
    //     ));
    // context.read<TaskCategoryBloc>().add(InsertTaskCategory(
    //       taskCategoryItemEntity: TaskCategoryItemEntity(
    //           id: 2,
    //           title: "Illustration",
    //           totalTask: 6,
    //           startColor: AppTheme.blueGradient.colors[0].value,
    //           endColor: AppTheme.blueGradient.colors[1].value),
    //     ));
    // context.read<TaskCategoryBloc>().add(InsertTaskCategory(
    //       taskCategoryItemEntity: TaskCategoryItemEntity(
    //           id: 3,
    //           title: "Website Design",
    //           totalTask: 10,
    //           startColor: AppTheme.purpleGradient.colors[0].value,
    //           endColor: AppTheme.purpleGradient.colors[1].value),
    //     ));
    context.read<TaskBloc>().add(WatchTask());
    // context.read<TaskBloc>().add(InsertTask(
    //     taskItemEntity: TaskItemEntity(
    //         categoryId: 0,
    //         title: 'Mobile App Design',
    //         description: 'Blabla',
    //         deadline: DateTime.now())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                _topBar(),
                _myTasks(),
                _onGoing(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _topBar() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateTime.now().format(FormatDate.monthDayYear),
            style: AppTheme.text1,
          ),
          CircleAvatar(
            backgroundImage: AssetImage(Resources.avatarImage),
            radius: 25,
            onBackgroundImageError: (exception, stackTrace) =>
                Icon(Icons.error),
          ),
        ],
      ),
    );
  }

  _myTasks() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Tasks',
                style: AppTheme.headline2,
                textAlign: TextAlign.start,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See all',
                  style: AppTheme.text2.withPink,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          BlocBuilder<TaskCategoryBloc, TaskCategoryState>(
            builder: (context, state) {
              if (state is TaskCategoryInitial) {
                return Container();
              } else if (state is TaskCategoryLoading) {
                return LoadingWidget();
              } else if (state is TaskCategoryStream) {
                final entity = state.entity;
                return StreamBuilder<TaskCategoryEntity>(
                    stream: entity,
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        final data = snapshot.data!;
                        if (data.taskCategoryList.isEmpty) {
                          return EmptyWidget();
                        }
                        return taskCategoryGridView(data);
                      }
                      return EmptyWidget();
                    });
              } else if (state is TaskCategoryFailure) {
                return FailureWidget(message: state.message);
              }
              return EmptyWidget();
            },
          )
        ],
      ),
    );
  }

  _onGoing() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'On Going',
                style: AppTheme.headline2,
                textAlign: TextAlign.start,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See all',
                  style: AppTheme.text2.withPink,
                ),
              ),
            ],
          ),
          BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              if (state is TaskInitial) {
                return LoadingWidget();
              } else if (state is TaskLoading) {
                return LoadingWidget();
              } else if (state is TaskStream) {
                final entity = state.entity;
                return StreamBuilder<TaskEntity>(
                    stream: entity,
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        final data = snapshot.data!;
                        if (data.tasksList.isEmpty) {
                          return EmptyWidget();
                        }
                        return taskListView(data);
                      }
                      return EmptyWidget();
                    });
              } else if (state is TaskFailure) {
                return FailureWidget(message: state.message);
              }
              return EmptyWidget();
            },
          ),
        ],
      ),
    );
  }

  Widget taskCategoryGridView(TaskCategoryEntity data) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: data.taskCategoryList.length,
      itemBuilder: (BuildContext context, int index) {
        final taskItem = data.taskCategoryList[index];
        return taskCategoryItemWidget(taskItem, index);
      },
      staggeredTileBuilder: (int index) =>
          StaggeredTile.count(2, index.isEven ? 2.4 : 1.8),
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
    );
  }

  Widget taskCategoryItemWidget(TaskCategoryItemEntity taskItem, int index) {
    return Container(
      decoration: BoxDecoration(
        gradient: taskItem.gradient.withDiagonalGradient,
        borderRadius: BorderRadius.circular(32),
        boxShadow: AppTheme.getShadow(AppTheme.cornflowerBlue),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white,
                child: AutoSizeText(
                  (index + 1).toString(),
                  style: AppTheme.headline2,
                  minFontSize: 14,
                ),
              ),
            ),
            SizedBox(height: 12),
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      taskItem.title,
                      style: AppTheme.headline3.withWhite,
                      maxLines: index.isEven ? 3 : 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(Icons.arrow_right, color: Colors.white),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              '${taskItem.totalTask} Task',
              style: AppTheme.text2,
            ),
          ],
        ),
      ).addRipple(onTap: () {}),
    );
  }

  Widget taskListView(TaskEntity data) {
    return ListView.builder(
      itemCount: data.tasksList.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = data.tasksList[index];
        return taskItemWidget(context, item);
      },
    );
  }

  Widget taskItemWidget(BuildContext context, TaskItemEntity item) {
    return GestureDetector(
      onLongPress: () {
        context.read<TaskBloc>().add(DeleteTask(id: item.id!));
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
                  Text(item.deadline.format('hh:mm aa'), style: AppTheme.text3),
                ],
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.perano.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('Mobile App Design', style: AppTheme.text3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
