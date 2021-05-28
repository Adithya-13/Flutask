import 'package:flutask/presentation/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

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
                  style: AppTheme.text1.withDarkPurple,
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
                    hintText: 'Search Tasks here',
                  ),
                  onChanged: (value) {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
