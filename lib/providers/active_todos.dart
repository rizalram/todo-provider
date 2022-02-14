import 'package:equatable/equatable.dart';
import 'package:todo_provider/providers/todo_list.dart';
import '../models/todo.dart';

class ActiveTodosState extends Equatable {
  final int activeTodoCount;

  const ActiveTodosState({
    required this.activeTodoCount,
  });

  @override
  List<Object> get props => [activeTodoCount];

  @override
  String toString() => 'ActiveTodoState(activeTodoCount: $activeTodoCount)';

  ActiveTodosState copyWith({
    int? activeTodoCount,
  }) {
    return ActiveTodosState(
      activeTodoCount: activeTodoCount ?? this.activeTodoCount,
    );
  }

  factory ActiveTodosState.initial() =>
      const ActiveTodosState(activeTodoCount: 0);
}

class ActiveTodos {
  final TodoList todoList;

  ActiveTodos({
    required this.todoList,
  });

  ActiveTodosState get state => ActiveTodosState(
        activeTodoCount: todoList.state.todos
            .where((Todo todo) => !todo.complete)
            .toList()
            .length,
      );
}
