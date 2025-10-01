import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uxpert_ai/home_screen.dart';
import 'package:uxpert_ai/sign_up.dart';

import 'forgot_password.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _rememberMe = false;
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    // Get the theme's primary color
    final themeColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Header ---
                Text(
                  'Sign in to Your Account',
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please enter below details to continue',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 40),

                // --- Email Field ---
                Text(
                  'Email',
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
                ),
                const SizedBox(height: 8),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'example@gmail.com',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: themeColor),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
                const SizedBox(height: 20),

                // --- Password Field ---
                Text(
                  'Password',
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
                ),
                const SizedBox(height: 8),
                TextField(
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: '********',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: themeColor),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // --- Remember Me & Forgot Password Row ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: _rememberMe,
                            onChanged: (bool? value) {
                              setState(() {
                                _rememberMe = value!;
                              });
                            },
                            activeColor: themeColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Remember me',
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                      },
                      child: Text(
                        'Forgot password?',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: themeColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // --- Sign In Button ---
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Sign in',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // --- Divider ---
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Or Continue with',
                        style: GoogleFonts.poppins(color: Colors.grey[600]),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 30),

                // --- Social Login Buttons ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _socialButton(assetPath: 'assets/google_icon.png'),
                    const SizedBox(width: 20),
                    _socialButton(assetPath: 'assets/facebook_icon.png'),
                    const SizedBox(width: 20),
                    _socialButton(assetPath: 'assets/apple_icon.png'),
                  ],
                ),
                const SizedBox(height: 40),

                // --- Sign Up Link ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignUpScreen()));
                      },
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: themeColor,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget for social buttons
  Widget _socialButton({required String assetPath}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Image.asset(
        assetPath,
        height: 30,
        width: 30,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 30),
      ),
    );
  }
}
