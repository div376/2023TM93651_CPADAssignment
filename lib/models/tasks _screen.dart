import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<ParseObject> tasks = [];

  @override
  void initState() {
    super.initState();
    // We will fetch data here later
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              await ParseUser.currentUser()?.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome! You are logged in. We will display tasks here.'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // We will implement the create task dialog here
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}