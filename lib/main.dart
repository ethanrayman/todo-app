import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-do',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.lightBlue,
      ),
      home: const TaskList(title: 'To-do'),
    );
  }
}

class TaskList extends StatefulWidget {
  const TaskList({super.key, required this.title});

  final String title;

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task> tasks = [];
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TaskColor tiles = new TaskColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task List"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              //padding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, index) {
                Task task = tasks[index];
                return ListTile(
                  title: Text(task.name),
                  subtitle: Text("${task.date} at ${task.time}"),
                  tileColor: tiles.select(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _showEditTaskDialog(task);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            tasks.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showNewTaskDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  void _showNewTaskDialog() {
    nameController.clear();
    dateController.clear();
    timeController.clear();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("New Task"),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Task name",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a name for the task.";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: dateController,
                  decoration: InputDecoration(
                    labelText: "Due date",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a date for the task.";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: timeController,
                  decoration: InputDecoration(
                    labelText: "Due time",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a time for the task.";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    tasks.add(Task(
                      name: nameController.text,
                      date: dateController.text,
                      time: timeController.text,
                    ));
                    Navigator.of(context).pop();
                  });
                }
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _showEditTaskDialog(Task task) {
    nameController.text = task.name;
    dateController.text = task.date;
    timeController.text = task.time;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Task"),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Task name",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a name for the task.";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: dateController,
                  decoration: InputDecoration(
                    labelText: "Due date",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a name for the task.";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: timeController,
                  decoration: InputDecoration(
                    labelText: "Due time",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a name for the task.";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    task.name = nameController.text;
                    task.date = dateController.text;
                    task.time = timeController.text;
                    Navigator.of(context).pop();
                  });
                }
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }
}

class Task {
  String name;
  String date;
  String time;

  Task({required this.name, required this.date, required this.time});
}

class TaskColor {
  static int count = 0;

  Color select() {
    count++;
    if (count % 2 == 1) {
      return Color.fromARGB(255, 192, 192, 192);
    } else {
      return Color.fromARGB(255, 103, 103, 103);
    }
  }
}
