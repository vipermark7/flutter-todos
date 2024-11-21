import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../services/database_service.dart';

class TodoProvider with ChangeNotifier {
  List<TodoModel> _todos = [];
  final DatabaseService _databaseService = DatabaseService();

  List<TodoModel> get todos => _todos;

  Future<void> fetchTodos() async {
    _todos = await _databaseService.getTodos();
    notifyListeners();
  }

  Future<void> addTodo(TodoModel todo) async {
    await _databaseService.insertTodo(todo);
    await fetchTodos();
  }

  Future<void> updateTodo(TodoModel todo) async {
    await _databaseService.updateTodo(todo);
    await fetchTodos();
  }

  Future<void> deleteTodo(int id) async {
    await _databaseService.deleteTodo(id);
    await fetchTodos();
  }
}
