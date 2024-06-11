import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';

class NewPasswordScreen extends StatefulWidget {
  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter your new password.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            CustomTextField(
              label: 'New Password',
              isPassword: true,
              obscureText: true,
              suffixIcon: Icon(Icons.visibility),
              controller: newPasswordController,
            ),
            SizedBox(height: 16.0),
            CustomTextField(
              label: 'Confirm New Password',
              isPassword: true,
              obscureText: true,
              suffixIcon: Icon(Icons.visibility),
              controller: confirmPasswordController,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (newPasswordController.text.isEmpty || confirmPasswordController.text.isEmpty) {
                  setState(() {
                    errorText = "*Please fill in all fields";
                  });
                } else if (newPasswordController.text != confirmPasswordController.text) {
                  setState(() {
                    errorText = "*Passwords do not match";
                  });
                } else {
                  // Passwords match, proceed with updating
                  setState(() {
                    errorText = null;
                  });
                  // Add logic to update password
                }
              },
              child: Text('Update Password'),
            ),
            if (errorText != null)
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  errorText!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
