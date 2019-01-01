import 'package:redux/redux.dart';
import 'package:incredux/incredux.dart';

enum Actions { increment, decrement }

int counterReducer(int state, dynamic action) {
  if (action == Actions.increment) {
    return state + 1;
  } else if (action == Actions.decrement) {
    return state - 1;
  }

  return state;
}

Store buildStore(incrs, {whenFn}) => Store<int>(
      counterReducer,
      initialState: 0,
      middleware: <Middleware<int>>[
        incredux<int>(incrs: incrs, whenFn: whenFn)
      ],
    );
