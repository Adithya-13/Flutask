import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'app_theme.dart';

extension Gradient on LinearGradient {
  LinearGradient get withVerticalGradient {
    return LinearGradient(
      colors: this.colors,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }

  LinearGradient get withHorizontalGradient {
    return LinearGradient(
      colors: this.colors,
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
  }

  LinearGradient get withDiagonalGradient {
    return LinearGradient(
      colors: this.colors,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  LinearGradient get randomGradientColor {
    return AppTheme.listGradient[Random().nextInt(12)];
  }
}

extension FormattedDate on DateTime {
  String format(String format) {
    return DateFormat(format).format(this);
  }
}

extension TextStyling on TextStyle {
  TextStyle get bold {
    return this.copyWith(fontWeight: FontWeight.w700);
  }

  TextStyle get normal {
    return this.copyWith(fontWeight: FontWeight.w500);
  }

  TextStyle get light {
    return this.copyWith(fontWeight: FontWeight.w100);
  }

  TextStyle get withBlack {
    return this.copyWith(color: AppTheme.boldColorFont);
  }

  TextStyle get withPurple {
    return this.copyWith(color: AppTheme.cornflowerBlue);
  }

  TextStyle get withGreyPurple {
    return this.copyWith(color: AppTheme.normalColorFont);
  }

  TextStyle get withWhite {
    return this.copyWith(color: Colors.white);
  }

  TextStyle get withPink {
    return this.copyWith(color: AppTheme.frenchRose);
  }

  TextStyle get moreLineSpace {
    return this.copyWith(height: 1.5);
  }
}

extension Ripple on Widget {
  Widget addRipple({required VoidCallback onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.white.withOpacity(0.1),
        highlightColor: Colors.white.withOpacity(0.1),
        child: this,
      ),
    );
  }
}