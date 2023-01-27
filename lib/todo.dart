import 'package:isar/isar.dart';

part 'todo.g.dart';

@collection
class Todo {
  Id id = Isar.autoIncrement;
  String title;
  Todo(this.title);
}
