// birthday_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../userModel.dart';
import '../main.dart';

class BirthdayListScreen extends StatelessWidget {
  // Helper function to parse date with or without leading zeros
  DateTime _parseDate(String birthDate) {
    try {
      return DateFormat('yyyy-MM-dd').parse(birthDate);
    } catch (e) {
      // Handle dates with single-digit month/day
      final parts = birthDate.split('-');
      final year = int.parse(parts[0]);
      final month = int.parse(parts[1].padLeft(2, '0'));
      final day = int.parse(parts[2].padLeft(2, '0'));
      return DateTime(year, month, day);
    }
  }

  // Helper function to check if a birthday is upcoming within the next 30 days
  bool _isUpcomingBirthday(String birthDate) {
    final birthDateTime = _parseDate(birthDate);

    final now = DateTime.now();
    final thisYearBirthday = DateTime(now.year, birthDateTime.month, birthDateTime.day);

    // Check if the birthday is within the next 30 days
    if (thisYearBirthday.isBefore(now)) {
      // If the birthday has already passed this year, check next year's birthday
      final nextYearBirthday = DateTime(now.year + 1, birthDateTime.month, birthDateTime.day);
      return nextYearBirthday.difference(now).inDays <= 30;
    } else {
      return thisYearBirthday.difference(now).inDays <= 30;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoriteProvider>(context).favorites;
    final upcomingBirthdays = favorites.where((user) => _isUpcomingBirthday(user.birthDate)).toList();

    return Scaffold(
      appBar: AppBar(title: Text("Upcoming Birthdays")),
      body: upcomingBirthdays.isEmpty
          ? Center(child: Text("No upcoming birthdays"))
          : ListView.builder(
        itemCount: upcomingBirthdays.length,
        itemBuilder: (context, index) {
          final user = upcomingBirthdays[index];
          final birthdayDate = DateFormat("MMMM dd").format(_parseDate(user.birthDate));
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.profileImage),
            ),
            title: Text(user.name),
            subtitle: Text("Birthday: $birthdayDate"),
          );
        },
      ),
    );
  }
}
