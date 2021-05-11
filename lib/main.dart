import 'package:flutask/data/data_providers/local/moor_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import 'data/exceptions/api_exception.dart';
import 'data/repositories/repositories.dart';
import 'logic/blocs/blocs.dart';
import 'presentation/routes/routes.dart';
import 'presentation/utils/utils.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  final AppDatabase appDatabase = AppDatabase();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<HomeRepository>(
          create: (context) => HomeRepository(),
        ),
        RepositoryProvider<TaskRepository>(
          create: (context) => TaskRepository(appDatabase: appDatabase),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TaskCategoryBloc>(
            create: (context) => TaskCategoryBloc(
              repository: context.read<HomeRepository>(),
            ),
          ),
          BlocProvider<TaskBloc>(
            create: (context) => TaskBloc(
              taskRepository: context.read<TaskRepository>(),
            ),
            child: Container(),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  late final PageRouter _router;

  MyApp() : _router = PageRouter() {
    initLogger();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FluTask',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: AppTheme.scaffoldColor,
          fontFamily: 'Gotham'),
      onGenerateRoute: _router.getRoute,
      navigatorObservers: [_router.routeObserver],
    );
  }

  void initLogger() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      dynamic e = record.error;
      String m = e is APIException ? e.message : e.toString();
      print(
          '${record.loggerName}: ${record.level.name}: ${record.message} ${m != 'null' ? m : ''}');
    });
    Logger.root.info("Logger initialized.");
  }
}
