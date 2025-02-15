import 'package:flutter/material.dart';

class FormUtils {
  static final TextEditingController customItemController =
      TextEditingController();
  static final TextEditingController companyNameController =
      TextEditingController();
  static final TextEditingController addressController =
      TextEditingController();
  static final TextEditingController gstNoController = TextEditingController();
  static final TextEditingController cbController = TextEditingController();
  static final TextEditingController standardController =
      TextEditingController();
  static final TextEditingController originalIssueDateController =
      TextEditingController();
  static final TextEditingController expDateController =
      TextEditingController();
  static final TextEditingController contactInfoController =
      TextEditingController();
  static final TextEditingController basicAmountController =
      TextEditingController();
  static final TextEditingController receivedAmountController =
      TextEditingController();
  static final TextEditingController referenceController =
      TextEditingController();

  static List<String> dropdownItems = [
    "ISO 9001 - Quality Management System",
    "ISO 14001 - Environmental Management System",
    "ISO 45001 - Occupational Health & Safety Management System",
    "ISO 22000 - Food Safety Management System",
    "ISO/IEC 27001 - Information Security Management System",
    "ISO/IEC 20000-1 - IT Management System",
    "ISO 13485 - Medical Devices, Quality Management System",
    "ISO 50001 - Energy Management System Certification",
    "ISO 22313 - Business Continuity Management System",
    "HACCP Hazard Analysis & Critical Control Points",
    "ISO 10002 - Customer Complaints Management Systems",
    "ISO 10006 - Quality Management Systems",
    "ISO 10015 - Quality Management, Guidelines For Training",
    "ISO 28001 - Security Management for Supply Chain Management",
    "ISO 29990 - Learning Services Management",
    "ISO 31000 - Risk Management",
  ];
}
