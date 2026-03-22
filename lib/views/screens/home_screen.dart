import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/core/utils/my_colors.dart';
import 'package:todo_application/viewmodels/task_viewmodel.dart';
import 'package:todo_application/views/widgets/task_tile.dart';
import 'package:todo_application/views/widgets/total_task_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<TaskViewModel>().fetchTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TaskViewModel>();
    var mediaSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text("Todo List")),
      backgroundColor: MyColors.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),

              // Container to display total number of tasks in the List
              child: TotalTaskCard(
                title: 'Total Task',
                taskCounter: vm.tasks.length,
              ),
            ),

            SizedBox(height: mediaSize.height * 0.03),

            // List of Tasks
            Expanded(
              // Expanded Container to show List of Tasks
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),

                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 8.0,
                  ),

                  child: Column(
                    children: [
                      // Small Horizontal Line above the List
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 5.0, bottom: 12.0),
                          height: 5,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),

                      // List of Task-Tiles
                      Expanded(
                        child: vm.isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: MyColors.primaryColor,
                                  strokeWidth: 2,
                                ),
                              )
                            : vm.tasks.isEmpty
                            ? const Center(
                                child: Text(
                                  'No Tasks Added!',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.only(top: 8),
                                itemCount: vm.tasks.length,
                                itemBuilder: (context, index) {
                                  return TaskTile(task: vm.tasks[index]);
                                },
                              ),
                      ),

                      // Divider
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Divider(indent: 30, endIndent: 30),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Controller to capture the text inside the dialog
          final TextEditingController taskController = TextEditingController();

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text("New Task"),
              content: TextField(
                controller: taskController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "What needs to be done?",
                  border: UnderlineInputBorder(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (taskController.text.trim().isNotEmpty) {
                      // Call your ViewModel to add the task
                      vm.addTask(taskController.text.trim());
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
          );
        },
        backgroundColor: MyColors.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
