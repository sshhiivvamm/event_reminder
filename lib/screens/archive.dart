import 'package:event_reminder/utils/colors.dart';
import 'package:flutter/material.dart';

class Archive extends StatefulWidget {
  const Archive({super.key});

  @override
  State<Archive> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Archive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: EventColors.bg,
      ),
    );
  }
}
