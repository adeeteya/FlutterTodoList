import 'package:isar/isar.dart';

part 'todo.g.dart';

@collection
class Todo {
  final Id id;
  final int tid;
  final String title;
  final bool isCompleted;
  Todo(this.title, this.isCompleted,
      {this.id = Isar.autoIncrement, this.tid = 0});

  Todo copyWith({String? title, bool? isCompleted, int? tid}) {
    return Todo(title ?? this.title, isCompleted ?? this.isCompleted,
        id: id, tid: tid ?? this.tid);
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(json['title'], json['isCompleted'], tid: json['id']);
  }

  Map<String, String> toJson() {
    return {'title': title, 'isCompleted': isCompleted.toString()};
  }
}
