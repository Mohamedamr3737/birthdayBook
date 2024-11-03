// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'homeScreen.dart';
import 'userModel.dart';

void main() {
  runApp(MyApp());
}

class FavoriteProvider extends ChangeNotifier {
  List<User> _favorites = [];

  List<User> get favorites => _favorites;

  void addFavorite(User user) {
    if (!_favorites.contains(user)) {
      _favorites.add(user);
      notifyListeners();
    }
  }

  void removeFavorite(User user) {
    _favorites.remove(user);
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoriteProvider(),
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
