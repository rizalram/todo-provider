import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class TodoSeacrhState extends Equatable {
  final String searchKey;

  const TodoSeacrhState({
    required this.searchKey,
  });

  @override
  List<Object> get props => [searchKey];

  @override
  String toString() => 'TodoSeacrhState(searchKey: $searchKey)';

  TodoSeacrhState copyWith({
    String? searchKey,
  }) {
    return TodoSeacrhState(
      searchKey: searchKey ?? this.searchKey,
    );
  }

  factory TodoSeacrhState.initial() => const TodoSeacrhState(searchKey: '');
}

class TodoSearch with ChangeNotifier {
  TodoSeacrhState _state = TodoSeacrhState.initial();

  TodoSeacrhState get state => _state;

  void searchTodo(String newSearchKey) {
    _state = _state.copyWith(searchKey: newSearchKey);
    notifyListeners();
  }
}
