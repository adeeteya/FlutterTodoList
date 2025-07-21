import 'dart:convert';

class Todo {
  final String id;
  final String title;
  final bool isCompleted;
  Todo(this.id, this.title, this.isCompleted);

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(map['id'], map['title'], map['isCompleted']);
  }

  Todo copyWith({String? id, String? title, bool? isCompleted}) {
    return Todo(
      id ?? this.id,
      title ?? this.title,
      isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {'title': title, 'isCompleted': isCompleted};
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  @override
  bool operator ==(Object other) {
    return other is Todo &&
        other.id == id &&
        other.title == title &&
        other.isCompleted == isCompleted;
  }

  @override
  int get hashCode => Object.hash(id, title, isCompleted);

  @override
  String toString() {
    return 'Todo{id: $id, title: $title, isCompleted: $isCompleted}';
  }
}
