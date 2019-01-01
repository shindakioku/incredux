import 'package:redux/redux.dart';
import 'package:incredux/incredux.dart';

class AppState {
  final int count;
  final int clickCount;

  AppState(this.count, this.clickCount);
}

class IncrementAction {}

class DecrementAction {}

// enum AppAction { increment, decrement }

// Create a Reducer. A reducer is a pure function that takes the
// current State (int) and the Action that was dispatched. It should
// combine the two into a new state without mutating the state passed
// in! After the state is updated, the store will emit the update to
// the `onChange` stream.
//
// Because reducers are pure functions, they should not perform any
// side-effects, such as making an HTTP request or logging messages
// to a console. For that, use Middleware.
AppState counterReducer(AppState state, dynamic action) {
  if (action == IncrementAction) {
    return AppState(state.count + 1, state.clickCount);
  }
  if (action == DecrementAction) {
    return AppState(state.count - 1, state.clickCount);
  }

  return state;
}

// Create a Reducer with a State (int) and an Action (String) Any dart object
// can be used for Action and State.
AppState clickCounterReducer(AppState state, dynamic action) {
  if (action == IncrementAction) {
    return AppState(state.count, state.clickCount + 1);
  }
  if (action == DecrementAction) {
    return AppState(state.count, state.clickCount + 1);
  }

  return state;
}

Store buildStore(incrs, {whenFn}) => Store<AppState>(
      combineReducers<AppState>([
        counterReducer,
        clickCounterReducer,
      ]),
      initialState: AppState(0, 0),
      middleware: <Middleware<AppState>>[
        incredux<AppState>(incrs: incrs, whenFn: whenFn)
      ],
    );
