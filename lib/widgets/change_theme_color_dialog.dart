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
            colorPickerWidget(Colors.brown.value, () {
              setState(() {
                selectedColorValue = Colors.brown.value;
              });
            }),
            colorPickerWidget(Colors.blueGrey.value, () {
              setState(() {
                selectedColorValue = Colors.blueGrey.value;
              });
            }),
            colorPickerWidget(Colors.deepPurple.value, () {
              setState(() {
                selectedColorValue = Colors.deepPurple.value;
              });
            }),
            colorPickerWidget(Colors.purple.value, () {
              setState(() {
                selectedColorValue = Colors.purple.value;
              });
            }),
            colorPickerWidget(Colors.indigo.value, () {
              setState(() {
                selectedColorValue = Colors.indigo.value;
              });
            }),
            colorPickerWidget(Colors.blue.value, () {
              setState(() {
                selectedColorValue = Colors.blue.value;
              });
            }),
            colorPickerWidget(Colors.lightBlue.value, () {
              setState(() {
                selectedColorValue = Colors.lightBlue.value;
              });
            }),
            colorPickerWidget(Colors.cyan.value, () {
              setState(() {
                selectedColorValue = Colors.cyan.value;
              });
            }),
            colorPickerWidget(Colors.teal.value, () {
              setState(() {
                selectedColorValue = Colors.teal.value;
              });
            }),
            colorPickerWidget(Colors.green.value, () {
              setState(() {
                selectedColorValue = Colors.green.value;
              });
            }),
            colorPickerWidget(Colors.lightGreen.value, () {
              setState(() {
                selectedColorValue = Colors.lightGreen.value;
              });
            }),
            colorPickerWidget(Colors.lime.value, () {
              setState(() {
                selectedColorValue = Colors.lime.value;
              });
            }),
            colorPickerWidget(Colors.yellow.value, () {
              setState(() {
                selectedColorValue = Colors.yellow.value;
              });
            }),
            colorPickerWidget(Colors.amber.value, () {
              setState(() {
                selectedColorValue = Colors.amber.value;
              });
            }),
            colorPickerWidget(Colors.orange.value, () {
              setState(() {
                selectedColorValue = Colors.orange.value;
              });
            }),
            colorPickerWidget(Colors.deepOrange.value, () {
              setState(() {
                selectedColorValue = Colors.deepOrange.value;
              });
            }),
            colorPickerWidget(Colors.red.value, () {
              setState(() {
                selectedColorValue = Colors.red.value;
              });
            }),
            colorPickerWidget(Colors.pink.value, () {
              setState(() {
                selectedColorValue = Colors.pink.value;
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
