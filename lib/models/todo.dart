import 'dart:convert';

class Todo {
  final int id;
  final String title;
  final bool isCompleted;
  Todo(this.id, this.title, this.isCompleted);

  factory Todo.fromJson(Map<String, dynamic> map) {
    return Todo(map['id'], map['title'], map['isCompleted']);
  }

  Todo copyWith({int? id, String? title, bool? isCompleted}) {
    return Todo(
      id ?? this.id,
      title ?? this.title,
      isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
