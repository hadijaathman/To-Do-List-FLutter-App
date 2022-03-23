import 'dart:ffi';
import 'dart:io';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return MaterialApp(
      title: 'Hello world',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  // ignore: no_logic_in_create_state
  _MyHomeScreen createState() => _MyHomeScreen();
}

class _MyHomeScreen extends State<MyApp> {
  final List<String> _strings = <String>[];

  late TextEditingController myController = TextEditingController();

  String name = '';

  @override
  void InitState() {
    super.initState();
    myController = TextEditingController();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('To do List'),
          centerTitle: true,
        ),
        body: ListView(children: getItems()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => openDialog(),
          tooltip: "Add item",
          child: Icon(Icons.add),
        ),
      );

  /*Container(
  
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Task:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(name),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                child: const Text('Add a task'),
                onPressed: () async {
                  final name = await openDialog();
                  if (name == null || name.isEmpty) return;

                  setState(() {
                    this.name = name;
                  });
                },
              ),
            ],
          ),
          /*list view builder*/
        ),
      );*/

  Future<String?> openDialog() => showDialog<String>(
      context: this.context,
      builder: (context) => AlertDialog(
              title: const Text('Enter new task'),
              content: Column(children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter your to do task',
                  ),
                  controller: myController,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Task description',
                  ),
                )
              ]),
              actions: [
                TextButton(
                  onPressed: submit,
                  child: const Text('Submit'),
                ),
              ]
              /* TextField(
                autofocus: true,
                decoration:
                    const InputDecoration(hintText: 'Enter your new task...'),
                onSubmitted: (_) => submit(),
                controller: myController,
              ),
              
              actions: [
                TextButton(
                  onPressed: submit,
                  child: const Text('Submit'),
                ),
              ]*/
              ));

  void submit() {
    Navigator.of(context).pop();
    addToDoTask(myController.text);
  }

  void addToDoTask(String title) {
    setState(() {
      _strings.add(title);
    });
    myController.clear();
  }

  List<Widget> getItems() {
    final List<Widget> todoWidgets = <Widget>[];
    for (String title in _strings) {
      todoWidgets.add(_buildTodoItems(title));
    }
    return todoWidgets;
  }

  column(TextField textField, {required List<TextButton> actions}) {}
}

// Generate list of item widgets
Widget _buildTodoItems(String title) {
  return ListTile(title: Text(title));
}
/*_showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Expanded(
        child: AlertDialog(
          title: Text('welcome'),
          content: Text('Do you want to add a to do task?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Yes',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'No',
                style: TextStyle(color: Colors.amber),
              ),
            ),
          ],
        ),
      );
    },
  );
}
*/