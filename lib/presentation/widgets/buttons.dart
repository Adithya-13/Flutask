import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutask/presentation/utils/utils.dart';
import 'package:flutter/material.dart';

class RippleButton extends StatelessWidget {
  final String text;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final VoidCallback onTap;

  const RippleButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.prefixWidget,
    this.suffixWidget,
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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              prefixWidget ?? Container(),
              AutoSizeText(
                text,
                style: AppTheme.text1.withWhite,
                textAlign: TextAlign.center,
                minFontSize: 8,
                maxLines: 1,
              ),
              suffixWidget ?? Container(),
            ],
          )).addRipple(onTap: onTap),
    );
  }
}

class RippleCircleButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const RippleCircleButton({
    Key? key,
    required this.onTap, required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppTheme.purpleGradient.withHorizontalGradient,
        boxShadow: AppTheme.getShadow(AppTheme.cornflowerBlue),
        shape: BoxShape.circle,
      ),
      child: Padding(
          padding: EdgeInsets.all(16),
          child: child,
          ).addRipple(onTap: onTap),
    );
  }
}

class PinkButton extends StatelessWidget {
  final String text;
  final Widget? icon;
  final VoidCallback onTap;

  const PinkButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppTheme.pinkGradient.withHorizontalGradient,
        boxShadow: AppTheme.getShadow(AppTheme.frenchRose),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: icon != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon!,
                  SizedBox(width: 8),
                  Text(
                    text,
                    style: AppTheme.headline3.withWhite,
                    textAlign: TextAlign.center,

                  ),
                ],
              )
            : Text(
                text,
                style: AppTheme.headline3.withWhite,
                textAlign: TextAlign.center,
              ),
      ).addRipple(onTap: onTap),
    );
  }
}
