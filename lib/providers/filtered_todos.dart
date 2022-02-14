import 'package:equatable/equatable.dart';
import 'package:todo_provider/models/todo.dart';
import 'package:todo_provider/providers/todo_filter.dart';
import 'package:todo_provider/providers/todo_list.dart';
import 'package:todo_provider/providers/todo_search.dart';

import '../utils/utils.dart';

class FilteredTodosState extends Equatable {
  final List<Todo> filteredTodos;

  const FilteredTodosState({
    required this.filteredTodos,
  });

  @override
  List<Object> get props => [filteredTodos];

  @override
  String toString() => 'FilteredTodoState(filteredTodos: $filteredTodos)';

  FilteredTodosState copyWith({
    List<Todo>? filteredTodos,
  }) {
    return FilteredTodosState(
      filteredTodos: filteredTodos ?? this.filteredTodos,
    );
  }

  factory FilteredTodosState.initial() =>
      const FilteredTodosState(filteredTodos: []);
}

class FilteredTodos {
  final TodoFilter todoFilter;
  final TodoSearch todoSearch;
  final TodoList todoList;

  FilteredTodos({
    required this.todoFilter,
    required this.todoSearch,
    required this.todoList,
  });

  FilteredTodosState get state {
    List<Todo> _filteredTodos;

    switch (todoFilter.state.filter) {
      case Filter.active:
        _filteredTodos =
            todoList.state.todos.where((Todo todo) => !todo.complete).toList();
        break;
      case Filter.complete:
        _filteredTodos =
            todoList.state.todos.where((Todo todo) => todo.complete).toList();
        break;
      case Filter.all:
      default:
        _filteredTodos = todoList.state.todos;
        break;
    }

    if (todoSearch.state.searchKey.isNotEmpty) {
      _filteredTodos = _filteredTodos
          .where((Todo todo) =>
              todo.desc.toLowerCase().contains(todoSearch.state.searchKey))
          .toList();
    }

    return FilteredTodosState(filteredTodos: _filteredTodos);
  }
}
