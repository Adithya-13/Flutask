import 'package:flutask/data/entities/entities.dart';
import 'package:flutask/logic/blocs/blocs.dart';
import 'package:flutask/presentation/utils/utils.dart';
import 'package:flutask/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_color/flutter_color.dart';

class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({
    Key? key, this.categoryId,
  }) : super(key: key);

  final int? categoryId;

  @override
  _AddTaskSheetState createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late int? selectedCategory = widget.categoryId ?? null;
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
    if (_formKey.currentState!.validate()) {
      TaskItemEntity taskItemEntity = TaskItemEntity(
        title: titleController.text,
        description: descriptionController.text,
        categoryId: selectedCategory!,
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
          categoryId: selectedCategory!,
          deadline: savedDeadline,
          isCompleted: false,
        );
      }
      context.read<TaskBloc>().add(InsertTask(taskItemEntity: taskItemEntity));
      Helper.showCustomSnackBar(
        context,
        content: 'Success Add Task',
        bgColor: AppTheme.lightPurple.lighter(30),
      );
      Navigator.pop(context);
    }
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
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Center(
                                child:
                                    Text('Add Task', style: AppTheme.headline3),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                style: AppTheme.text1.withDarkPurple,
                                controller: titleController,
                                decoration: InputDecoration(
                                  enabledBorder: AppTheme.enabledBorder,
                                  focusedBorder: AppTheme.focusedBorder,
                                  errorBorder: AppTheme.errorBorder,
                                  focusedErrorBorder:
                                      AppTheme.focusedErrorBorder,
                                  isDense: true,
                                  hintText: 'Type your title here',
                                  hintStyle: AppTheme.text1,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your title task';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                style: AppTheme.text1.withDarkPurple,
                                controller: descriptionController,
                                decoration: InputDecoration(
                                  enabledBorder: AppTheme.enabledBorder,
                                  focusedBorder: AppTheme.focusedBorder,
                                  errorBorder: AppTheme.errorBorder,
                                  focusedErrorBorder:
                                      AppTheme.focusedErrorBorder,
                                  isDense: true,
                                  hintText: 'Type your description here',
                                  hintStyle: AppTheme.text1,
                                ),
                                maxLines: 5,
                                scrollPhysics: BouncingScrollPhysics(),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your description task';
                                  }
                                  return null;
                                },
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
                                        errorBorder: AppTheme.errorBorder,
                                        focusedErrorBorder:
                                            AppTheme.focusedErrorBorder,
                                        isDense: true,
                                        hintText: 'Choose Category',
                                        hintStyle: AppTheme.text1,
                                      ),
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Please fill in category';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          selectedCategory = value;
                                        });
                                      },
                                      items: state.entity.taskCategoryList
                                          .map((e) {
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
          ),
        );
      },
    );
  }
}
