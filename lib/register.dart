import 'package:flutter/material.dart';
import 'login.dart'; // Import login screen for navigation back

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 2));
      
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _navigateToForgotPassword() {
    // TODO: Implement navigation to forgot password screen
    debugPrint('Navigate to Forgot Password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a1a),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/heroimageregister.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            color: Colors.black.withAlpha(150), // Dark overlay
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  
                  // Logo - Clickable to go back
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: const Color(0xFF333333).withAlpha(200),
                        borderRadius: BorderRadius.circular(60),
                        border: Border.all(
                          color: Colors.white.withAlpha(100),
                          width: 2,
                        ),
                      ),
                      child: Image.asset(
                        "assets/logo.png",
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.camera_alt, 
                            color: Colors.white, 
                            size: 50
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Heading
                  const Text(
                    'Start Your Wildlife Journey',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 12),

                  // Subtitle
                  const Text(
                    'Unlock exclusive access to nature\'s finest',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFE5E5E5),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 40),

                  // Register Form
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF333333).withAlpha(200),
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(100),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Create Your Account',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 24),

                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              // Name Field
                              TextFormField(
                                controller: _nameController,
                                style: const TextStyle(color: Color(0xFF121212)),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white.withAlpha(230),
                                  hintText: 'Full Name',
                                  hintStyle: const TextStyle(color: Color(0xFF6B7280)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(color: Color(0xFF4b4b4b)),
                                  ),
                                  contentPadding: const EdgeInsets.all(16.0),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your full name';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 16),

                              // Email Field
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(color: Color(0xFF121212)),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white.withAlpha(230),
                                  hintText: 'Email',
                                  hintStyle: const TextStyle(color: Color(0xFF6B7280)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(color: Color(0xFF4b4b4b)),
                                  ),
                                  contentPadding: const EdgeInsets.all(16.0),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!value.contains('@')) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 16),

                              // Phone Number Field
                              TextFormField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                style: const TextStyle(color: Color(0xFF121212)),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white.withAlpha(230),
                                  hintText: 'Phone Number',
                                  hintStyle: const TextStyle(color: Color(0xFF6B7280)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(color: Color(0xFF4b4b4b)),
                                  ),
                                  contentPadding: const EdgeInsets.all(16.0),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your phone number';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 16),

                              // Address Field
                              TextFormField(
                                controller: _addressController,
                                style: const TextStyle(color: Color(0xFF121212)),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white.withAlpha(230),
                                  hintText: 'Address',
                                  hintStyle: const TextStyle(color: Color(0xFF6B7280)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(color: Color(0xFF4b4b4b)),
                                  ),
                                  contentPadding: const EdgeInsets.all(16.0),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your address';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 16),

                              // City Field
                              TextFormField(
                                controller: _cityController,
                                style: const TextStyle(color: Color(0xFF121212)),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white.withAlpha(230),
                                  hintText: 'City',
                                  hintStyle: const TextStyle(color: Color(0xFF6B7280)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(color: Color(0xFF4b4b4b)),
                                  ),
                                  contentPadding: const EdgeInsets.all(16.0),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your city';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 16),

                              // Zip Code Field
                              TextFormField(
                                controller: _zipController,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(color: Color(0xFF121212)),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white.withAlpha(230),
                                  hintText: 'Zip Code',
                                  hintStyle: const TextStyle(color: Color(0xFF6B7280)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(color: Color(0xFF4b4b4b)),
                                  ),
                                  contentPadding: const EdgeInsets.all(16.0),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your zip code';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 16),

                              // Password Field
                              TextFormField(
                                controller: _passwordController,
                                obscureText: _obscurePassword,
                                style: const TextStyle(color: Color(0xFF121212)),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white.withAlpha(230),
                                  hintText: 'Password',
                                  hintStyle: const TextStyle(color: Color(0xFF6B7280)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(color: Color(0xFF4b4b4b)),
                                  ),
                                  contentPadding: const EdgeInsets.all(16.0),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 16),

                              // Confirm Password Field
                              TextFormField(
                                controller: _confirmPasswordController,
                                obscureText: _obscureConfirmPassword,
                                style: const TextStyle(color: Color(0xFF121212)),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white.withAlpha(230),
                                  hintText: 'Confirm Password',
                                  hintStyle: const TextStyle(color: Color(0xFF6B7280)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(color: Color(0xFF4b4b4b)),
                                  ),
                                  contentPadding: const EdgeInsets.all(16.0),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please confirm your password';
                                  }
                                  if (value != _passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 24),

                              // Register Button
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: _isLoading ? null : _register,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF6B7280),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  child: _isLoading
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                          ),
                                        )
                                      : const Text(
                                          'Create Account',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Links
                              _buildLoginLink(),
                              _buildForgotPasswordLink(),
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
    );
  }

  Widget _buildLoginLink() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      },
      child: RichText(
        text: const TextSpan(
          text: 'Already have an account? ',
          style: TextStyle(
            color: Color(0xFFD1D5DB),
            fontSize: 14,
          ),
          children: [
            TextSpan(
              text: 'LOGIN',
              style: TextStyle(
                color: Color(0xFF6B7280),
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForgotPasswordLink() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: GestureDetector(
        onTap: _navigateToForgotPassword,
        child: RichText(
          text: const TextSpan(
            text: '',
            style: TextStyle(
              color: Color(0xFFD1D5DB),
              fontSize: 14,
            ),
            children: [
              TextSpan(
                text: 'Forgot Password?',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}