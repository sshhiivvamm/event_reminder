import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:event_reminder/screens/archive.dart';
import 'package:event_reminder/screens/dashboard.dart';
import 'package:event_reminder/screens/form.dart';
import 'package:event_reminder/screens/calendar.dart'; // Example screen
import 'package:event_reminder/screens/profile.dart'; // Example screen
import 'package:flutter/material.dart';
import 'package:event_reminder/utils/colors.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Navigation1(), // Use the MainScreen as the entry point
    );
  }
}

class Navigation1 extends StatefulWidget {
  const Navigation1({super.key});

  @override
  _Navigation1State createState() => _Navigation1State();
}

class _Navigation1State extends State<Navigation1> {
  int _index = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey =
      GlobalKey<CurvedNavigationBarState>();

  final List<Widget> _screens = [
    Dashboard(),
    CalendarScreen(),
    FormData(),
    Archive(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 2.0,
        backgroundColor: EventColors.primarygreen,
        title: Text('D-Day App', style: TextStyle(color: EventColors.white)),
        centerTitle: true,
      ),
      body: _screens[_index], // Display the current screen
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _index,
        height: 75,
        animationDuration: Duration(milliseconds: 400),
        color: EventColors.pgreen,
        buttonBackgroundColor: EventColors.pgreen,
        backgroundColor: Colors.transparent,
        items: <Widget>[
          CircleAvatar(
            radius: 25,
            backgroundColor: EventColors.primarygreen,
            child: Icon(
              Icons.home,
              size: 30,
              color: EventColors.pgreen,
            ),
          ),
          CircleAvatar(
            radius: 25,
            backgroundColor: EventColors.primarygreen,
            child: Icon(
              Icons.calendar_today,
              size: 30,
              color: EventColors.pgreen,
            ),
          ),
          CircleAvatar(
            radius: 25,
            backgroundColor: EventColors.primarygreen,
            child: Icon(
              Icons.add,
              size: 30,
              color: EventColors.pgreen,
            ),
          ),
          CircleAvatar(
            radius: 25,
            backgroundColor: EventColors.primarygreen,
            child: Icon(
              Icons.archive,
              size: 30,
              color: EventColors.pgreen,
            ),
          ),
          CircleAvatar(
            radius: 25,
            backgroundColor: EventColors.primarygreen,
            child: Icon(
              Icons.person,
              size: 30,
              color: EventColors.pgreen,
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
    );
  }
}
