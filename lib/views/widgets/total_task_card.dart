import 'package:flutter/material.dart';
import 'package:todo_application/core/utils/my_colors.dart';

class TotalTaskCard extends StatefulWidget {
  const TotalTaskCard({
    super.key,
    required this.title,
    required this.taskCounter,
  });

  final String title;
  final int taskCounter;

  @override
  State<TotalTaskCard> createState() => _TotalTaskCardState();
}

class _TotalTaskCardState extends State<TotalTaskCard> {
  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;

    return Container(
      width: mediaSize.width,
      height: mediaSize.height * 0.12,
      decoration: BoxDecoration(
        color: MyColors.secondaryColor, // Your 0xFFe8f5fe color
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            // Deep blue tint for a natural look on a light blue surface
            color: const Color(0xFF0D47A1).withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 1,
            offset: const Offset(
              0,
              8,
            ), // Moves shadow down for a "floating" effect
          ),
        ],
      ),

      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.title.toString(),
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              widget.taskCounter.toString(),
              style: const TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
