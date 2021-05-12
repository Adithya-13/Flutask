import 'package:flutask/data/entities/entities.dart';
import 'package:flutask/logic/blocs/blocs.dart';
import 'package:flutask/presentation/pages/pages.dart';
import 'package:flutask/presentation/utils/utils.dart';
import 'package:flutask/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class BasePage extends StatefulWidget {
  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int _currentBody = 0;

  static List<Widget> get bodyList => [
        DashboardPage(),
        BagPage(),
        CalendarPage(),
        ProfilePage(),
      ];

  _onItemTapped(int index) {
    setState(() {
      _currentBody = index;
    });
  }

  Widget get _getPage => bodyList[_currentBody];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage,
      floatingActionButton: Container(
        height: 56,
        width: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppTheme.pinkGradient.withVerticalGradient,
          boxShadow: AppTheme.getShadow(AppTheme.frenchRose),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(56),
          child: Icon(Icons.add, color: Colors.white).addRipple(onTap: () {
            context.read<TaskCategoryBloc>().add(GetTaskCategory());
            showCupertinoModalBottomSheet(
              expand: false,
              context: context,
              enableDrag: true,
              backgroundColor: Colors.transparent,
              builder: (context) => AddTaskSheet(),
            );
          }),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _currentBody,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({
    Key? key,
  }) : super(key: key);

  @override
  _AddTaskSheetState createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      top: false,
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Text('Add Task', style: AppTheme.headline3),
              ),
              SizedBox(height: 20),
              TextField(
                style: AppTheme.text1.withDarkPurple,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppTheme.perano),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppTheme.cornflowerBlue),
                  ),
                  isDense: true,
                  hintText: 'Type your title here',
                  hintStyle: AppTheme.text1,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                style: AppTheme.text1.withDarkPurple,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppTheme.perano),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppTheme.cornflowerBlue),
                  ),
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
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2025),
                        );
                      },
                      text: 'Date',
                      icon: SvgPicture.asset(Resources.date,
                          color: Colors.white, width: 16),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: RippleButton(
                      onTap: () async {
                        final TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                      },
                      text: 'Time',
                      icon: SvgPicture.asset(Resources.clock,
                          color: Colors.white, width: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              BlocBuilder<TaskCategoryBloc, TaskCategoryState>(
                builder: (context, state) {
                  if (state is TaskCategorySuccess) {
                    return DropdownButton<TaskCategoryItemEntity>(
                      onChanged: (value) {

                      },
                        items: state.entity.taskCategoryList
                            .map((e) => DropdownMenuItem<TaskCategoryItemEntity>(
                                  child: Text(e.title),
                                ))
                            .toList());
                  }
                  return Container();
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ));
  }
}
