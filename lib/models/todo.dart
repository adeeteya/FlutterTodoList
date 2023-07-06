class Todo {
  final int id;
  final String title;
  final bool isCompleted;
  Todo(this.id, this.title, this.isCompleted);

  Todo copyWith({int? id, String? title, bool? isCompleted}) {
    return Todo(
        id ?? this.id, title ?? this.title, isCompleted ?? this.isCompleted);
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(json['id'], json['title'], json['isCompleted']);
  }

  Map<String, String> toJson() {
    return {'title': title, 'isCompleted': isCompleted.toString()};
  }
}
