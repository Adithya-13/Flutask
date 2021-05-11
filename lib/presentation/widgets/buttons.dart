import 'package:flutask/presentation/utils/utils.dart';
import 'package:flutter/material.dart';

class RippleButton extends StatelessWidget {
  final VoidCallback onTap;

  const RippleButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppTheme.purpleGradient.withHorizontalGradient,
        boxShadow: AppTheme.getShadow(AppTheme.cornflowerBlue),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text('Skip', style: AppTheme.text2),
      ).addRipple(onTap: onTap),
    );
  }
}
