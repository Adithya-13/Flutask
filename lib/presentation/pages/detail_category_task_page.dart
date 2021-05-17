import 'package:flutask/data/entities/entities.dart';
import 'package:flutask/logic/blocs/blocs.dart';
import 'package:flutask/presentation/routes/routes.dart';
import 'package:flutask/presentation/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutask/presentation/widgets/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
  late int totalTasks = widget.bundle.extras[Keys.totalTasks];
  late int index = widget.bundle.extras[Keys.index];

  @override
  void initState() {
    context.read<TaskBloc>().add(WatchTaskByCategory(id: categoryItem.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: categoryItem.gradient.colors[0],
        title: Hero(
          tag: Keys.heroTitleCategory + index.toString(),
          child: Text(
            categoryItem.title,
            style: AppTheme.headline2.withWhite,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            _onGoing(),
          ],
        ),
      ),
    );
  }
  _onGoing() {
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
