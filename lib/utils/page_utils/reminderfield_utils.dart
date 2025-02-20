import 'package:event_reminder/utils/colors.dart';
import 'package:flutter/material.dart';

class ReminderField extends StatelessWidget {
  final String labelText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Icon icon;

  const ReminderField({
    super.key,
    required this.labelText,
    required this.keyboardType,
    required this.controller,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            filled: true,
            fillColor: EventColors.pgreen,
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.black),
            hintStyle: TextStyle(color: Colors.black),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.elliptical(20, 20),
                bottomRight: Radius.elliptical(20, 20),
              ),
              borderSide:
                  BorderSide(width: 1, color: EventColors.tertiarygreen),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: EventColors.primarygreen, width: 2),
              borderRadius: BorderRadius.only(
                topRight: Radius.elliptical(20, 20),
                bottomLeft: Radius.elliptical(20, 20),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(8),
            ),
            prefixIcon: icon,
            prefixIconColor: EventColors.primarygreen),
      ),
    );
  }
}
