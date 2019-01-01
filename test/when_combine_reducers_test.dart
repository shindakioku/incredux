import 'package:test/test.dart';
import 'package:incredux/incredux.dart';
import 'redux/typed_reducers.dart';

var count = 0;
var clickCount = 0;

increment() => when(IncrementAction, (store) {
      // print(
      //     'Increment when handler for counter store with combine reducers and default handler. state: ${store.state}');
      expect(store.state.count, 1);
      expect(store.state.clickCount, 1);

      count = store.state.count;
      clickCount = store.state.clickCount;
    });

decrement() => when(DecrementAction, (store) {
      // print(
      //     'Decrement when handler for counter store with combine reducers and default handler. state: ${store.state}');
      expect(store.state.count, 0);
      expect(store.state.clickCount, 2);

      count = store.state.count;
      clickCount = store.state.clickCount;
    });

var incrs = [increment, decrement];

void main() {
  group('With default handler for middleware.', () {
    var store = buildStore(incrs);

    test('Increment action.', () {
      store.dispatch(IncrementAction);

      expect(count, 1);
      expect(clickCount, 1);
    });

    test('Decrement action.', () {
      store.dispatch(DecrementAction);
      count -= 1;
      clickCount -= 1;

      expect(count, -1);
      expect(clickCount, 1);
    });
  });

  group('With custom handler for middleware.', () {
    var whenFn = (store, action, next, {whenHandler}) {
      next(action);

      whenHandler();
    };
    var store = buildStore(incrs, whenFn: whenFn);

    test('Increment action.', () {
      store.dispatch(IncrementAction);

      expect(count, 1);
      expect(clickCount, 1);
    });

    test('Decrement action.', () {
      store.dispatch(DecrementAction);
      count -= 1;
      clickCount -= 1;

      expect(count, -1);
      expect(clickCount, 1);

      count = 0;
      clickCount = 0;
    });
  });
}
