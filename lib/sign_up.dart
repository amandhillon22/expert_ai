import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uxpert_ai/complete_profile.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  'Create New Account',
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please enter your email & password to create an account',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 40),

                // Email Field
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: themeColor),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Password Field
                TextField(
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'Enter password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: themeColor),
                    ),
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
                const SizedBox(height: 40),

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CompleteProfileScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('Sign Up', style: GoogleFonts.poppins(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(height: 40),

                // Divider
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('Or Continue with', style: GoogleFonts.poppins(color: Colors.grey[600])),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 30),

                // Social Login Buttons
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

                // Sign In Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?", style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700])),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Sign In', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: themeColor)),
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

  Widget _socialButton({required String assetPath}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Image.asset(assetPath, height: 30, width: 30, errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 30)),
    );
  }
}
