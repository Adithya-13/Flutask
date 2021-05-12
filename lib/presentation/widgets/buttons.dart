import 'package:flutask/presentation/utils/utils.dart';
import 'package:flutter/material.dart';

class RippleButton extends StatelessWidget {
  final String text;
  final Widget? icon;
  final VoidCallback onTap;

  const RippleButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.icon,
  }) : super(key: key);

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
        child: icon != null ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon!,
            SizedBox(width: 8),
            Text(
              text,
              style: AppTheme.text2,
              textAlign: TextAlign.center,
            ),
          ],
        ): Text(
        text,
        style: AppTheme.text2,
        textAlign: TextAlign.center,
      ),
      ).addRipple(onTap: onTap),
    );
  }
}
