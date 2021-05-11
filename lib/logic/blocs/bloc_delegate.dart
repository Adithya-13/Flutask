import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class SimpleBlocObserver extends BlocObserver {

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('onEvent $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition $transition');
  }

  @override
    void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
      print(error);
      super.onError(bloc, error, stackTrace);
    }
}