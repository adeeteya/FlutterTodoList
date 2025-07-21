import 'package:flutter/material.dart';

Future<String?> editTodoDialogBox(BuildContext context, String oldTitle) async {
  String? newTitle;
  await showDialog(
    context: context,
    builder: (context) {
      String title = "";
      return StatefulBuilder(
        builder: (context, setState2) {
          return AlertDialog(
            title: const Text("Edit Todo"),
            content: TextFormField(
              autofocus: true,
              initialValue: oldTitle,
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
                        newTitle = title;
                        return Navigator.pop(context);
                      },
                child: const Text("Edit"),
              ),
            ],
          );
        },
      );
    },
  );
  return newTitle;
}
