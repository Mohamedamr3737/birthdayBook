// home_screen.dart
import 'package:e_commerce/favouritesScreen.dart';
import 'package:flutter/material.dart';
import 'userListScreen.dart';
import 'birthdayListScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to the App"),
      ),
      body: Center(child: Text("Welcome to our user app!")),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "User List"),
          BottomNavigationBarItem(icon: Icon(Icons.cake), label: "Birthday List"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites List"),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => UserListScreen()));
          } else if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => BirthdayListScreen()));
          }
            else if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => FavoritesScreen()));
          }
        },
      ),
    );
  }
}
