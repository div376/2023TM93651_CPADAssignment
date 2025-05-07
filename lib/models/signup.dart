// // import 'package:flutter/material.dart';
// // import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();

// //   // Fetch the environment variables from the .env file
// //   const keyApplicationId = 'your back4appid';
// //   const keyClientKey = 'your back4app client key';
// //   const keyParseServerUrl = 'https://parseapi.back4app.com';

// //   await Parse().initialize(keyApplicationId, keyParseServerUrl,
// //       clientKey: keyClientKey, debug: true);

// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       home: SignUpPage(),
// //     );
// //   }
// // }

// // class SignUpPage extends StatefulWidget {
// //   @override
// //   _SignUpPageState createState() => _SignUpPageState();
// // }

// // class _SignUpPageState extends State<SignUpPage> {
// //   final controllerUsername = TextEditingController();
// //   final controllerPassword = TextEditingController();
// //   final controllerEmail = TextEditingController();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Flutter SignUp'),
// //       ),
// //       body: Center(
// //         child: SingleChildScrollView(
// //           padding: const EdgeInsets.all(16),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.stretch,
// //             children: [
// //               Container(
// //                 height: 200,
// //                 child: Image.network(
// //                   'https://blog.back4app.com/wp-content/uploads/2017/11/logo-b4a-1-768x175-1.png',
// //                 ),
// //               ),
// //               const SizedBox(height: 16),
// //               const Text(
// //                 'Flutter on Back4App',
// //                 textAlign: TextAlign.center,
// //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //               ),
// //               const SizedBox(height: 8),
// //               const Text(
// //                 'User registration',
// //                 textAlign: TextAlign.center,
// //                 style: TextStyle(fontSize: 16),
// //               ),
// //               const SizedBox(height: 16),
// //               TextField(
// //                 controller: controllerUsername,
// //                 keyboardType: TextInputType.text,
// //                 textCapitalization: TextCapitalization.none,
// //                 autocorrect: false,
// //                 decoration: const InputDecoration(
// //                   border: OutlineInputBorder(),
// //                   labelText: 'Username',
// //                 ),
// //               ),
// //               const SizedBox(height: 8),
// //               TextField(
// //                 controller: controllerEmail,
// //                 keyboardType: TextInputType.emailAddress,
// //                 textCapitalization: TextCapitalization.none,
// //                 autocorrect: false,
// //                 decoration: const InputDecoration(
// //                   border: OutlineInputBorder(),
// //                   labelText: 'E-mail',
// //                 ),
// //               ),
// //               const SizedBox(height: 8),
// //               TextField(
// //                 controller: controllerPassword,
// //                 obscureText: true,
// //                 keyboardType: TextInputType.text,
// //                 textCapitalization: TextCapitalization.none,
// //                 autocorrect: false,
// //                 decoration: const InputDecoration(
// //                   border: OutlineInputBorder(),
// //                   labelText: 'Password',
// //                 ),
// //               ),
// //               const SizedBox(height: 16),
// //               Container(
// //                 height: 50,
// //                 child: TextButton(
// //                   style: TextButton.styleFrom(
// //                     foregroundColor: Colors.white,
// //                     backgroundColor: Colors.blue,
// //                   ),
// //                   child: const Text('Sign Up'),
// //                   onPressed: () => doUserRegistration(),
// //                 ),
// //               ),
// //               const SizedBox(height: 16),
// //               TextButton(
// //                 onPressed: () {
// //                   Navigator.pushNamed(context, '/login');
// //                 },
// //                 child: const Text('Already have an account? Login'),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   void showSuccess() {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: const Text("Success!"),
// //           content: const Text("User was successfully created!"),
// //           actions: <Widget>[
// //             TextButton(
// //               child: const Text("OK"),
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //               },
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   void showError(String errorMessage) {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: const Text("Error!"),
// //           content: Text(errorMessage),
// //           actions: <Widget>[
// //             TextButton(
// //               child: const Text("OK"),
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //               },
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// // //   void doUserRegistration() async {
// // //     final username = controllerUsername.text.trim();
// // //     final password = controllerPassword.text.trim();
// // //     final email = controllerEmail.text.trim();

// // //     if (username.isEmpty || password.isEmpty || email.isEmpty) {
// // //       showError("Please fill all fields.");
// // //       return;
// // //     }

// // //     final user = ParseUser(username, password, email);

// // //     var response = await user.signUp();
// // //     if (response.success) {
// // //       showSuccess();
// // //     } else {
// // //       showError(response.error?.message ?? "An error occurred.");
// // //     }
// // //   }

// //   void doUserRegistration() async {
// //     final username = controllerUsername.text.trim();
// //     final email = controllerEmail.text.trim();
// //     final password = controllerPassword.text.trim();

// //     final user = ParseUser.createUser(username, password, email);

// //     var response = await user.signUp();

// //     if (response.success) {
// //       showSuccess();
// //     } else {
// //       showError(response.error!.message);
// //     }
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

// class SignUpPage extends StatelessWidget {
//   final TextEditingController userCtrl = TextEditingController();
//   final TextEditingController passCtrl = TextEditingController();
//   final TextEditingController emailCtrl = TextEditingController(); // Added email controller

//   void doSignUp(BuildContext context) async {
//     final username = userCtrl.text.trim();
//     final password = passCtrl.text.trim();
//     final email = emailCtrl.text.trim();

//     if (username.isEmpty || password.isEmpty || email.isEmpty) {
//       // Validate fields
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill all fields.")));
//       return;
//     }

//     final user = ParseUser(username, password, email);
//     final response = await user.signUp();

//     if (response.success) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sign up successful!")));
//       Navigator.pushReplacementNamed(context, '/');  // Navigate to home page
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
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Added email field
//             TextField(
//               controller: emailCtrl,
//               decoration: InputDecoration(labelText: "Email"),
//               keyboardType: TextInputType.emailAddress,
//             ),
//             TextField(
//               controller: userCtrl,
//               decoration: InputDecoration(labelText: "Username"),
//             ),
//             TextField(
//               controller: passCtrl,
//               obscureText: true,
//               decoration: InputDecoration(labelText: "Password"),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => doSignUp(context),
//               child: Text("Sign Up"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController userCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();

  void doSignUp(BuildContext context) async {
    final username = userCtrl.text.trim();
    final password = passCtrl.text.trim();
    final email = emailCtrl.text.trim();

    if (username.isEmpty || password.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill all fields.")));
      return;
    }

    final user = ParseUser(username, password, email);
    final response = await user.signUp();

    if (response.success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sign up successful!")));
      Navigator.pushReplacementNamed(context, '/');  // Navigate to home page
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign up failed: ${response.error?.message}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Sign Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.email),
                filled: true,
                fillColor: Colors.white,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: userCtrl,
              decoration: const InputDecoration(
                labelText: "Username",
                prefixIcon: Icon(Icons.person),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                prefixIcon: Icon(Icons.lock),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () => doSignUp(context),
              child: const Text("Sign Up", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
