import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/provider.dart';
import '../utils/utils.dart';

class SearchAndFilter extends StatelessWidget {
  const SearchAndFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? _textColor(BuildContext context, Filter filter) {
      final currentFilter = context.watch<TodoFilter>().state.filter;
      return currentFilter == filter ? Colors.blue : Colors.black54;
    }

    TextButton _filterButton(BuildContext context, Filter filter) {
      return TextButton(
        onPressed: () {
          context.read<TodoFilter>().changeFilter(filter);
        },
        child: Text(
          filter == Filter.all
              ? 'All'
              : filter == Filter.active
                  ? 'Active'
                  : 'Complete',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: _textColor(context, filter),
          ),
        ),
        style: const ButtonStyle(visualDensity: VisualDensity.compact),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          TextField(
            onChanged: (String? value) {
              if (value != null) {
                context.read<TodoSearch>().searchTodo(value);
              }
            },
            decoration: const InputDecoration(
              filled: true,
              hintText: 'Seacrh',
              border: InputBorder.none,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  ' ${context.watch<ActiveTodos>().state.activeTodoCount.toString()} Task left',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
              ),
              Row(
                children: [
                  _filterButton(context, Filter.all),
                  _filterButton(context, Filter.active),
                  _filterButton(context, Filter.complete),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
