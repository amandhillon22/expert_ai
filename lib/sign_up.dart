import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uxpert_ai/complete_profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// --- 1. IMPORT THE DEVELOPER LIBRARY FOR LOGGING ---
import 'dart:developer' as developer;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  Future<void> _signUp() async {
    // --- 2. LOG WHEN THE FUNCTION IS CALLED ---
    developer.log('Sign up process started...');

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final url = Uri.parse('http://10.0.2.2:8000/register/');
        final body = jsonEncode(<String, String>{
          'full_name': _nameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
        });

        // --- 3. LOG THE REQUEST DETAILS BEFORE SENDING ---
        developer.log('Sending POST request to: $url');
        developer.log('Request Body: $body');

        final response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body,
        );

        // --- 4. LOG THE RESPONSE FROM THE SERVER ---
        developer.log('Received response with Status Code: ${response.statusCode}');
        developer.log('Response Body: ${response.body}');


        if (!mounted) return;

        if (response.statusCode == 200) {
          // --- 5. LOG A SUCCESSFUL REGISTRATION ---
          developer.log('Registration successful! Navigating to next screen.');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration successful! ✅')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const CompleteProfileScreen()),
          );
        } else {
          // --- 6. LOG THE SERVER-SIDE ERROR ---
          final error = jsonDecode(response.body);
          developer.log('Server returned an error: ${error['detail']}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${error['detail']}')),
          );
        }
      } catch (e) {
        // --- 7. LOG ANY NETWORK OR UNEXPECTED ERRORS ---
        developer.log('An exception occurred during sign up: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to connect to the server: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      // --- 8. LOG IF FORM VALIDATION FAILS ---
      developer.log('Form validation failed.');
    }
  }

  @override
  Widget build(BuildContext context) {
    // ... your build method remains exactly the same
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
            child: Form(
              key: _formKey,
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
                    'Please fill the form to create an account',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter full name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: themeColor),
                      ),
                    ),
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter your full name' : null,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
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
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter your email' : null,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
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
                          _isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter a password' : null,
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                      onPressed: _signUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeColor,
                        padding:
                        const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text('Sign Up',
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('Or Continue with',
                            style:
                            GoogleFonts.poppins(color: Colors.grey[600])),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 30),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?",
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: Colors.grey[700])),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Sign In',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: themeColor)),
                      ),
                    ],
                  )
                ],
              ),
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
      child: Image.asset(assetPath,
          height: 30,
          width: 30,
          errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.error, size: 30)),
    );
  }
}