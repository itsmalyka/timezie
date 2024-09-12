import 'package:flutter/material.dart';
import 'databaseHelper.dart';
import 'package:timezie/models/noteModel.dart';
import 'package:path_provider/path_provider.dart';

class taskProvider with ChangeNotifier {
  List<notemodel> _tasks = [];

  List<notemodel> get tasks => _tasks;

  Future<void> loadTasks() async {
    final tasks = await DatabaseHelper().getNotes();
    _tasks = tasks;
    notifyListeners();
  }
  Future<void> removeTask(notemodel task) async {
    await DatabaseHelper().deleteNote(task.id!);
    _tasks.removeWhere((t) => t.id == task.id);
    notifyListeners();
  }
}
