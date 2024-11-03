// user_profile_screen.dart
import 'package:flutter/material.dart';
import 'userModel.dart';

class UserProfileScreen extends StatelessWidget {
  final User user;

  UserProfileScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(user.profileImage),
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Name: ${user.name}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Email: ${user.email}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              "Birthday: ${user.birthDate}",
              style: TextStyle(fontSize: 16),
            ),
            // Add more details if needed
          ],
        ),
      ),
    );
  }
}
