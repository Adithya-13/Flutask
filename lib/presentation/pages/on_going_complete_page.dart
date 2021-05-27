import 'package:flutask/data/entities/entities.dart';
import 'package:flutask/logic/blocs/blocs.dart';
import 'package:flutask/presentation/routes/routes.dart';
import 'package:flutask/presentation/utils/utils.dart';
import 'package:flutask/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class OnGoingCompletePage extends StatefulWidget {
  final ArgumentBundle bundle;

  const OnGoingCompletePage({Key? key, required this.bundle})
      : super(key: key);

  @override
  _OnGoingCompletePageState createState() => _OnGoingCompletePageState();
}

class _OnGoingCompletePageState extends State<OnGoingCompletePage> {

  late StatusType statusType = widget.bundle.extras[Keys.statusType];
  late String title = statusType == StatusType.ON_GOING ? 'On Going' : 'Complete';
  LinearGradient randomGradient = LinearGradient(colors: []).randomGradientColor;

  @override
  void initState() {
    context.read<TaskBloc>().add(WatchTaskByStatus(statusType: statusType));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            title: Hero(
              tag: Keys.heroTitleCategory + statusType.toString(),
              child: Text(
                title,
                style: AppTheme.headline2.withWhite,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => Helper.showBottomSheet(context),
              ),
            ],
            backgroundColor: randomGradient.colors[0]
                .mix(randomGradient.colors[1], 0.5),
            stretch: true,
            shadowColor: AppTheme.getShadow(randomGradient.colors[1])[0].color,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: randomGradient.withDiagonalGradient,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(20)),
                ),
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
                    Column(
                      children: [
                        Text(
                          'Your $title Tasks',
                          style: AppTheme.headline1.withWhite,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Total Tasks 0',
                          style: AppTheme.text2.withWhite,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
          builder: (context) => TaskSheet(
            isUpdate: true,
              task: TaskWithCategoryItemEntity(
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
