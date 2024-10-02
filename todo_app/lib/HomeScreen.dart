import 'package:flutter/material.dart';
import 'Model/TaskModel.dart';
import 'Repo/TaskRepo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskRepository _taskRepository = TaskRepository();
  List<TaskModel> _tasks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _tasks = await _taskRepository.getTasks();
    } catch (e) {
      print(e); // Handle the error (you can show a Snackbar or alert dialog)
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _addTask(String content) async {
    final newTask = TaskModel(content: content, isCompleted: false);
    try {
      final createdTask = await _taskRepository.createTask(newTask);
      setState(() {
        _tasks.add(createdTask);
      });
    } catch (e) {
      print(e); // Handle the error
    }
  }

  Future<void> _deleteTask(String id) async {
    try {
      await _taskRepository.deleteTask(id);
      setState(() {
        _tasks.removeWhere((task) => task.id == id);
      });
    } catch (e) {
      print(e); // Handle the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'To Do List',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return ListTile(
            title: Text(task.content ?? ''),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteTask(task.id!),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTaskContent = await _showAddTaskDialog(context);
          if (newTaskContent != null && newTaskContent.isNotEmpty) {
            _addTask(newTaskContent);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<String?> _showAddTaskDialog(BuildContext context) {
    String? taskContent;
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Task'),
          content: TextField(
            onChanged: (value) {
              taskContent = value;
            },
            decoration: const InputDecoration(hintText: 'Enter task content'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(taskContent);
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
