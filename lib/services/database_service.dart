import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list/models/settings_data.dart';
import 'package:todo_list/models/todo.dart';

class DatabaseService {
  static late final Isar _isar;
  final SupabaseClient _client = Supabase.instance.client;

  Isar get isar => _isar;

  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([SettingsDataSchema],
        directory: documentsDirectory.path);
  }

  Future<List<Todo>> getTodos() async {
    final List returnedResult = await _client
        .from('Todos')
        .select()
        .eq('pid', _client.auth.currentUser!.id);
    return returnedResult.map((e) => Todo.fromJson(e)).toList();
  }

  Future<Todo> addTodo(String newTodoTitle) async {
    final returnedResult = await _client.from('Todos').insert({
      'title': newTodoTitle,
      'isCompleted': false,
      'pid': _client.auth.currentUser!.id
    }).select();
    return Todo.fromJson(returnedResult[0]);
  }

  Future<void> editTodo(Todo editedTodo) async {
    await _client
        .from('Todos')
        .update(
            editedTodo.toJson()..addAll({'pid': _client.auth.currentUser!.id}))
        .eq('id', editedTodo.id);
  }

  Future<void> deleteTodo(int id) async {
    await _client.from('Todos').delete().eq('id', id);
  }
}
