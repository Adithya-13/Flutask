import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutask/data/entities/entities.dart';
import 'package:flutask/logic/blocs/blocs.dart';
import 'package:flutask/presentation/routes/routes.dart';
import 'package:flutask/presentation/utils/utils.dart';
import 'package:flutask/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    setInitialCategory();
    context.read<TaskCategoryBloc>().add(WatchTaskCategory());
    context.read<TaskBloc>().add(WatchOnGoingTask());
    context.read<TaskBloc>().add(WatchCompletedTask());
    super.initState();
  }

  void setInitialCategory() {
    GetStorage getStorage = GetStorage();
    bool isInitial = getStorage.read(Keys.isInitial) ?? true;
    if (isInitial) {
      context.read<TaskCategoryBloc>().add(InsertTaskCategory(
            taskCategoryItemEntity: TaskCategoryItemEntity(
              title: "School",
              gradient: AppTheme.gradient.randomGradientColor,
            ),
          ));
      context.read<TaskCategoryBloc>().add(InsertTaskCategory(
            taskCategoryItemEntity: TaskCategoryItemEntity(
              title: "Other",
              gradient: AppTheme.gradient.randomGradientColor,
            ),
          ));
      getStorage.write(Keys.isInitial, false);
    }
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
                _complete(),
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
            buildWhen: (previous, current) {
              return current is TaskCategoryStream;
            },
            builder: (context, state) {
              if (state is TaskCategoryStream) {
                final entity = state.entity;
                return StreamBuilder<CategoryTotalTaskEntity>(
                  stream: entity,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return FailureWidget(
                          message: snapshot.stackTrace.toString());
                    } else if (!snapshot.hasData) {
                      return LoadingWidget();
                    } else if (snapshot.data!.categoryTotalTaskList.isEmpty) {
                      return EmptyWidget();
                    }
                    return taskCategoryGridView(snapshot.data!);
                  },
                );
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
            buildWhen: (previous, current) {
              return current is OnGoingTaskStream;
            },
            builder: (context, state) {
              if (state is OnGoingTaskStream) {
                final entity = state.entity;
                return StreamBuilder<TaskWithCategoryEntity>(
                  stream: entity,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return FailureWidget(
                          message: snapshot.stackTrace.toString());
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
        ],
      ),
    );
  }

  _complete() {
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
                'Complete',
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
            buildWhen: (previous, current) {
              return current is CompletedTaskStream;
            },
            builder: (context, state) {
              if (state is CompletedTaskStream) {
                final entity = state.entity;
                return StreamBuilder<TaskWithCategoryEntity>(
                  stream: entity,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return FailureWidget(
                          message: snapshot.stackTrace.toString());
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
        ],
      ),
    );
  }

  Widget taskCategoryGridView(CategoryTotalTaskEntity data) {
    final dataList = data.categoryTotalTaskList;
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: dataList.length,
      itemBuilder: (BuildContext context, int index) {
        final taskItem = dataList[index];
        return taskCategoryItemWidget(
            taskItem.taskCategoryItemEntity, taskItem.totalTasks, taskItem.completeTasks, index);
      },
      staggeredTileBuilder: (int index) =>
          StaggeredTile.count(2, index.isEven ? 2.4 : 1.8),
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
    );
  }

  Widget taskCategoryItemWidget(
      TaskCategoryItemEntity categoryItem, int totalTasks, int completeTasks, int index) {
    return Container(
      decoration: BoxDecoration(
        gradient: categoryItem.gradient.withDiagonalGradient,
        borderRadius: BorderRadius.circular(32),
        boxShadow: AppTheme.getShadow(categoryItem.gradient.colors[1]),
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
                    child: Hero(
                      tag: Keys.heroTitleCategory + index.toString(),
                      child: Text(
                        categoryItem.title,
                        style: AppTheme.headline3.withWhite,
                        maxLines: index.isEven ? 3 : 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_right, color: Colors.white),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              '$totalTasks Task',
              style: AppTheme.text2,
            ),
          ],
        ),
      ).addRipple(onTap: () {
        Navigator.pushNamed(
          context,
          PagePath.detailCategory,
          arguments: ArgumentBundle(
              extras: {
                Keys.categoryItem: categoryItem,
                Keys.totalTasks: totalTasks,
                Keys.completeTasks: completeTasks,
                Keys.index: index,
              },
              identifier: 'detail Category'),
        );
      }),
    );
  }

  Widget taskListView(TaskWithCategoryEntity data) {
    return ListView.builder(
      itemCount: data.taskWithCategoryList.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
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
