import 'package:auto_animated/auto_animated.dart';
import 'package:flutask/data/entities/entities.dart';
import 'package:flutask/logic/blocs/blocs.dart';
import 'package:flutask/presentation/utils/utils.dart';
import 'package:flutask/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  String searchQuery = '';

  @override
  void initState() {
    context.read<SearchBloc>().add(SetInitialSearch());
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
                _searchField(),
                _taskList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _searchField() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(CupertinoIcons.back),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Hero(
              tag: Keys.heroSearch,
              child: Material(
                child: TextField(
                  autofocus: true,
                  style: AppTheme.text1.withBlack,
                  decoration: InputDecoration(
                    enabledBorder: AppTheme.enabledBorder
                        .copyWith(borderRadius: BorderRadius.circular(24)),
                    focusedBorder: AppTheme.focusedBorder
                        .copyWith(borderRadius: BorderRadius.circular(24)),
                    errorBorder: AppTheme.errorBorder
                        .copyWith(borderRadius: BorderRadius.circular(24)),
                    focusedErrorBorder: AppTheme.focusedErrorBorder
                        .copyWith(borderRadius: BorderRadius.circular(24)),
                    suffixIcon: Icon(
                      Icons.search_outlined,
                      color: AppTheme.cornflowerBlue,
                    ),
                    hintText: 'Type your Tasks here',
                  ),
                  onChanged: (value) {
                    if(value.isNotEmpty){
                      searchQuery = value;
                      context.read<SearchBloc>().add(SearchTask(searchQuery: value));
                    } else {
                      context.read<SearchBloc>().add(SetInitialSearch());
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _taskList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if(state is SearchInitial){
            return SearchWidget();
          } else if (state is SearchStream) {
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
                print(snapshot.data!.taskWithCategoryList.length);
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Found ${data.taskWithCategoryList.length} Tasks in $searchQuery',
          style: AppTheme.text1,
          textAlign: TextAlign.start,
        ),
        LiveList.options(
          options: Helper.options,
          itemCount: data.taskWithCategoryList.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index, animation) {
            final item = data.taskWithCategoryList[index];
            return TaskItemWidget(
              task: item.taskItemEntity,
              category: item.taskCategoryItemEntity,
              animation: animation,
            );
          },
        ),
      ],
    );
  }
}
