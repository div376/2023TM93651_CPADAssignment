import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  void _showMessage(String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(title, style: const TextStyle(color: Colors.redAccent)),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK")),
        ],
      ),
    );
  }

  Future<void> _doLogin() async {
    final username = _usernameCtrl.text.trim();
    final password = _passwordCtrl.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showMessage("Missing Info", "Please fill in all fields.");
      return;
    }

    final user = ParseUser(username, password, null);
    final response = await user.login();

    if (response.success) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      _showMessage("Login Failed", response.error?.message ?? "Something went wrong.");
    }
  }

  Future<void> _resetPassword() async {
    final email = _usernameCtrl.text.trim();

    if (email.isEmpty) {
      _showMessage("Missing Email", "Please enter your email address.");
      return;
    }

    final user = ParseUser(null, null, email);  // Only email required for reset
    final response = await user.requestPasswordReset();

    if (response.success) {
      _showMessage("Password Reset", "A password reset link has been sent to your email.");
    } else {
      _showMessage("Error", response.error?.message ?? "Failed to send password reset email.");
    }
  }

  Widget _inputField(TextEditingController controller, String label, IconData icon, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Welcome Back"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Image.network(
                'https://blog.back4app.com/wp-content/uploads/2017/11/logo-b4a-1-768x175-1.png',
                height: 120,
              ),
              const SizedBox(height: 32),
              _inputField(_usernameCtrl, "Username or Email", Icons.person),
              const SizedBox(height: 16),
              _inputField(_passwordCtrl, "Password", Icons.lock, isPassword: true),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _doLogin,
                  child: const Text("Login", style: TextStyle(fontSize: 18)),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/signup'),
                child: const Text("Don't have an account? Sign Up"),
              ),
              TextButton(
                onPressed: _resetPassword,
                child: const Text("Forgot Password?"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}