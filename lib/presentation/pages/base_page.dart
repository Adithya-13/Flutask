import 'package:flutask/data/entities/entities.dart';
import 'package:flutask/logic/blocs/blocs.dart';
import 'package:flutask/presentation/pages/pages.dart';
import 'package:flutask/presentation/utils/utils.dart';
import 'package:flutask/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

            context.read<TaskBloc>().add(InsertTask(
                taskItemEntity: TaskItemEntity(
                    categoryId: 0,
                    title: 'Mobile App Design',
                    description: 'Blabla',
                    deadline: DateTime.now())));
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
