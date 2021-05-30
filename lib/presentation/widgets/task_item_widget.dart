import 'package:flutask/data/entities/entities.dart';
import 'package:flutask/logic/blocs/blocs.dart';
import 'package:flutask/presentation/utils/utils.dart';
import 'package:flutask/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskItemEntity task;
  final TaskCategoryItemEntity category;
  final Animation<double> animation;

  const TaskItemWidget({
    Key? key,
    required this.task,
    required this.category, required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animation),
      child: GestureDetector(
        onTap: () {
          context.read<TaskCategoryBloc>().add(GetTaskCategory());
          showCupertinoModalBottomSheet(
            expand: false,
            context: context,
            enableDrag: true,
            topRadius: Radius.circular(20),
            backgroundColor: Colors.transparent,
            builder: (context) =>
                TaskSheet(
                    isUpdate: true,
                    task: TaskWithCategoryItemEntity(
                      taskItemEntity: task,
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
                Text(task.title, style: AppTheme.headline3),
                SizedBox(height: 16),
                Row(
                  children: [
                    SvgPicture.asset(Resources.clock, width: 20),
                    SizedBox(width: 8),
                    Text(
                        task.deadline != null
                            ? task.deadline!.format(FormatDate.deadline)
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
                        color: (task.isCompleted
                            ? AppTheme.greenPastel
                            : AppTheme.redPastel)
                            .withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(task.isCompleted ? 'Done' : 'On Going',
                          style: AppTheme.text3),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}