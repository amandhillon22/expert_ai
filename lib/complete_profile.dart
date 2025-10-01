import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({super.key});

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
                  'Complete Your Profile',
                  style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please enter your profile. Don\'t worry, only you can see your personal data. No one else will be able to see it. Or you can skip it for now.',
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 30),

                // Profile Picture Avatar
                Center(
                  child: Stack(
                    children: [
                      const CircleAvatar(
                        radius: 60,
                        backgroundColor: Color(0xFFE8F5E9), // Light green background
                        child: Icon(Icons.person, size: 60, color: Color(0xFFBDBDBD)),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: themeColor,
                          child: IconButton(
                            icon: const Icon(Icons.edit, color: Colors.white, size: 20),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Form Fields
                _buildTextField(label: 'Full name'),
                const SizedBox(height: 20),
                _buildTextField(label: 'Phone number', prefix: const Text('+91 ')),
                const SizedBox(height: 20),
                _buildDropdownField(label: 'Gender'),
                const SizedBox(height: 20),
                _buildDateField(context, label: 'Date of birth'),
                const SizedBox(height: 40),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // Skip logic
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          side: BorderSide(color: themeColor),
                        ),
                        child: Text('Skip', style: GoogleFonts.poppins(fontSize: 18, color: themeColor, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Next logic
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: themeColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text('Next', style: GoogleFonts.poppins(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600)),
                      ),
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

  Widget _buildTextField({required String label, Widget? prefix}) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        prefix: prefix,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildDropdownField({required String label}) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      items: <String>['Male', 'Female', 'Other']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        // Handle change
      },
    );
  }

  Widget _buildDateField(BuildContext context, {required String label}) {
    return TextField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: const Icon(Icons.calendar_today),
      ),
      onTap: () async {
        await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
      },
    );
  }
}
