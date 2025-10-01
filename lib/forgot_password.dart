import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

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
                  'Create New Password',
                  style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please enter your new password',
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 40),

                // Password Field
                TextField(
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: '6556787912',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: themeColor),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
                      onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Confirm Password Field
                TextField(
                  obscureText: !_isConfirmPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Confirm password',
                    hintText: '6556787912',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: themeColor),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(_isConfirmPasswordVisible ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
                      onPressed: () => setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Reset Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add reset logic here
                      Navigator.of(context).pop(); // Go back to sign in
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text('Reset', style: GoogleFonts.poppins(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
