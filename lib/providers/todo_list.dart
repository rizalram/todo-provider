import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_provider/models/todo.dart';

class TodoListState extends Equatable {
  final List<Todo> todos;

  const TodoListState({
    required this.todos,
  });

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'TodoListState(todos: $todos)';

  TodoListState copyWith({
    List<Todo>? todos,
  }) {
    return TodoListState(
      todos: todos ?? this.todos,
    );
  }

  factory TodoListState.initial() => TodoListState(
        todos: [
          Todo(desc: 'First task'),
          Todo(desc: 'Second task'),
          Todo(desc: 'Third task'),
        ],
      );
}

class TodoList with ChangeNotifier {
  TodoListState _state = TodoListState.initial();

  TodoListState get state => _state;

  void add(String newDesc) {
    final newTodo = Todo(desc: newDesc);
    final newTodos = [..._state.todos, newTodo];

    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

  void edit(String id, String newDesc) {
    final newTodos = _state.todos.map((Todo todo) {
      if (todo.id == id) {
        return Todo(
          id: todo.id,
          desc: newDesc,
          complete: todo.complete,
        );
      }
      return todo;
    }).toList();

    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

  void toggle(String id) {
    final newTodos = _state.todos.map((Todo todo) {
      if (todo.id == id) {
        return Todo(
          id: todo.id,
          desc: todo.desc,
          complete: !todo.complete,
        );
      }
      return todo;
    }).toList();

    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

  void remove(Todo todo) {
    final newTodos =
        _state.todos.where((Todo target) => target.id != todo.id).toList();

    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }
}
