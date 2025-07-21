import 'package:flutter/material.dart';

Future<String?> addTodoDialogBox(BuildContext context) async {
  String? todoTitle;
  await showDialog(
    context: context,
    builder: (context) {
      String title = "";
      return StatefulBuilder(
        builder: (context, setState2) {
          return AlertDialog(
            title: const Text("Add Todo"),
            content: TextField(
              autofocus: true,
              decoration: const InputDecoration(
                hintText: "Enter the name of the Task",
              ),
              onChanged: (val) {
                setState2(() {
                  title = val;
                });
              },
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: (title.isEmpty)
                    ? null
                    : () {
                        todoTitle = title;
                        Navigator.pop(context);
                      },
                child: const Text("Add"),
              ),
            ],
          );
        },
      );
    },
  );
  return todoTitle;
}
