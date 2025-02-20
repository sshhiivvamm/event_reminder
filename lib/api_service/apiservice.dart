import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:3000/routes/save-reminder';

  static Future<void> saveReminder({
    required String companyName,
    required String address,
    required String gst,
    required String certificationBody,
    required String contactInfo,
    required String basicAmount,
    required String reference,
    required String originalIssueDate,
    required String expDate,
    required String certificateType,
  }) async {
    try {
      // Create the request body as a map
      Map<String, String> body = {
        'companyName': companyName,
        'address': address,
        'gst': gst,
        'certificationBody': certificationBody,
        'contactInfo': contactInfo,
        'basicAmount': basicAmount,
        'reference': reference,
        'originalIssueDate': originalIssueDate,
        'expDate': expDate,
        'certificateType': certificateType,
      };

      // Send the POST request
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Handle successful response
        print('Reminder saved successfully');
      } else {
        // Handle error response
        print('Error saving reminder: ${response.body}');
      }
    } catch (e) {
      // Handle any exceptions
      print('Exception occurred: $e');
    }
  }
}
