class Container {
  final Map<dynamic, Function> _ = {};

  bool containsKey(key) => true;

  MapEntry byAction(dynamic action) =>
      _.entries.firstWhere((MapEntry<dynamic, Function> v) => v.key == action);

  static final Container instance = Container._internal();

  factory Container() => instance;

  void add(dynamic action, Function f) => _.addAll({action: f});

  Container._internal();
}
