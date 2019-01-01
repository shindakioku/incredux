import 'package:test/test.dart';
import 'package:incredux/incredux.dart';
import 'redux/increment_store.dart';

var i = 0;

increment() => when(Actions.increment, (store) {
      // print(
      //     'Increment when handler for counter store with default handler. state: ${store.state}');
      expect(store.state, 1);
      i = store.state;
    });

decrement() => when(Actions.decrement, (store) {
      // print(
      //     'Decrement when handler for counter store with default handler. state: ${store.state}');
      expect(store.state, 0);
      i = store.state;
    });

var incrs = [increment, decrement];

void main() {
  group('With default handler for middleware.', () {
    var store = buildStore(incrs);

    test('Increment action.', () {
      store.dispatch(Actions.increment);

      expect(i, 1);
    });

    test('Decrement action.', () {
      store.dispatch(Actions.decrement);
      i -= 1;

      expect(i, -1);
    });

    i = 0;
  });

  group('With custom handler for middleware.', () {
    var whenFn = (store, action, next, {whenHandler}) {
      next(action);

      whenHandler();
    };
    var store = buildStore(incrs, whenFn: whenFn);

    test('Increment action.', () {
      store.dispatch(Actions.increment);

      expect(i, 1);
    });

    test('Decrement action.', () {
      store.dispatch(Actions.decrement);
      i -= 1;

      expect(i, -1);
    });

    i = 0;
  });
}
