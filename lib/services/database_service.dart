import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_list/models/settings_data.dart';
import 'package:todo_list/models/todo.dart';

class DatabaseService {
  static late final Isar _isar;

  Isar get isar => _isar;

  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([TodoSchema, SettingsDataSchema],
        directory: documentsDirectory.path);
  }

  Future<List<Todo>> getTodos() async {
    return await _isar.todos.where().findAll();
  }

  Future addTodo(Todo newTodo) async {
    await DatabaseService().isar.writeTxn(() async {
      await DatabaseService().isar.todos.put(newTodo);
    });
  }

  Future editTodo(Todo editedTodo) async {
    await DatabaseService().isar.writeTxn(() async {
      await DatabaseService().isar.todos.put(editedTodo);
    });
  }

  Future deleteTodo(int id) async {
    await DatabaseService().isar.writeTxn(() async {
      await DatabaseService().isar.todos.delete(id);
    });
  }
}
