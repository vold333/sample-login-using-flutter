import 'package:flutter/material.dart';
import 'login_screen.dart'; // Import the LoginScreen class

class HomeScreen extends StatelessWidget {
  final String name;
  final String email;
  final String phoneNumber;

  const HomeScreen({
    Key? key,
    required this.name,
    required this.email,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blueAccent,
              child: Text(
                name[0],
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Welcome, $name',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 16),
            Card(
              color: Colors.blue[50],
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
              child: ListTile(
                leading: Icon(Icons.email, color: Colors.blueAccent),
                title: Text(
                  email,
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.blue[50],
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
              child: ListTile(
                leading: Icon(Icons.phone, color: Colors.blueAccent),
                title: Text(
                  phoneNumber,
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
