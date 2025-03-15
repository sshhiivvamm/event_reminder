class ReminderModel {
  final bool? success;
  final List<Reminder>? reminders;

  ReminderModel({this.success, this.reminders});

  factory ReminderModel.fromJson(Map<String, dynamic> json) {
    return ReminderModel(
      success: json['success'],
      reminders: (json['reminders'] as List<dynamic>?)
          ?.map((e) => Reminder.fromJson(e))
          .toList(),
    );
  }
}

class Reminder {
  final String? id; // Added to handle the `_id` field
  final String? firmName;
  final String? firmAddress;
  final String? gst;
  final String? certificationBody;
  final String? contact;
  final double? basicAmount;
  final String? reference;
  final String? issuedDate;
  final String? expiryDate;
  final String? certificate;

  Reminder({
    this.id, // Added to constructor
    this.firmName,
    this.firmAddress,
    this.gst,
    this.certificationBody,
    this.contact,
    this.basicAmount,
    this.reference,
    this.issuedDate,
    this.expiryDate,
    this.certificate,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['_id'], // Correctly mapping `_id` to `id`
      firmName: json['firm_name'],
      firmAddress: json['firm_address'],
      gst: json['gst'],
      certificationBody: json['certification_body'],
      contact: json['contact'].toString(), // Contact converted to string
      basicAmount: double.tryParse(json['basic_amount'].toString()),
      reference: json['reference'],
      issuedDate: json['issued_date'],
      expiryDate: json['expiry_date'],
      certificate: json['certificate'],
    );
  }
}
