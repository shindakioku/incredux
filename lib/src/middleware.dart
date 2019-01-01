import 'package:redux/redux.dart';

import 'when.dart';
import 'container.dart';

typedef void FNext<T>(Store<T> store, dynamic action, NextDispatcher next,
    {void whenHandler()});

void _fNextDefault<T>(Store<T> store, dynamic action, NextDispatcher next) {
  next(action);

  _prepareWhenFn<T>(store, action)();
}

void Function() _prepareWhenFn<T>(Store<T> store, dynamic action) =>
    Container().containsKey(action)
        ? () => Container().byAction(action).value(store)
        : () => {};

/**
 * Middleware for redux.
 * [incrs] - Your functions with [when] functions.
 * ```dart
 *      user() {
 *        when(YourAction, (store) => null);
 *      }
 *         
 *      auth() {
 *        when(YourAction2, (store) => null);
 *      }
 * 
 *      incredux(incrs: [user, auth]);
 * ```
 * [whenFn] - Custom handler for redux middleware.
 */
Middleware<T> incredux<T>({List<Function> incrs: const [], FNext<T> whenFn}) {
  if (incrs.isNotEmpty) incrs.forEach((_) => _());

  return (Store<T> store, dynamic action, NextDispatcher next) {
    return null == whenFn
        ? _fNextDefault<T>(store, action, next)
        : whenFn(store, action, next,
            whenHandler: _prepareWhenFn<T>(store, action));
  };
}
