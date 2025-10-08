import 'package:flutter/material.dart';
import 'purchase.dart';
import 'register.dart';
import 'index.dart'; // Import your index.dart

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _darkMode = false;
  bool _isLoggedIn = false;

  final String correctEmail = 'vinsara@gmail.com';
  final String correctPassword = '123456';

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 1));
      setState(() => _isLoading = false);

      if (_emailController.text == correctEmail &&
          _passwordController.text == correctPassword) {
        setState(() => _isLoggedIn = true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login Successful')),
        );
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const PurchaseScreen()),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid Email or Password')),
        );
      }
    }
  }

  void _logout() {
    setState(() {
      _isLoggedIn = false;
      _emailController.clear();
      _passwordController.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logged out successfully')),
    );
  }

  void _goToIndex() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()), // Navigate to IndexScreen
    );
  }

  @override
  Widget build(BuildContext context) {
    Color bgColor = _darkMode ? Colors.black : const Color(0xFF1a1a1a);
    Color containerColor = _darkMode ? Colors.grey[850]! : Colors.grey.withAlpha(200);
    Color inputColor = _darkMode ? Colors.black : Colors.white;
    Color textColor = Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: _goToIndex, // Navigate to IndexScreen on click
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: Image.asset(
                      "assets/logo.png",
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.camera_alt, size: 50, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Text('Welcome Back',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: textColor),
                    textAlign: TextAlign.center),
                const SizedBox(height: 12),
                Text('Log in to continue your wildlife journey',
                    style: TextStyle(fontSize: 16, color: textColor),
                    textAlign: TextAlign.center),
                const SizedBox(height: 40),
                if (!_isLoggedIn)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        const Text('Login to Your Account',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: 24),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              _inputField(_emailController, 'Email', TextInputType.emailAddress,
                                  (v) {
                                if (v == null || v.isEmpty) return 'Enter email';
                                return null;
                              }, textColor: textColor, fillColor: inputColor),
                              const SizedBox(height: 16),
                              _inputField(_passwordController, 'Password', TextInputType.text,
                                  (v) {
                                if (v == null || v.isEmpty) return 'Enter password';
                                return null;
                              }, obscureText: _obscurePassword, textColor: textColor, fillColor: inputColor),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: _isLoading ? null : _login,
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF6B7280),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                  child: _isLoading
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                                        )
                                      : const Text('Login',
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text('Dark Mode', style: TextStyle(color: Colors.white)),
                            Switch(
                              value: _darkMode,
                              onChanged: (val) {
                                setState(() => _darkMode = val);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                if (_isLoggedIn)
                  Column(
                    children: [
                      Text('Logged in as $correctEmail',
                          style: TextStyle(color: textColor, fontSize: 18)),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _logout,
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6B7280)),
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputField(TextEditingController controller, String hint, TextInputType type,
      String? Function(String?) validator,
      {bool obscureText = false, Color textColor = Colors.black, Color fillColor = Colors.white}) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: obscureText,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        hintText: hint,
        hintStyle: TextStyle(color: textColor.withOpacity(0.7)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.all(16),
      ),
      validator: validator,
    );
  }
}
