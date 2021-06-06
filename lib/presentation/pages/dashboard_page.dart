import 'package:auto_animated/auto_animated.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutask/data/entities/entities.dart';
import 'package:flutask/logic/blocs/blocs.dart';
import 'package:flutask/presentation/routes/routes.dart';
import 'package:flutask/presentation/utils/utils.dart';
import 'package:flutask/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get_storage/get_storage.dart';

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
              gradient: AppTheme.orangeGradient,
            ),
          ));
      context.read<TaskCategoryBloc>().add(InsertTaskCategory(
            taskCategoryItemEntity: TaskCategoryItemEntity(
              title: "Work",
              gradient: AppTheme.toscaGradient,
            ),
          ));
      context.read<TaskCategoryBloc>().add(InsertTaskCategory(
            taskCategoryItemEntity: TaskCategoryItemEntity(
              title: "Health",
              gradient: AppTheme.purpleGradient,
            ),
          ));
      context.read<TaskCategoryBloc>().add(InsertTaskCategory(
            taskCategoryItemEntity: TaskCategoryItemEntity(
              title: "Other",
              gradient: AppTheme.donkerGradient,
            ),
          ));
      getStorage.write(Keys.isInitial, false);
    }
  }

  _goToOnGoingPage() {
    Navigator.pushNamed(
      context,
      PagePath.onGoingComplete,
      arguments: ArgumentBundle(extras: {
        Keys.statusType: StatusType.ON_GOING,
      }, identifier: 'on going detail'),
    );
  }

  _goToCompletePage() {
    Navigator.pushNamed(
      context,
      PagePath.onGoingComplete,
      arguments: ArgumentBundle(extras: {
        Keys.statusType: StatusType.COMPLETE,
      }, identifier: 'complete detail'),
    );
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
          SizedBox(width: 20),
          Expanded(
            child: Hero(
              tag: Keys.heroSearch,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppTheme.cornflowerBlue),
                ),
                padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Search Tasks here',
                        style: AppTheme.text3,
                      ),
                    ),
                    Icon(
                      Icons.search_rounded,
                      color: AppTheme.cornflowerBlue,
                    ),
                  ],
                ),
              ).addRipple(onTap: () => Navigator.pushNamed(context, PagePath.search),),
            ),
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
                  style: AppTheme.text1.withPink,
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
              Hero(
                tag: Keys.heroStatus + StatusType.ON_GOING.toString(),
                child: Text(
                  'On Going',
                  style: AppTheme.headline2,
                  textAlign: TextAlign.start,
                ),
              ),
              TextButton(
                onPressed: _goToOnGoingPage,
                child: Text(
                  'See all',
                  style: AppTheme.text1.withPink,
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
              Hero(
                tag: Keys.heroStatus + StatusType.COMPLETE.toString(),
                child: Text(
                  'Complete',
                  style: AppTheme.headline2,
                  textAlign: TextAlign.start,
                ),
              ),
              TextButton(
                onPressed: _goToCompletePage,
                child: Text(
                  'See all',
                  style: AppTheme.text1.withPink,
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
            taskItem.taskCategoryItemEntity, taskItem.totalTasks, index);
      },
      staggeredTileBuilder: (int index) =>
          StaggeredTile.count(2, index.isEven ? 2.4 : 1.8),
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
    );
  }

  Widget taskCategoryItemWidget(
      TaskCategoryItemEntity categoryItem, int totalTasks, int index) {
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
              style: AppTheme.text1.withWhite,
            ),
          ],
        ),
      ).addRipple(onTap: () {
        Navigator.pushNamed(
          context,
          PagePath.detailCategory,
          arguments: ArgumentBundle(extras: {
            Keys.categoryItem: categoryItem,
            Keys.index: index,
          }, identifier: 'detail Category'),
        );
      }),
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
          category: item.taskCategoryItemEntity, animation: animation,
        );
      },
    );
  }
}
