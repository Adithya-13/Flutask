import 'package:flutask/presentation/pages/pages.dart';
import 'package:flutask/presentation/routes/argument_bundle.dart';
import 'package:flutter/material.dart';

import 'page_path.dart';

class PageRouter {
  final RouteObserver<PageRoute> routeObserver;

  PageRouter() : routeObserver = RouteObserver<PageRoute>();

  Route<dynamic> getRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case PagePath.splash:
        return _buildRoute(settings, SplashPage());
      case PagePath.onBoard:
        return _buildRoute(settings, OnBoardPage());
      case PagePath.base:
        return _buildRoute(settings, BasePage());
      case PagePath.detailCategory:
        return _buildRoute(
          settings,
          DetailCategoryTaskPage(
            bundle: args as ArgumentBundle,
          ),
        );
      case PagePath.onGoingComplete:
        return _buildRoute(
          settings,
          OnGoingCompletePage(
            bundle: args as ArgumentBundle,
          ),
        );
      case PagePath.search:
        return _buildRoute(settings, SearchPage());
      default:
        return _errorRoute();
    }
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (ctx) => builder,
    );
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
