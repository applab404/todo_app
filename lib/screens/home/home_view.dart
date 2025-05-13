import 'package:flutter/material.dart';
import '../../widgets/todo_tile.dart';
import 'home_page.dart';

class HomeView extends StatelessWidget {
  final HomePageState state;

  const HomeView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body:
          state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(children: [_buildInputField(context), _buildTodoList()]),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("TODO", style: TextStyle(fontWeight: FontWeight.w600)),
      actions: [
        IconButton(
          icon: const Icon(Icons.brightness_6),
          onPressed: state.widget.onToggleTheme,
        ),
      ],
    );
  }

  Widget _buildInputField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: state.controller,
                decoration: const InputDecoration(
                  labelText: "Add a new task",
                  border: InputBorder.none,
                ),
                onSubmitted: (_) => state.addTodo(),
              ),
            ),
            IconButton(icon: const Icon(Icons.add), onPressed: state.addTodo),
          ],
        ),
      ),
    );
  }

  Widget _buildTodoList() {
    if (state.todos.isEmpty) {
      return const Expanded(
        child: Center(
          child: Text(
            'No tasks yet.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.separated(
        itemCount: state.todos.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final todo = state.todos[index];
          return TodoTile(
            todo: todo,
            onToggle: () => state.toggleTodo(index),
            onDelete: () => state.deleteTodo(index),
          );
        },
      ),
    );
  }
}
