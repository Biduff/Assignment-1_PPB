import 'package:flutter/material.dart';
import '../model/task.dart';
import 'widgets/task_item.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Assignment 1 : CRUD',
      home: TaskScreen(),
    );
  }
}

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Notes> tasks = [];

  void _addTask(String title, String description) {
    setState(() {
      tasks.add(Notes(id: Random().nextInt(1000).toString(), title: title, description: description));
    });
  }

  void _editTask(String id, String newTitle, String newDescription) {
    setState(() {
      int index = tasks.indexWhere((task) => task.id == id);
      if (index != -1) {
        tasks[index] = Notes(id: id, title: newTitle, description: newDescription);
      }
    });
  }

  void _deleteTask(String id) {
    setState(() {
      tasks.removeWhere((task) => task.id == id);
    });
  }

  void _showTaskDialog({Notes? task}) {
    final titleController = TextEditingController(text: task?.title ?? '');
    final descController = TextEditingController(text: task?.description ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(task == null ? 'Add Task' : 'Edit Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: InputDecoration(labelText: 'Title')),
            TextField(controller: descController, decoration: InputDecoration(labelText: 'Description')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (task == null) {
                _addTask(titleController.text, descController.text);
              } else {
                _editTask(task.id, titleController.text, descController.text);
              }
              Navigator.of(context).pop();
            },
            child: Text(task == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notes')),
      body: tasks.isEmpty
          ? Center(child: Text('No notes yet!'))
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return NotesItem(
            task: tasks[index],
            onDelete: () => _deleteTask(tasks[index].id),
            onEdit: () => _showTaskDialog(task: tasks[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.orangeAccent,
        onPressed: () => _showTaskDialog(),
      ),
    );
  }
}
