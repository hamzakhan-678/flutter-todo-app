import 'package:todo_application/core/database/database_helper.dart';
import 'package:todo_application/models/task_model.dart';

class TaskService {
  final dbHelper = DatabaseHelper.instance;

  Future<void> insertTask(TaskModel task) async {
    final db = await dbHelper.database;
    await db.insert('tasks', task.toMap());
  }

  Future<List<TaskModel>> getTasks() async {
    final db = await dbHelper.database;
    final maps = await db.query('tasks');

    return maps.map((element) => TaskModel.fromMap(element)).toList();
  }

  Future<void> updateTask(TaskModel task) async {
    final db = await dbHelper.database;
    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(int id) async {
    final db = await dbHelper.database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
