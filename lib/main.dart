import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/pages/todo_page.dart';
import 'package:todo_provider/providers/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TodoFilter>(
          create: (context) => TodoFilter(),
        ),
        ChangeNotifierProvider<TodoSearch>(
          create: (context) => TodoSearch(),
        ),
        ChangeNotifierProvider<TodoList>(
          create: (context) => TodoList(),
        ),
        ProxyProvider<TodoList, ActiveTodos>(
          update: (
            BuildContext context,
            TodoList todoList,
            ActiveTodos? _,
          ) {
            return ActiveTodos(todoList: todoList);
          },
        ),
        ProxyProvider3<TodoFilter, TodoSearch, TodoList, FilteredTodos>(
          update: (
            BuildContext context,
            TodoFilter todoFilter,
            TodoSearch todoSearch,
            TodoList todoList,
            FilteredTodos? _,
          ) {
            return FilteredTodos(
              todoFilter: todoFilter,
              todoSearch: todoSearch,
              todoList: todoList,
            );
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TodoPage(),
      ),
    );
  }
}
