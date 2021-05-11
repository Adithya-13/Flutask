import 'dart:math';

import 'package:flutask/presentation/routes/routes.dart';
import 'package:flutask/presentation/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardPage extends StatefulWidget {
  @override
  _OnBoardPageState createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  int currentContent = 0;
  List contentList = [];

  @override
  void initState() {
    contentList = StaticData.getOnBoardingList();
    super.initState();
  }

  void _nextContent() {
    if (currentContent == 2) {
      Navigator.pushReplacementNamed(context, PagePath.base);
      return;
    }

    setState(() {
      currentContent++;
    });
  }

  void _backContent() {
    if (currentContent == 0) {
      return;
    }

    setState(() {
      currentContent--;
    });
  }

  void _goToBasePage() {
    Navigator.pushReplacementNamed(context, PagePath.base);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pictonBlue,
      body: Column(
        children: [
          _onBoardContent(),
          _onBoardNavigator(),
        ],
      ),
    );
  }

  _onBoardContent() {
    return Expanded(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(40)),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(20),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: RippleButton(onTap: _goToBasePage),
                    ),
                    SizedBox(height: 20),
                    _carouselOnBoard(),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            bottom: -30,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Transform.rotate(
                angle: pi / 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  height: 70,
                  width: 70,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            right: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppTheme.pinkGradient.withVerticalGradient,
              ),
              child: Icon(
                Icons.arrow_right,
                color: Colors.white,
                size: 30,
              ),
            ).addRipple(onTap: _nextContent),
          ),
        ],
      ),
    );
  }

  Expanded _carouselOnBoard() {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: SvgPicture.asset(
              contentList[currentContent][1],
            ),
          ),
          SizedBox(height: 20),
          Text(contentList[currentContent][0], style: AppTheme.headline1),
          SizedBox(height: 20),
          Text(
            contentList[currentContent][2],
            style: AppTheme.text3.moreLineSpace,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  _onBoardNavigator() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 40, 20, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
              onPressed: _backContent,
              child: Text('BACK',
                  style: currentContent == 0
                      ? AppTheme.text2.light
                      : AppTheme.text2)),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  color: currentContent == 0
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8),
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  color: currentContent == 1
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8),
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  color: currentContent == 2
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8),
            ],
          ),
          TextButton(
              onPressed: _nextContent,
              child: Text(currentContent == 2 ? 'FINISH' : 'NEXT',
                  style: AppTheme.text2)),
        ],
      ),
    );
  }
}