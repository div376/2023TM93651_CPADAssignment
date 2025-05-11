import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController _usernameCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();

  void _showSnackbar(BuildContext context, String message, {bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.redAccent : Colors.green,
      ),
    );
  }

  Future<void> _doSignUp(BuildContext context) async {
    final username = _usernameCtrl.text.trim();
    final password = _passwordCtrl.text.trim();
    final email = _emailCtrl.text.trim();

    if (username.isEmpty || password.isEmpty || email.isEmpty) {
      _showSnackbar(context, "Please fill all fields.", error: true);
      return;
    }

    final user = ParseUser(username, password, email);
    final response = await user.signUp();

    if (response.success) {
      _showSnackbar(context, "Sign up successful!");
      Navigator.pushReplacementNamed(context, '/');
    } else {
      _showSnackbar(context, "Sign up failed: ${response.error?.message}", error: true);
    }
  }

  Widget _inputField(TextEditingController controller, String label, IconData icon,
      {bool isPassword = false}) {
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
        title: const Text("Create Account"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(Icons.app_registration, size: 80, color: Colors.blueAccent),
            const SizedBox(height: 24),
            _inputField(_emailCtrl, "Email", Icons.email),
            const SizedBox(height: 16),
            _inputField(_usernameCtrl, "Username", Icons.person),
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
                onPressed: () => _doSignUp(context),
                child: const Text("Sign Up", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}