import 'package:flutter/material.dart';
import 'models/task_list.dart'; // Import TaskListPage
import 'models/signup.dart'; // Import SignUpPage
import 'models/login.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Fetch the environment variables from the .env file
  const keyApplicationId = 'MihbV1HAiWBrY99DcDpWhtgBPEThdG9LTGYgCmgU';
  const keyClientKey = 'N6TeyG1kaiKc4AkrAQjUoXCxTGSL2SkupYlIjzEO';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, debug: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login/Signup',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      routes: {
        '/signup': (context) => SignUpPage(),
        '/tasks': (context) => TaskListPage(),
        '/login': (context) => LoginPage(),
      },
    );
  }
}
