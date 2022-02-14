import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/models/todo.dart';
import 'package:todo_provider/providers/filtered_todos.dart';
import 'package:todo_provider/providers/todo_list.dart';

class ListTodo extends StatelessWidget {
  const ListTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodos>().state.filteredTodos;

    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _BuildItem(todo: todos[index]);
      },
      separatorBuilder: (context, index) => const Divider(
        indent: 16,
        endIndent: 16,
      ),
      itemCount: todos.length,
    );
  }
}

class _BuildItem extends StatelessWidget {
  const _BuildItem({Key? key, required this.todo}) : super(key: key);
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: todo.complete,
        onChanged: (_) {
          context.read<TodoList>().toggle(todo.id);
        },
      ),
      title: Text(todo.desc),
      trailing: IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                elevation: 0,
                content: const Text('Delete task?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<TodoList>().remove(todo);
                      Navigator.pop(context);
                    },
                    child: const Text('Delete'),
                  ),
                ],
              );
            },
          );
        },
        icon: const Icon(Icons.delete),
      ),
      onTap: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (contex) {
            return _EditItem(todo: todo);
          },
        );
      },
    );
  }
}

class _EditItem extends StatefulWidget {
  const _EditItem({Key? key, required this.todo}) : super(key: key);

  final Todo todo;

  @override
  __EditItemState createState() => __EditItemState();
}

class __EditItemState extends State<_EditItem> {
  late final TextEditingController controller;
  bool isComposing = false;

  @override
  void initState() {
    controller = TextEditingController();
    controller.addListener(() {
      final isComposing = controller.text.isNotEmpty;

      setState(() => this.isComposing = isComposing);
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      title: const Text('Edit'),
      content: TextField(
        autofocus: true,
        controller: controller,
        decoration: InputDecoration(hintText: widget.todo.desc),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: isComposing
              ? () {
                  context
                      .read<TodoList>()
                      .edit(widget.todo.id, controller.text);
                  Navigator.pop(context);
                }
              : null,
          child: const Text('SAVE'),
        ),
      ],
    );
  }
}
