import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/core/utils/my_colors.dart';
import 'package:todo_application/models/task_model.dart';
import 'package:todo_application/viewmodels/task_viewmodel.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task});

  final TaskModel task;
  // final String? description;

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    final vm = context.read<TaskViewModel>();

    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      height: 100,
      width: mediaSize.width,
      decoration: BoxDecoration(
        color: task.isCompleted
            ? MyColors.completedTaskColor
            : MyColors.inCompleteTaskColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFBDC7D0).withOpacity(0.5),
            offset: const Offset(5, 5),
            blurRadius: 15,
          ),

          const BoxShadow(
            color: Colors.white,
            offset: Offset(-5, -5),
            blurRadius: 15,
          ),
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 14),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // CheckBox to check task is completetd or not
            Transform.scale(
              scale: 1.1,
              child: Checkbox(
                value: task.isCompleted ? true : false,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),

                onChanged: (value) {
                  vm.toggleTask(task);
                },
              ),
            ),

            // Task Title and Description
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 8.0,
                ),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      task.isCompleted
                          ? Text(
                              task.title,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.italic,
                                fontSize: 16,
                                decoration: TextDecoration.lineThrough,
                                decorationThickness: 2,
                              ),
                            )
                          : Text(
                              task.title,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                      Text(
                        task.isCompleted ? 'Completed!' : 'Task Pending...',
                        style: TextStyle(color: Colors.black38, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Delete Task Icon Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: InkWell(
                onTap: () {
                  vm.deleteTask(task.id!);
                },
                child: Icon(
                  Icons.delete_outline_outlined,
                  color: Colors.red,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
