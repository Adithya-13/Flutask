import 'package:flutask/data/entities/entities.dart';
import 'package:flutask/logic/blocs/blocs.dart';
import 'package:flutask/presentation/utils/utils.dart';
import 'package:flutask/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UpdateTaskSheet extends StatefulWidget {
  final TaskWithCategoryItemEntity item;

  const UpdateTaskSheet({Key? key, required this.item}) : super(key: key);

  @override
  _UpdateTaskSheetState createState() => _UpdateTaskSheetState();
}

class _UpdateTaskSheetState extends State<UpdateTaskSheet> {

  late TaskItemEntity taskItem;
  late TaskCategoryItemEntity categoryItem;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int? selectedCategory;
  DateTime? datePicked;
  TimeOfDay? timePicked;
  bool isCompleted = false;

  @override
  void initState() {
    taskItem = widget.item.taskItemEntity;
    categoryItem = widget.item.taskCategoryItemEntity;
    titleController = TextEditingController(text: taskItem.title);
    descriptionController = TextEditingController(text: taskItem.description);
    selectedCategory = categoryItem.id;
    datePicked = taskItem.deadline;
    timePicked = taskItem.deadline != null ? TimeOfDay.fromDateTime(taskItem.deadline!) : null;
    isCompleted = taskItem.isCompleted;
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

  _updateTask() {
    if (_formKey.currentState!.validate()) {
      TaskItemEntity taskItemEntity = TaskItemEntity(
        id: taskItem.id,
        title: titleController.text,
        description: descriptionController.text,
        categoryId: selectedCategory!,
        isCompleted: isCompleted,
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
          id: taskItem.id,
          title: titleController.text,
          description: descriptionController.text,
          categoryId: selectedCategory!,
          deadline: savedDeadline,
          isCompleted: isCompleted,
        );
      }
      context.read<TaskBloc>().add(UpdateTask(taskItemEntity: taskItemEntity));
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    child: SvgPicture.asset(
                                      Resources.trash,
                                      height: 20,
                                      width: 20,
                                    ),
                                    onTap: () {
                                      context.read<TaskBloc>().add(DeleteTask(id: taskItem.id!));
                                      Navigator.pop(context);
                                    },
                                  ),
                                  Text('Update Task', style: AppTheme.headline3),
                                  GestureDetector(
                                    child: SvgPicture.asset(
                                      Resources.complete,
                                      height: 20,
                                      width: 20,
                                    ),
                                    onTap: () {
                                      isCompleted = true;
                                      _updateTask();
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                style: AppTheme.text1.withDarkPurple,
                                controller: titleController,
                                decoration: InputDecoration(
                                  enabledBorder: AppTheme.enabledBorder,
                                  focusedBorder: AppTheme.focusedBorder,
                                  errorBorder: AppTheme.errorBorder,
                                  focusedErrorBorder: AppTheme.focusedErrorBorder,
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
                                  focusedErrorBorder: AppTheme.focusedErrorBorder,
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
                                        focusedErrorBorder: AppTheme.focusedErrorBorder,
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
                                text: 'Update Task',
                                onTap: _updateTask,
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
