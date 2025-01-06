import 'package:flutter/material.dart';

class AnimatedCourseTile extends StatelessWidget {
  final String courseName;
  final String grade;
  final String creditHour;
  final VoidCallback onDelete;
  final int index;

  const AnimatedCourseTile({
    super.key,
    required this.courseName,
    required this.grade,
    required this.creditHour,
    required this.onDelete,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      child: ListTile(
        title: Text(
          '${index + 1}. $courseName',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Grade: $grade | Credit: $creditHour'),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
