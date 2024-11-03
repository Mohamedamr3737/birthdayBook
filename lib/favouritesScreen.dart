// favorites_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'userModel.dart';
import '../main.dart';
import 'userProfileScreen.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoriteProvider>(context).favorites;

    return Scaffold(
      appBar: AppBar(title: Text("Favorites")),
      body: favorites.isEmpty
          ? Center(child: Text("No favorites added"))
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final user = favorites[index];
          return ListTile(
            leading: Image.network(user.profileImage),
            title: Text(user.name),
            subtitle: Text(user.email),
            trailing: IconButton(
              icon: Icon(Icons.favorite, color: Colors.black),
              onPressed: () {
                Provider.of<FavoriteProvider>(context, listen: false).removeFavorite(user);
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfileScreen(user: user)),
              );
            },
          );
        },
      ),
    );
  }
}
