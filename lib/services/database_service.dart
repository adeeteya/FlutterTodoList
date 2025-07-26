import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list/models/todo.dart';

class DatabaseService {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<List<Todo>> getTodos() async {
    final querySnapshot = await _instance
        .collection('Todos')
        .where('uid', isEqualTo: _firebaseAuth.currentUser?.uid)
        .get(const GetOptions());
    return querySnapshot.docs
        .map((e) => Todo.fromMap(e.data()..addAll({'id': e.id})))
        .toList();
  }

  Future<Todo> addTodo(String newTodoTitle) async {
    final newTodo = <String, dynamic>{
      'title': newTodoTitle,
      'isCompleted': false,
      'uid': _firebaseAuth.currentUser?.uid,
    };
    final documentReference = await _instance.collection('Todos').add(newTodo);
    return Todo.fromMap(newTodo..addAll({'id': documentReference.id}));
  }

  Future<void> editTodo(Todo editedTodo) async {
    await _instance
        .collection('Todos')
        .doc(editedTodo.id)
        .update(editedTodo.toMap());
  }

  Future<void> deleteTodo(String id) async {
    await _instance.collection('Todos').doc(id).delete();
  }
}
