import 'package:flutter/material.dart';

Future<int?> showChangeThemeColorDialog(
    BuildContext context, int currentColorValue) async {
  int selectedColorValue = currentColorValue;

  Widget colorPickerWidget(int colorValue, VoidCallback onChange) {
    return InkWell(
      onTap: onChange,
      borderRadius: BorderRadius.circular(100),
      child: Ink(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Color(colorValue),
          shape: BoxShape.circle,
        ),
        child: colorValue == selectedColorValue
            ? const Icon(
                Icons.done,
                color: Colors.white,
              )
            : null,
      ),
    );
  }

  return await showDialog(
    context: context,
    builder: (context) => StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: const Text("Change Theme Color"),
        content: Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: [
            colorPickerWidget(Colors.brown.toARGB32(), () {
              setState(() {
                selectedColorValue = Colors.brown.toARGB32();
              });
            }),
            colorPickerWidget(Colors.blueGrey.toARGB32(), () {
              setState(() {
                selectedColorValue = Colors.blueGrey.toARGB32();
              });
            }),
            colorPickerWidget(Colors.deepPurple.toARGB32(), () {
              setState(() {
                selectedColorValue = Colors.deepPurple.toARGB32();
              });
            }),
            colorPickerWidget(Colors.purple.toARGB32(), () {
              setState(() {
                selectedColorValue = Colors.purple.toARGB32();
              });
            }),
            colorPickerWidget(Colors.indigo.toARGB32(), () {
              setState(() {
                selectedColorValue = Colors.indigo.toARGB32();
              });
            }),
            colorPickerWidget(Colors.blue.toARGB32(), () {
              setState(() {
                selectedColorValue = Colors.blue.toARGB32();
              });
            }),
            colorPickerWidget(Colors.lightBlue.toARGB32(), () {
              setState(() {
                selectedColorValue = Colors.lightBlue.toARGB32();
              });
            }),
            colorPickerWidget(Colors.cyan.toARGB32(), () {
              setState(() {
                selectedColorValue = Colors.cyan.toARGB32();
              });
            }),
            colorPickerWidget(Colors.teal.toARGB32(), () {
              setState(() {
                selectedColorValue = Colors.teal.toARGB32();
              });
            }),
            colorPickerWidget(Colors.green.toARGB32(), () {
              setState(() {
                selectedColorValue = Colors.green.toARGB32();
              });
            }),
            colorPickerWidget(Colors.lightGreen.toARGB32(), () {
              setState(() {
                selectedColorValue = Colors.lightGreen.toARGB32();
              });
            }),
            colorPickerWidget(Colors.lime.toARGB32(), () {
              setState(() {
                selectedColorValue = Colors.lime.toARGB32();
              });
            }),
            colorPickerWidget(Colors.yellow.toARGB32(), () {
              setState(() {
                selectedColorValue = Colors.yellow.toARGB32();
              });
            }),
            colorPickerWidget(Colors.amber.toARGB32(), () {
              setState(() {
                selectedColorValue = Colors.amber.toARGB32();
              });
            }),
            colorPickerWidget(Colors.orange.toARGB32(), () {
              setState(() {
                selectedColorValue = Colors.orange.toARGB32();
              });
            }),
            colorPickerWidget(Colors.deepOrange.toARGB32(), () {
              setState(() {
                selectedColorValue = Colors.deepOrange.toARGB32();
              });
            }),
            colorPickerWidget(Colors.red.toARGB32(), () {
              setState(() {
                selectedColorValue = Colors.red.toARGB32();
              });
            }),
            colorPickerWidget(Colors.pink.toARGB32(), () {
              setState(() {
                selectedColorValue = Colors.pink.toARGB32();
              });
            }),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, selectedColorValue),
            child: const Text("Change"),
          ),
        ],
      );
    }),
  );
}
