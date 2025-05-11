import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'models/login.dart';
import 'models/signup.dart';
import 'models/crud_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the Parse Server
  await Parse().initialize(
    'U5ulL17glnSyP2yT8Em2TJFpnNSD7X0wiiLqz7XH',  // Application ID
    'https://parseapi.back4app.com',  // Parse Server URL
    clientKey: 'DVFSeRyveqp0uffRe8yporCm8ipIbPlqkg5Ja8K1',  // Client Key
    autoSendSessionId: true,
    debug: true,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Signup CRUD',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => CRUDPage(),
      },
    );
  }
}
