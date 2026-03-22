import 'package:flutter/material.dart';
import 'package:todo_application/viewmodels/task_viewmodel.dart';
import 'package:todo_application/views/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => TaskViewModel())],
      child: MaterialApp(
        title: 'TODO App',
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          useMaterial3: true,

          colorScheme: .fromSeed(seedColor: Colors.deepPurple),

          appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        home: HomeScreen(),
      ),
    );
  }
}
