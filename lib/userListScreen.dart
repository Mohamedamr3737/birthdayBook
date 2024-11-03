// user_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../userService.dart';
import '../userModel.dart';
import '../main.dart';
import 'userProfileScreen.dart';

class UserListScreen extends StatelessWidget {
  final UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User List")),
      body: FutureBuilder<List<User>>(
        future: userService.fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];

                return Consumer<FavoriteProvider>(
                  builder: (context, favoriteProvider, child) {
                    // Check if any favorite user has the same name as the current user
                    final isFavorite = favoriteProvider.favorites.any((favUser) => favUser.name == user.name);

                    return ListTile(
                      leading: Image.network(user.profileImage),
                      title: Text(user.name),
                      subtitle: Text(user.email),
                      trailing: IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.black : null,
                        ),
                        onPressed: () {
                          if (isFavorite) {
                            favoriteProvider.removeFavorite(user);
                          } else {
                            favoriteProvider.addFavorite(user);
                          }
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
                );
              },
            );
          }
        },
      ),
    );
  }
}
