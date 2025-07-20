import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';

class TodoListTile extends StatelessWidget {
  final Todo todo;
  final Animation<double> animation;
  final VoidCallback editTodo;
  final VoidCallback checkedTodo;
  final VoidCallback deleteTodo;
  const TodoListTile({
    super.key,
    required this.todo,
    required this.animation,
    required this.editTodo,
    required this.checkedTodo,
    required this.deleteTodo,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
          .animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
              reverseCurve: Curves.easeInOutBack,
            ),
          ),
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ExpansionTile(
          leading: Checkbox(
            value: todo.isCompleted,
            onChanged: (_) => checkedTodo(),
          ),
          title: (todo.isCompleted)
              ? Text(
                  todo.title,
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                  ),
                )
              : Text(todo.title),
          childrenPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          expandedAlignment: Alignment.centerLeft,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          children: [
            Builder(
              builder: (context) {
                return TextButton.icon(
                  onPressed: () {
                    ExpansibleController.of(context).collapse();
                    editTodo();
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit"),
                );
              },
            ),
            Builder(
              builder: (context) {
                return TextButton.icon(
                  onPressed: () {
                    ExpansibleController.of(context).collapse();
                    deleteTodo();
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text("Delete"),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.redAccent,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
