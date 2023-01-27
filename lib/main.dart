import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:todo_list/todo.dart';

void main() {
  runApp(const TodoListApp());
}

class TodoListApp extends StatelessWidget {
  const TodoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.amber,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.amber,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<AnimatedListState> _animatedListStateKey =
      GlobalKey<AnimatedListState>();
  late final Isar _isar;
  List<Todo> todoList = [];
  bool isLoading = true;

  @override
  void initState() {
    getTodos();
    super.initState();
  }

  Widget listTile(
      BuildContext context, int index, Animation<double> animation) {
    return SlideTransition(
      position:
          Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
          reverseCurve: Curves.easeInOutBack,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          leading: Checkbox(
            value: false,
            onChanged: (_) {
              deleteTodo(index);
            },
          ),
          title: Text(todoList[index].title),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                String newTitle = "";
                return StatefulBuilder(builder: (context, setState2) {
                  return AlertDialog(
                    title: const Text("Edit Todo"),
                    content: TextFormField(
                      autofocus: true,
                      initialValue: todoList[index].title,
                      decoration: const InputDecoration(
                          hintText: "Enter the name of the Task"),
                      onChanged: (val) {
                        setState2(() {
                          newTitle = val;
                        });
                      },
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: (newTitle.isEmpty)
                            ? null
                            : () => editTodo(index, newTitle)
                                .then((value) => Navigator.pop(context)),
                        child: const Text("Edit"),
                      ),
                    ],
                  );
                });
              },
            );
          },
        ),
      ),
    );
  }

  Widget removeListTile(
      BuildContext context, String title, Animation<double> animation) {
    return SlideTransition(
      position:
          Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
          reverseCurve: Curves.easeInOutBack,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: CheckboxListTile(
          value: true,
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (_) {},
          title: Text(
            title,
            style: const TextStyle(decoration: TextDecoration.lineThrough),
          ),
        ),
      ),
    );
  }

  Future getTodos() async {
    _isar = await Isar.open([TodoSchema]);
    todoList = await _isar.todos.where().findAll();
    for (int i = 0; i < todoList.length; i++) {
      _animatedListStateKey.currentState
          ?.insertItem(i, duration: const Duration(milliseconds: 500));
      await Future.delayed(const Duration(milliseconds: 250));
    }
    setState(() {
      isLoading = false;
    });
  }

  Future addTodo(String title) async {
    _animatedListStateKey.currentState?.insertItem(
      todoList.length,
      duration: const Duration(milliseconds: 500),
    );
    if (todoList.isEmpty) {
      Future.delayed(const Duration(milliseconds: 250), () {
        setState(() {});
      });
    }
    todoList.add(Todo(title));
    await _isar.writeTxn(() async {
      await _isar.todos.put(todoList.last);
    });
  }

  Future editTodo(int index, String newTitle) async {
    todoList[index].title = newTitle;
    _animatedListStateKey.currentState?.setState(() {});
    await _isar.writeTxn(() async {
      await _isar.todos.put(todoList[index]);
    });
  }

  Future deleteTodo(int index) async {
    await _isar.writeTxn(() async {
      await _isar.todos.delete(todoList[index].id);
    });
    Todo removedTodo = todoList.removeAt(index);
    _animatedListStateKey.currentState?.removeItem(
      index,
      (context, animation) =>
          removeListTile(context, removedTodo.title, animation),
      duration: const Duration(milliseconds: 1000),
    );
    if (todoList.isEmpty) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {});
      });
    }
  }

  void addTodoDialogBox() {
    showDialog(
      context: context,
      builder: (context) {
        String title = "";
        return StatefulBuilder(builder: (context, setState2) {
          return AlertDialog(
            title: const Text("Add Todo"),
            content: TextField(
              autofocus: true,
              decoration:
                  const InputDecoration(hintText: "Enter the name of the Task"),
              onChanged: (val) {
                setState2(() {
                  title = val;
                });
              },
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: (title.isEmpty)
                    ? null
                    : () =>
                        addTodo(title).then((value) => Navigator.pop(context)),
                child: const Text("Add"),
              ),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Todo List"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTodoDialogBox,
        child: const Icon(Icons.add),
      ),
      body: (todoList.isEmpty && !isLoading)
          ? const Center(
              child: Text(
                "No Tasks left ☺",
              ),
            )
          : AnimatedList(
              key: _animatedListStateKey,
              initialItemCount: todoList.length,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              itemBuilder: (context, index, animation) {
                return listTile(context, index, animation);
              },
            ),
    );
  }
}
