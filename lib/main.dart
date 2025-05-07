// import 'package:flutter/material.dart';
// import 'models/task_list.dart'; // Import TaskListPage
// import 'models/signup.dart'; // Import SignUpPage
// import 'models/login.dart';
// import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Fetch the environment variables from the .env file
//   const keyApplicationId = 'MihbV1HAiWBrY99DcDpWhtgBPEThdG9LTGYgCmgU';
//   const keyClientKey = 'N6TeyG1kaiKc4AkrAQjUoXCxTGSL2SkupYlIjzEO';
//   const keyParseServerUrl = 'https://parseapi.back4app.com';

//   await Parse().initialize(keyApplicationId, keyParseServerUrl,
//       clientKey: keyClientKey, debug: true);

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Login/Signup',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: LoginPage(),
//       routes: {
//         '/signup': (context) => SignUpPage(),
//         '/tasks': (context) => TaskListPage(),
//         '/login': (context) => LoginPage(),
//       },
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Parse().initialize(
//     'MihbV1HAiWBrY99DcDpWhtgBPEThdG9LTGYgCmgU',
//     'https://parseapi.back4app.com',
//     clientKey: 'N6TeyG1kaiKc4AkrAQjUoXCxTGSL2SkupYlIjzEO',
//     autoSendSessionId: true,
//     debug: true,
//   );
//   runApp(MaterialApp(home: LoginPage()));
// }

// // ------------------- LOGIN PAGE -----------------------
// class LoginPage extends StatelessWidget {
//   final TextEditingController userCtrl = TextEditingController();
//   final TextEditingController passCtrl = TextEditingController();

//   void doLogin(BuildContext context) async {
//     final user = ParseUser(userCtrl.text.trim(), passCtrl.text.trim(), null);
//     final response = await user.login();

//     if (response.success) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => HomePage()),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Login failed: ${response.error?.message}')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Login")),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(controller: userCtrl, decoration: InputDecoration(labelText: "Username")),
//             TextField(controller: passCtrl, obscureText: true, decoration: InputDecoration(labelText: "Password")),
//             SizedBox(height: 20),
//             ElevatedButton(onPressed: () => doLogin(context), child: Text("Login")),
//             TextButton(
//               onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpPage())),
//               child: Text("Don't have an account? Sign Up"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ------------------- SIGNUP PAGE -----------------------
// class SignUpPage extends StatelessWidget {
//   final TextEditingController userCtrl = TextEditingController();
//   final TextEditingController emailCtrl = TextEditingController();
//   final TextEditingController passCtrl = TextEditingController();

//   void doSignUp(BuildContext context) async {
//     final user = ParseUser(
//       userCtrl.text.trim(),
//       passCtrl.text.trim(),
//       emailCtrl.text.trim(),
//     );

//     final response = await user.signUp();

//     if (response.success) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sign up successful! Logging in...")));
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Sign up failed: ${response.error?.message}')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Sign Up")),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(controller: userCtrl, decoration: InputDecoration(labelText: "Username")),
//             TextField(controller: emailCtrl, decoration: InputDecoration(labelText: "Email")),
//             TextField(controller: passCtrl, obscureText: true, decoration: InputDecoration(labelText: "Password")),
//             SizedBox(height: 20),
//             ElevatedButton(onPressed: () => doSignUp(context), child: Text("Sign Up")),
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text("Already have an account? Login"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ------------------- HOME / CRUD PAGE -----------------------
// class HomePage extends StatefulWidget {
//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final TextEditingController nameCtrl = TextEditingController();
//   final TextEditingController ageCtrl = TextEditingController();
//   List<ParseObject> records = [];
//   ParseObject? selected;

//   @override
//   void initState() {
//     super.initState();
//     fetchRecords();
//   }

//   void fetchRecords() async {
//     final query = QueryBuilder(ParseObject('Record'));
//     final response = await query.query();

//     if (response.success && response.results != null) {
//       setState(() => records = response.results as List<ParseObject>);
//     }
//   }

//   void saveRecord() async {
//     final name = nameCtrl.text.trim();
//     final ageText = ageCtrl.text.trim();

//     if (name.isEmpty || ageText.isEmpty || int.tryParse(ageText) == null) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter valid Name and Age (number).")));
//       return;
//     }

//     final age = int.parse(ageText);
//     final obj = selected ?? ParseObject('Record');
//     obj.set('name', name);
//     obj.set('age', age);

//     final response = await obj.save();
//     if (response.success) {
//       nameCtrl.clear();
//       ageCtrl.clear();
//       selected = null;
//       fetchRecords();
//     }
//   }

//   void deleteRecord(ParseObject obj) async {
//     final response = await obj.delete();
//     if (response.success) fetchRecords();
//   }

//   void selectForEdit(ParseObject obj) {
//     nameCtrl.text = obj.get<String>('name') ?? '';
//     ageCtrl.text = obj.get<int>('age')?.toString() ?? '';
//     selected = obj;
//   }

//   void logout() async {
//     final user = await ParseUser.currentUser() as ParseUser?;
//     if (user != null) {
//       await user.logout();
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("CRUD App"),
//         actions: [IconButton(onPressed: logout, icon: Icon(Icons.logout))],
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(controller: nameCtrl, decoration: InputDecoration(labelText: "Name")),
//             TextField(
//               controller: ageCtrl,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: "Age"),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                     onPressed: saveRecord,
//                     child: Text(selected == null ? "Add Record" : "Update Record")),
//                 if (selected != null)
//                   TextButton(
//                     onPressed: () {
//                       nameCtrl.clear();
//                       ageCtrl.clear();
//                       setState(() => selected = null);
//                     },
//                     child: Text("Cancel"),
//                   ),
//               ],
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: records.length,
//                 itemBuilder: (_, i) {
//                   final item = records[i];
//                   final name = item.get<String>('name') ?? '';
//                   final age = item.get<int>('age') ?? 0;
//                   return ListTile(
//                     title: Text("$name, $age years"),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(icon: Icon(Icons.edit), onPressed: () => selectForEdit(item)),
//                         IconButton(icon: Icon(Icons.delete), onPressed: () => deleteRecord(item)),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'models/login.dart';
import 'models/signup.dart';
import 'models/crud_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the Parse Server
  await Parse().initialize(
    'MihbV1HAiWBrY99DcDpWhtgBPEThdG9LTGYgCmgU',  // Application ID
    'https://parseapi.back4app.com',  // Parse Server URL
    clientKey: 'N6TeyG1kaiKc4AkrAQjUoXCxTGSL2SkupYlIjzEO',  // Client Key
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
