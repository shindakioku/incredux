import 'package:test/test.dart';
import 'package:redux/redux.dart';
import 'package:incredux/incredux.dart';

var i = 0;

enum Actions { increment, decrement }

void main() {
  test('Without incrs', () {
    when(Actions.increment, (store, action) => i = store.state);
    when(Actions.decrement, (store, action) => i = store.state);

    int counterReducer(int state, dynamic action) {
      if (action == Actions.increment) {
        return state + 1;
      } else if (action == Actions.decrement) {
        return state - 1;
      }

      return state;
    }

    var store = Store<int>(
      counterReducer,
      initialState: 0,
      middleware: <Middleware<int>>[incredux<int>()],
    );

    store.dispatch(Actions.increment);
    expect(i, 1);

    store.dispatch(Actions.decrement);
    expect(i, 0);
  });
}
