import 'package:flutter/foundation.dart';
import 'package:todo_application/models/task_model.dart';
import 'package:todo_application/services/task_service.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskService _service = TaskService();

  List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;

  bool isLoading = false;

  Future<void> fetchTasks() async {
    isLoading = true;
    notifyListeners();

    _tasks = await _service.getTasks();

    isLoading = false;
    notifyListeners();
  }

  Future<void> addTask(String title) async {
    TaskModel task = TaskModel(title: title);
    await _service.insertTask(task);
    await fetchTasks();
  }

  Future<void> toggleTask(TaskModel task) async {
    final updated = TaskModel(
      id: task.id,
      title: task.title,
      isCompleted: !task.isCompleted,
    );

    await _service.updateTask(updated);
    await fetchTasks();
  }

  Future<void> updateTaskTitle(TaskModel task, String newTitle) async {
    final updated = TaskModel(
      id: task.id,
      title: newTitle,
      isCompleted: task.isCompleted,
    );

    await _service.updateTask(updated);
    await fetchTasks();
  }

  Future<void> deleteTask(int id) async {
    await _service.deleteTask(id);
    await fetchTasks();
  }
}
