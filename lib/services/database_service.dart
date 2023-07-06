import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list/controllers/settings_controller.dart';
import 'package:todo_list/models/settings_data.dart';
import 'package:todo_list/models/todo.dart';

class DatabaseService {
  static late final Isar _isar;
  final SupabaseClient _client = Supabase.instance.client;

  Isar get isar => _isar;

  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([TodoSchema, SettingsDataSchema],
        directory: documentsDirectory.path);
  }

  Future<List<Todo>> getTodos() async {
    try {
      final DateTime onlineLastUpdated = await _client
          .from('profiles')
          .select('updated_at')
          .eq('id', _client.auth.currentUser!.id);
      final SettingsData? settingsData = await _isar.settingsDatas.get(0);
      if (settingsData != null) {
        List<Todo> latestTodoList = [];
        if (onlineLastUpdated
                .difference(settingsData.lastUpdatedDate)
                .inSeconds >
            30) {
          latestTodoList = await _client
              .from('Todos')
              .select()
              .eq('pid', _client.auth.currentUser!.id);
          await _isar.todos.clear();
          await _isar.todos.putAll(latestTodoList);
          return latestTodoList;
        } else if (onlineLastUpdated
                .difference(settingsData.lastUpdatedDate)
                .inSeconds <
            -30) {
          latestTodoList = await _isar.todos.where().findAll();
          await _client
              .from('Todos')
              .delete()
              .eq("pid", _client.auth.currentUser!.id);
          for (int i = 0; i < latestTodoList.length; i++) {
            await _client.from('Todos').insert(latestTodoList[i].toJson()
              ..addAll({'pid': _client.auth.currentUser!.id}));
          }
        }
        return await _isar.todos.where().findAll();
      } else {
        final List<Todo> latestTodoList = await _client
            .from('Todos')
            .select()
            .eq('pid', _client.auth.currentUser!.id);
        await _isar.todos.putAll(latestTodoList);
        return latestTodoList;
      }
    } catch (e) {
      return await _isar.todos.where().findAll();
    }
  }

  Future<void> updateLastUpdatedTime() async {
    try {
      final profileData = await _client
          .from('profiles')
          .update({'updated_at': 'now()'})
          .eq('id', _client.auth.currentUser!.id)
          .select();
      final updatedDate = DateTime.parse(profileData[0]['updated_at']);
      await SettingsNotifier().updateLastModifiedTime(updatedDate);
    } catch (e) {
      await SettingsNotifier().updateLastModifiedTime(DateTime.now());
    }
  }

  Future addTodo(Todo newTodo) async {
    await DatabaseService().isar.writeTxn(() async {
      await DatabaseService().isar.todos.put(newTodo);
    });
    await _client.from('Todos').insert(
        newTodo.toJson()..addAll({'pid': _client.auth.currentUser!.id}));
    await updateLastUpdatedTime();
  }

  Future editTodo(Todo editedTodo) async {
    await DatabaseService().isar.writeTxn(() async {
      await DatabaseService().isar.todos.put(editedTodo);
    });
    await _client
        .from('Todos')
        .update(
            editedTodo.toJson()..addAll({'pid': _client.auth.currentUser!.id}))
        .eq('id', editedTodo.tid);
    await updateLastUpdatedTime();
  }

  Future deleteTodo(int id, int tid) async {
    await DatabaseService().isar.writeTxn(() async {
      await DatabaseService().isar.todos.delete(id);
    });
    await _client.from('Todos').delete().eq('id', tid);
    await updateLastUpdatedTime();
  }

  Future deleteAllLocalTodos() async {
    await DatabaseService().isar.writeTxn(() async {
      await DatabaseService().isar.todos.clear();
    });
  }
}
