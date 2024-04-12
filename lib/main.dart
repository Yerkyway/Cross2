import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Student {
  final int id;
  final String name;
  final String group;

  const Student({required this.id, required this.name, required this.group});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ListPage(key: Key('list_page_key')),
    );
  }
}

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  ListPageState createState() => ListPageState();
}

class ListPageState extends State<ListPage> {
  final List<Student> students = [];

  void addStudent(int id, String name, String group) {
    setState(() {
      students.add(Student(id: id, name: name, group: group));
    });
  }


  void updateStudent(int index, int id, String name, String group) {
    setState(() {
      students[index] = Student(id: id, name: name, group: group);
    });
  }


  void deleteStudent(int id) {
    setState(() {
      students.removeWhere((student) => student.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List App'),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${students[index].id}: ${students[index].name}'),
            subtitle: Text(students[index].group),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _showUpdateModal(context, index);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _showDeleteConfirmation(context, students[index].id);
                  },
                ),
              ],
            ),
            onTap: () {
              // Do nothing on tap
            },
            onLongPress: () {
              // Do nothing on long press
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddModal(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }


  void _showAddModal(BuildContext context) {
    final TextEditingController idController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController groupController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Student'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: idController,
                decoration: const InputDecoration(labelText: 'ID'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: groupController,
                decoration: const InputDecoration(labelText: 'Group'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final int id = int.tryParse(idController.text) ?? 0;
                final String name = nameController.text;
                final String group = groupController.text;

                addStudent(id, name, group);
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showUpdateModal(BuildContext context, int index) {
    final TextEditingController idController =
    TextEditingController(text: students[index].id.toString());
    final TextEditingController nameController =
    TextEditingController(text: students[index].name);
    final TextEditingController groupController =
    TextEditingController(text: students[index].group);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Student'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: idController,
                decoration: const InputDecoration(labelText: 'ID'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: groupController,
                decoration: const InputDecoration(labelText: 'Group'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final int id = int.tryParse(idController.text) ?? 0;
                final String name = nameController.text;
                final String group = groupController.text;

                updateStudent(index, id, name, group);
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }


  void _showDeleteConfirmation(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Student'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Are you sure you want to delete this student?'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                deleteStudent(id);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
