import 'package:flutter/material.dart';
import 'purchase.dart';
import 'register.dart';
import 'index.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  final bool _obscurePassword = true;
  bool _darkMode = false; // <-- Dark Mode flag

  late final AnimationController _animController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _fadeAnimation = CurvedAnimation(parent: _animController, curve: Curves.easeIn);
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 1));
      setState(() => _isLoading = false);

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Login Successful'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const PurchaseScreen()),
                );
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _goToRegister() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen()));
  }

  Widget _inputField(TextEditingController controller, String hint, TextInputType type,
      {bool obscureText = false, Color textColor = Colors.black, Color fillColor = Colors.white}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextFormField(
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
        validator: (v) => v == null || v.isEmpty ? 'Enter $hint' : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // --- Colors for Login Form based on Dark Mode ---
    Color containerColor = _darkMode ? Colors.grey[850]! : Colors.white;
    Color textColor = _darkMode ? Colors.white : Colors.black;
    Color inputFillColor = _darkMode ? Colors.grey[700]! : Colors.grey[200]!;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              'assets/heroimagelogin.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    GestureDetector(
                      onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen())),
                      child: SizedBox(
                        width: 120,
                        height: 120,
                        child: Image.asset(
                          "assets/logo.png",
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const Icon(Icons.camera_alt, size: 50, color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text('Welcome Back',
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white),
                        textAlign: TextAlign.center),
                    const SizedBox(height: 12),
                    const Text('Log in to continue your wildlife journey',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.center),
                    const SizedBox(height: 40),

                    // --- Login Form Container ---
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: containerColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Text('Login to Your Account',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor)),
                          const SizedBox(height: 24),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                _inputField(_emailController, 'Email', TextInputType.emailAddress,
                                    textColor: textColor, fillColor: inputFillColor),
                                _inputField(_passwordController, 'Password', TextInputType.text,
                                    obscureText: _obscurePassword, textColor: textColor, fillColor: inputFillColor),
                                const SizedBox(height: 24),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: _isLoading ? null : _login,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                    child: _isLoading
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                                strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.black)),
                                          )
                                        : const Text('Login',
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                GestureDetector(
                                  onTap: _goToRegister,
                                  child: const Text('REGISTER NOW',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline)),
                                ),
                                const SizedBox(height: 16),
                                // --- Dark Mode Toggle ---
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Dark Mode', style: TextStyle(color: textColor)),
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
