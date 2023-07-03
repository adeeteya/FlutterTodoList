import 'package:isar/isar.dart';

part 'todo.g.dart';

@collection
class Todo {
  Id id;
  final String title;
  final bool isCompleted;
  Todo(this.title, this.isCompleted, {this.id = Isar.autoIncrement});

  Todo copyWith({String? title, bool? isCompleted}) {
    return Todo(title ?? this.title, isCompleted ?? this.isCompleted, id: id);
  }
}
