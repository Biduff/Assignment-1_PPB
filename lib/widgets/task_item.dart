import 'package:flutter/material.dart';
import '../model/task.dart';

class NotesItem extends StatelessWidget {
  final Notes task;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  NotesItem({required this.task, required this.onDelete, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(task.title),
        subtitle: Text(task.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: Icon(Icons.edit), onPressed: onEdit),
            IconButton(icon: Icon(Icons.delete), onPressed: onDelete),
          ],
        ),
      ),
    );
  }
}
