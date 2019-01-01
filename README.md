# incredux

Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).

## Usage

A simple usage example:

```dart
import 'package:redux/redux.dart';
import 'package:incredux/incredux.dart';

enum Actions { increment, decrement }

void main() {
  when(Actions.increment, (store) => print('(Increment) state: ${store.state}'));

  when( Actions.decrement, (store) => print('(Decrement) state: ${store.state}'));

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
    middleware: <Middleware<int>>[
      incredux<int>()
    ],
  );

  store.dispatch(Actions.increment); // Print: `(Increment) state: 1`
  store.dispatch(Actions.decrement); // Print: `(Increment) state: 0` - because did call increment before
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/shindakioku/incredux/issues
