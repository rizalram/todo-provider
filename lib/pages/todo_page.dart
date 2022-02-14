import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/providers/provider.dart';
import 'package:todo_provider/widgets/list_todos.dart';
import '../widgets/search_and_filter.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: const [
            _AddTodo(),
            SearchAndFilter(),
            ListTodo(),
          ],
        ),
      ),
    );
  }
}

class _AddTodo extends StatefulWidget {
  const _AddTodo({Key? key}) : super(key: key);

  @override
  __AddTodoState createState() => __AddTodoState();
}

class __AddTodoState extends State<_AddTodo> {
  final controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        top: 16,
        right: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Todos',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            onSubmitted: (String? value) {
              if (value != null && value.trim().isNotEmpty) {
                Provider.of<TodoList>(context, listen: false).add(value);
                controller.clear();
              }
            },
            decoration: const InputDecoration(
              labelText: 'What need to be done?',
            ),
          ),
        ],
      ),
    );
  }
}
