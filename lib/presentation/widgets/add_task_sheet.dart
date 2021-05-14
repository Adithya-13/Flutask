
import 'package:flutask/logic/blocs/blocs.dart';
import 'package:flutask/presentation/utils/utils.dart';
import 'package:flutask/presentation/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutask/data/entities/entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({
    Key? key,
  }) : super(key: key);

  @override
  _AddTaskSheetState createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  int? selectedCategory;
  DateTime? datePicked;
  TimeOfDay? timePicked;

  @override
  void initState() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  _showDeadlineDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: datePicked ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
      helpText: 'Select Deadline Date',
      confirmText: 'Select',
      cancelText: 'No Deadline',
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
      });
    }
  }

  _showDeadlineTimePicker() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: timePicked ?? TimeOfDay.now(),
      helpText: 'Select Deadline Time',
      confirmText: 'Select',
      cancelText: 'No Deadline',
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
    if (picked != null && picked != timePicked) {
      setState(() {
        timePicked = picked;
      });
    }
  }

  _saveTask() {
    TaskItemEntity taskItemEntity = TaskItemEntity(
      title: titleController.text,
      description: descriptionController.text,
      categoryId: selectedCategory ?? 0,
    );
    if (datePicked != null && timePicked != null) {
      final DateTime savedDeadline = DateTime(
        datePicked!.year,
        datePicked!.month,
        datePicked!.day,
        timePicked!.hour,
        timePicked!.minute,
      );
      taskItemEntity = TaskItemEntity(
        title: titleController.text,
        description: descriptionController.text,
        categoryId: selectedCategory ?? 0,
        deadline: savedDeadline,
      );
    }
    context.read<TaskBloc>().add(InsertTask(taskItemEntity: taskItemEntity));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCategoryBloc, TaskCategoryState>(
      builder: (context, state) {
        return Material(
          child: SafeArea(
            top: false,
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                padding: EdgeInsets.all(20),
                child: state is TaskCategoryLoading
                    ? LoadingWidget()
                    : SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Center(
                        child:
                        Text('Add Task', style: AppTheme.headline3),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        style: AppTheme.text1.withDarkPurple,
                        controller: titleController,
                        decoration: InputDecoration(
                          enabledBorder: AppTheme.enabledBorder,
                          focusedBorder: AppTheme.focusedBorder,
                          isDense: true,
                          hintText: 'Type your title here',
                          hintStyle: AppTheme.text1,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        style: AppTheme.text1.withDarkPurple,
                        controller: descriptionController,
                        decoration: InputDecoration(
                          enabledBorder: AppTheme.enabledBorder,
                          focusedBorder: AppTheme.focusedBorder,
                          isDense: true,
                          hintText: 'Type your description here',
                          hintStyle: AppTheme.text1,
                        ),
                        maxLines: 5,
                        scrollPhysics: BouncingScrollPhysics(),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: RippleButton(
                              onTap: _showDeadlineDatePicker,
                              text: datePicked != null
                                  ? datePicked!
                                  .format(FormatDate.monthDayYear)
                                  : 'Date',
                              icon: SvgPicture.asset(Resources.date,
                                  color: Colors.white, width: 16),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: RippleButton(
                              onTap: _showDeadlineTimePicker,
                              text: timePicked != null
                                  ? timePicked!.format(context)
                                  : 'Time',
                              icon: SvgPicture.asset(Resources.clock,
                                  color: Colors.white, width: 16),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      state is TaskCategorySuccess
                          ? DropdownButtonFormField<int>(
                        decoration: InputDecoration(
                          enabledBorder: AppTheme.enabledBorder,
                          focusedBorder: AppTheme.focusedBorder,
                          isDense: true,
                          hintText: 'Choose Category',
                          hintStyle: AppTheme.text1,
                        ),
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value;
                          });
                        },
                        items:
                        state.entity.taskCategoryList.map((e) {
                          return DropdownMenuItem(
                            value: e.id,
                            child: Text(e.title),
                          );
                        }).toList(),
                        style: AppTheme.text1.withDarkPurple,
                        value: selectedCategory,
                      )
                          : Container(),
                      SizedBox(height: 20),
                      PinkButton(
                        text: 'Save Task',
                        onTap: _saveTask,
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
