import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutask/logic/blocs/blocs.dart';
import 'package:flutask/presentation/utils/utils.dart';
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
    context.read<TaskBloc>().add(TaskFetched());
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
          Text(
            'My Tasks',
            style: AppTheme.headline2,
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 20),
          BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              if (state is TaskInitial) {
                return Container();
              } else if (state is TaskLoadData) {
                return Container();
              } else if (state is TaskSuccess) {
                final entity = state.entity;
                return StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: entity.tasksList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final taskItem = entity.tasksList[index];
                    return Container(
                      decoration: BoxDecoration(
                        gradient: taskItem.gradient,
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: AppTheme.getShadow(AppTheme.cornflowerBlue),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child: AutoSizeText(
                                  (taskItem.id + 1).toString(),
                                  style: AppTheme.headline2,
                                  minFontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(height: 12),
                            Flexible(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                  },
                  staggeredTileBuilder: (int index) =>
                      StaggeredTile.count(2, index.isEven ? 2.4 : 1.8),
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                );
              } else if (state is TaskFailure) {
                return Container();
              }
              return Container();
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
                child: Text('See all', style: AppTheme.text4,),
              ),
            ],
          ),
          SizedBox(height: 20),
          ListView.builder(
            itemCount: 4,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(24),
                margin: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  child: Column(
                    children: [
                      Text('Startup Website Design with responsive',
                          style: AppTheme.headline3),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          SvgPicture.asset(Resources.clock, width: 20),
                          SizedBox(width: 8),
                          Text('10:00 AM', style: AppTheme.text3),
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
                          child:
                              Text('Mobile App Design', style: AppTheme.text3),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
