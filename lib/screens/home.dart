import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/screens/settings.dart';
import 'package:todo_list/services/database_service.dart';
import 'package:todo_list/widgets/add_dialog_box.dart';
import 'package:todo_list/widgets/edit_dialog_box.dart';
import 'package:todo_list/widgets/todo_list_tile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DatabaseService _isarService = DatabaseService();
  final GlobalKey<AnimatedListState> _animatedListStateKey =
      GlobalKey<AnimatedListState>();
  List<Todo> todoList = [];
  bool _isLoading = true;

  @override
  void initState() {
    initTodos();
    super.initState();
  }

  Future<void> initTodos() async {
    todoList = await _isarService.getTodos();
    for (int i = 0; i < todoList.length; i++) {
      _animatedListStateKey.currentState
          ?.insertItem(i, duration: const Duration(milliseconds: 500));
      await Future.delayed(const Duration(milliseconds: 250));
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> addTodo() async {
    String? newTodoTitle = await addTodoDialogBox(context);
    if (newTodoTitle == null) {
      return;
    }
    final Todo newTodo = Todo(newTodoTitle, false);
    await _isarService.addTodo(newTodo);
    _animatedListStateKey.currentState?.insertItem(
      todoList.length,
      duration: const Duration(milliseconds: 500),
    );
    if (todoList.isEmpty) {
      Future.delayed(const Duration(milliseconds: 250), () {
        setState(() {});
      });
    }
    todoList.add(newTodo);
  }

  Future<void> editTodo(int index) async {
    String? newTitle = await editTodoDialogBox(context, todoList[index].title);
    if (newTitle == null) {
      return;
    }
    todoList[index] = todoList[index].copyWith(title: newTitle);
    _animatedListStateKey.currentState?.setState(() {});
    await _isarService.editTodo(todoList[index]);
  }

  Future<void> checkedTodo(int index) async {
    todoList[index] =
        todoList[index].copyWith(isCompleted: !todoList[index].isCompleted);
    _animatedListStateKey.currentState?.setState(() {});
    await _isarService.editTodo(todoList[index]);
  }

  Future<void> deleteTodo(int index) async {
    await _isarService.deleteTodo(todoList[index].id, todoList[index].tid);
    final Todo removedTodo = todoList.removeAt(index);
    _animatedListStateKey.currentState?.removeItem(
      index,
      (context, animation) => TodoListTile(
        todo: removedTodo,
        animation: animation,
        editTodo: () {},
        checkedTodo: () {},
        deleteTodo: () {},
      ),
      duration: const Duration(milliseconds: 1000),
    );
    if (todoList.isEmpty) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Todo List"),
        actions: [
          IconButton(
            tooltip: "Settings",
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsScreen(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Todo",
        onPressed: addTodo,
        child: const Icon(Icons.add),
      ),
      body: (_isLoading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : (todoList.isEmpty)
              ? const Center(
                  child: Text(
                    "No Tasks left ☺",
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : AnimatedList(
                  key: _animatedListStateKey,
                  initialItemCount: todoList.length,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  itemBuilder: (context, index, animation) {
                    return TodoListTile(
                      todo: todoList[index],
                      animation: animation,
                      editTodo: () => editTodo(index),
                      checkedTodo: () => checkedTodo(index),
                      deleteTodo: () => deleteTodo(index),
                    );
                  },
                ),
    );
  }
}
