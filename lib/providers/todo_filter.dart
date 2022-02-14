import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../utils/utils.dart';

class TodoFilterState extends Equatable {
  final Filter filter;

  const TodoFilterState({
    required this.filter,
  });

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'TodoFilterState(filter: $filter)';

  TodoFilterState copyWith({
    Filter? filter,
  }) {
    return TodoFilterState(
      filter: filter ?? this.filter,
    );
  }

  factory TodoFilterState.initial() =>
      const TodoFilterState(filter: Filter.all);
}

class TodoFilter with ChangeNotifier {
  TodoFilterState _state = TodoFilterState.initial();

  TodoFilterState get state => _state;

  void changeFilter(Filter filter) {
    _state = _state.copyWith(filter: filter);
    notifyListeners();
  }
}
