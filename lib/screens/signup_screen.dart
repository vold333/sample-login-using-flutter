import 'dart:convert';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                label: 'Name',
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                maxLength: 10,
              ),
              SizedBox(height: 16.0),
              CustomTextField(
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!isValidEmail(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              CustomTextField(
                label: 'Phone Number',
                keyboardType: TextInputType.phone,
                controller: _phoneNumberController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                maxLength: 10,
              ),
              SizedBox(height: 16.0),
              CustomTextField(
                label: 'Password',
                isPassword: true,
                obscureText: !_isPasswordVisible,
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
                maxLength: 10,
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              SizedBox(height: 16.0),
              CustomTextField(
                label: 'Confirm Password',
                isPassword: true,
                obscureText: !_isConfirmPasswordVisible,
                controller: _confirmPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  } else if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                maxLength: 10,
                suffixIcon: IconButton(
                  icon: Icon(_isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                ),
              ),
              SizedBox(height: 16.0),
              CustomButton(
                text: 'Sign Up',
                onPressed: () async {
                  if (_formKey.currentState?.validate() == true) {
                    // Construct the request payload
                    Map<String, dynamic> userData = {
                      'userName': _nameController.text,
                      'email': _emailController.text,
                      'phoneNumber': _phoneNumberController.text,
                      'password': _passwordController.text,
                    };

                    // Send the data to the API to create a new account
                    try {
                      final response = await http.post(
                        Uri.parse('http://localhost:8080/users/add'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: jsonEncode(userData),
                      );

                      if (response.statusCode == 200) {
                        // Handle successful signup
                        // Navigate to the login screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      } else {
                        // Handle errors
                        // Show error message to the user
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Signup failed. Please try again later.'),
                          ),
                        );
                      }
                    } catch (e) {
                      // Handle network errors
                      // Show error message to the user
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Network error. Please check your internet connection.'),
                        ),
                      );
                    }
                  }
                },
              ),
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text(
                  'Already have an account? Login',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
