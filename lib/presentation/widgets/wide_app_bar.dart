import 'package:flutask/presentation/utils/utils.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:flutter/material.dart';

class WideAppBar extends StatelessWidget {
  const WideAppBar({
    Key? key,
    required this.tag,
    required this.title,
    required this.gradient,
    required this.child, this.actions,
  }) : super(key: key);

  final String tag;
  final String title;
  final LinearGradient gradient;
  final Widget child;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      title: Hero(
        tag: Keys.heroTitleCategory + tag,
        child: Text(
          title,
          style: AppTheme.headline2.withWhite,
        ),
      ),
      actions: actions,
      backgroundColor:
      gradient.colors[0].mix(gradient.colors[1], 0.5),
      stretch: true,
      shadowColor: AppTheme.getShadow(gradient.colors[1])[0].color,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: gradient.withDiagonalGradient,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
          child: child,
        ),
      ),
    );
  }
}
