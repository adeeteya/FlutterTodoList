import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_list/models/todo.dart';
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
  final DatabaseService _databaseService = DatabaseService();
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
    todoList = await _databaseService.getTodos();
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
    final String? newTodoTitle = await addTodoDialogBox(context);
    if (newTodoTitle == null) {
      return;
    }
    _animatedListStateKey.currentState?.insertItem(
      todoList.length,
      duration: const Duration(milliseconds: 500),
    );
    if (todoList.isEmpty) {
      Future.delayed(const Duration(milliseconds: 250), () {
        setState(() {});
      });
    }
    todoList.add(Todo(0, newTodoTitle, false));
    final Todo newTodo = await _databaseService.addTodo(newTodoTitle);
    todoList[todoList.length - 1] = newTodo;
  }

  Future<void> editTodo(int index) async {
    String? newTitle = await editTodoDialogBox(context, todoList[index].title);
    if (newTitle == null) {
      return;
    }
    todoList[index] = todoList[index].copyWith(title: newTitle);
    _animatedListStateKey.currentState?.setState(() {});
    await _databaseService.editTodo(todoList[index]);
  }

  Future<void> checkedTodo(int index) async {
    todoList[index] =
        todoList[index].copyWith(isCompleted: !todoList[index].isCompleted);
    _animatedListStateKey.currentState?.setState(() {});
    await _databaseService.editTodo(todoList[index]);
  }

  Future<void> deleteTodo(int index) async {
    _databaseService.deleteTodo(todoList[index].id);
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
            onPressed: () => context.push("/settings"),
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
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Flexible(
                        flex: 10,
                        child: Lottie.asset("assets/todo_done.json"),
                      ),
                      const Text(
                        "All Todos Done",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const Spacer(flex: 5),
                    ],
                  ),
                )
              : Center(
                  child: SizedBox(
                    width: 500,
                    child: AnimatedList(
                      key: _animatedListStateKey,
                      initialItemCount: todoList.length,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
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
                  ),
                ),
    );
  }
}
