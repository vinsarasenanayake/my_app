import 'package:flutter/material.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with SingleTickerProviderStateMixin {
  // --- Form Controllers ---
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // --- State Variables ---
  bool _isLoading = false;
  final bool _obscurePassword = true;
  final bool _obscureConfirmPassword = true;

  // --- Animation Controller ---
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
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // --- Registration Logic ---
  void _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 2));
      setState(() => _isLoading = false);

      // --- Show success alert ---
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Account created successfully'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                ); // Navigate to LoginScreen
              },
              child: const Text('OK'),
            )
          ],
        ),
      );
    }
  }

  void _navigateToForgotPassword() => debugPrint('Forgot Password');

  // --- Input Field Widget ---
  Widget _inputField(TextEditingController controller, String hint,
      TextInputType type,
      {bool obscureText = false,
      String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        obscureText: obscureText,
        style: const TextStyle(color: Color(0xFF121212)),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withAlpha(230),
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF6B7280)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF4b4b4b))),
          contentPadding: const EdgeInsets.all(16),
        ),
        validator: validator,
      ),
    );
  }

  // --- Login Link Widget ---
  Widget _loginLink() {
    return GestureDetector(
      onTap: () => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginScreen())),
      child: RichText(
        text: const TextSpan(
          text: 'Already have an account? ',
          style: TextStyle(color: Color(0xFFD1D5DB), fontSize: 14),
          children: [
            TextSpan(
                text: 'LOGIN',
                style: TextStyle(
                    color: Color(0xFF6B7280),
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  // --- Forgot Password Link Widget ---
  Widget _forgotPasswordLink() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: GestureDetector(
        onTap: _navigateToForgotPassword,
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
              color: Color(0xFF6B7280),
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a1a),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            // --- Background Image ---
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/heroimageregister.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              color: Colors.black.withAlpha(150),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(height: 40),

                    // --- Logo Section ---
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: SizedBox(
                        width: 120,
                        height: 120,
                        child: Image.asset(
                          "assets/logo.png",
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // --- Header Text ---
                    const Text(
                      'Start Your Wildlife Journey',
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Unlock exclusive access to nature\'s finest',
                      style: TextStyle(fontSize: 16, color: Color(0xFFE5E5E5)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),

                    // --- Registration Form Container ---
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFF333333).withAlpha(200),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withAlpha(100),
                              blurRadius: 20,
                              offset: const Offset(0, 10))
                        ],
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Create Your Account',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),

                          // --- Form Fields ---
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                _inputField(_nameController, 'Full Name', TextInputType.text,
                                    validator: (v) => v!.isEmpty ? 'Enter name' : null),
                                _inputField(_emailController, 'Email', TextInputType.emailAddress,
                                    validator: (v) {
                                  if (v!.isEmpty) return 'Enter email';
                                  if (!v.contains('@')) return 'Invalid email';
                                  return null;
                                }),
                                _inputField(_phoneController, 'Phone Number', TextInputType.phone,
                                    validator: (v) => v!.isEmpty ? 'Enter phone' : null),
                                _inputField(_addressController, 'Address', TextInputType.text,
                                    validator: (v) => v!.isEmpty ? 'Enter address' : null),
                                _inputField(_cityController, 'City', TextInputType.text,
                                    validator: (v) => v!.isEmpty ? 'Enter city' : null),
                                _inputField(_zipController, 'Zip Code', TextInputType.number,
                                    validator: (v) => v!.isEmpty ? 'Enter zip' : null),
                                _inputField(_passwordController, 'Password', TextInputType.text,
                                    obscureText: _obscurePassword,
                                    validator: (v) {
                                  if (v!.isEmpty) return 'Enter password';
                                  if (v.length < 6) return 'Min 6 chars';
                                  return null;
                                }),
                                _inputField(_confirmPasswordController, 'Confirm Password', TextInputType.text,
                                    obscureText: _obscureConfirmPassword,
                                    validator: (v) {
                                  if (v!.isEmpty) return 'Confirm password';
                                  if (v != _passwordController.text) return 'Passwords do not match';
                                  return null;
                                }),

                                const SizedBox(height: 24),

                                // --- Create Account Button ---
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: _isLoading ? null : _register,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: _isLoading
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                                            ),
                                          )
                                        : const Text(
                                            'Create Account',
                                            style: TextStyle(
                                                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                                          ),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // --- Additional Links ---
                                _loginLink(),
                                _forgotPasswordLink(),
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
        ),
      ),
    );
  }
}
