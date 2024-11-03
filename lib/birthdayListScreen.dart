// birthday_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../userModel.dart';
import '../main.dart';

class BirthdayListScreen extends StatefulWidget {
  @override
  _BirthdayListScreenState createState() => _BirthdayListScreenState();
}

class _BirthdayListScreenState extends State<BirthdayListScreen> {
  bool _isAscending = true; // State to track sorting order

  // Helper function to parse date with or without leading zeros
  DateTime _parseDate(String birthDate) {
    try {
      return DateFormat('yyyy-MM-dd').parse(birthDate);
    } catch (e) {
      final parts = birthDate.split('-');
      final year = int.parse(parts[0]);
      final month = int.parse(parts[1].padLeft(2, '0'));
      final day = int.parse(parts[2].padLeft(2, '0'));
      return DateTime(year, month, day);
    }
  }

  // Helper function to check if a birthday is upcoming within the next 365 days
  bool _isUpcomingBirthday(String birthDate) {
    final birthDateTime = _parseDate(birthDate);

    final now = DateTime.now();
    final thisYearBirthday = DateTime(now.year, birthDateTime.month, birthDateTime.day);

    if (thisYearBirthday.isBefore(now)) {
      final nextYearBirthday = DateTime(now.year + 1, birthDateTime.month, birthDateTime.day);
      return nextYearBirthday.difference(now).inDays <= 365;
    } else {
      return thisYearBirthday.difference(now).inDays <= 365;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoriteProvider>(context).favorites;
    final upcomingBirthdays = favorites.where((user) => _isUpcomingBirthday(user.birthDate)).toList();

    // Sort the upcomingBirthdays list based on the selected order
    upcomingBirthdays.sort((a, b) {
      final dateA = _parseDate(a.birthDate);
      final dateB = _parseDate(b.birthDate);

      return _isAscending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Upcoming Birthdays"),
        actions: [
          DropdownButton<bool>(
            value: _isAscending,
            icon: Icon(Icons.sort),
            onChanged: (bool? newValue) {
              setState(() {
                _isAscending = newValue ?? true;
              });
            },
            items: [
              DropdownMenuItem(
                value: true,
                child: Text("Sort Ascending"),
              ),
              DropdownMenuItem(
                value: false,
                child: Text("Sort Descending"),
              ),
            ],
          ),
        ],
      ),
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
