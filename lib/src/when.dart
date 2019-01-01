import 'package:redux/redux.dart' show Store;

import 'container.dart';

/**
 * Adding listener for action.
 * [action] - Action for reducer to listen.
 * [f] - Handler for listener.
 */
void when<T>(dynamic action, void Function(Store<T>) f) =>
    Container().add(action, f);
