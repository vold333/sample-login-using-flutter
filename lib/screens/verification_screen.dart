import 'package:flutter/material.dart';
// Import your NewPasswordScreen here
import 'new_password_screen.dart';

class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(4, (index) => TextEditingController());

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _handleKeyPress(String value, int index) {
    if (value.isNotEmpty) {
      if (index < _focusNodes.length - 1) {
        _focusNodes[index].unfocus();
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      }
    } else if (index > 0) {
      _focusNodes[index].unfocus();
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  void _verifyCode() {
    String otp = _controllers.map((controller) => controller.text).join();
    // Add logic to verify the OTP here
    if (otp.length == 4) {
      // Assume OTP is correct for this example
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NewPasswordScreen()),
      );
    } else {
      // Show error if OTP is incorrect
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid 4-digit OTP')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Email'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter the verification code sent to your email.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return SizedBox(
                  width: 50.0,
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    maxLength: 1,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: '_',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onChanged: (value) => _handleKeyPress(value, index),
                  ),
                );
              }),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _verifyCode,
              child: Text('Verify Code'),
            ),
          ],
        ),
      ),
    );
  }
}
