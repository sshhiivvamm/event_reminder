import 'package:event_reminder/api_service/apiservice.dart';
import 'package:event_reminder/utils/colors.dart';
import 'package:event_reminder/utils/page_utils/reminderfield_utils.dart';
import 'package:event_reminder/utils/page_utils/form_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormData extends StatefulWidget {
  const FormData({super.key});

  @override
  State<FormData> createState() => _FormDataState();
}

class _FormDataState extends State<FormData> {
  String selectedDate = "";
  String? selectedItem;

  // Other form logic...

  Future<void> _saveForm() async {
    // Get data from the controllers
    String companyName = FormUtils.companyNameController.text;
    String address = FormUtils.addressController.text;
    String gst = FormUtils.gstNoController.text;
    String certificationBody = FormUtils.cbController.text;
    String contactInfo = FormUtils.contactInfoController.text;
    String basicAmount = FormUtils.basicAmountController.text;
    String reference = FormUtils.referenceController.text;
    String originalIssueDate = FormUtils.originalIssueDateController.text;
    String expDate = FormUtils.expDateController.text;
    String certificateType =
        selectedItem ?? "Other"; // Default to "Other" if no selection

    // Call API to save the reminder
    await ApiService.saveReminder(
      companyName: companyName,
      address: address,
      gst: gst,
      certificationBody: certificationBody,
      contactInfo: contactInfo,
      basicAmount: basicAmount,
      reference: reference,
      originalIssueDate: originalIssueDate,
      expDate: expDate,
      certificateType: certificateType,
    );
  }

  void addCustomItem() {
    if (FormUtils.customItemController.text.isNotEmpty) {
      setState(() {
        FormUtils.dropdownItems.add(
            FormUtils.customItemController.text); // Add custom item to the list
        selectedItem = FormUtils.customItemController.text;
        FormUtils.customItemController
            .clear(); // Clear the text field after adding
      });
    }
  }

  Future<void> selectDate({required bool isExpiryDate}) async {
    DateTime? selected = await showDatePicker(
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      context: context,
      initialDate: DateTime.now(),
    );
    if (selected != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(selected);

      setState(() {
        if (isExpiryDate) {
          FormUtils.expDateController.text = formattedDate;
        } else {
          FormUtils.originalIssueDateController.text = formattedDate;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EventColors.bg,
      extendBody: true,
      body: Container(
        height: MediaQuery.sizeOf(context).height * 0.82,
        decoration: BoxDecoration(
          color: EventColors.bg,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ReminderField(
                  labelText: 'Company Name',
                  icon: Icon(
                    Icons.villa_outlined,
                    size: 28,
                  ),
                  keyboardType: TextInputType.text,
                  controller: FormUtils.companyNameController,
                ),
                ReminderField(
                  labelText: 'Address',
                  keyboardType: TextInputType.streetAddress,
                  icon: Icon(
                    Icons.location_on_outlined,
                    size: 28,
                  ),
                  controller: FormUtils.addressController,
                ),
                ReminderField(
                  labelText: 'GST',
                  keyboardType: TextInputType.text,
                  icon: Icon(
                    Icons.trending_up,
                    size: 28,
                  ),
                  controller: FormUtils.gstNoController,
                ),
                ReminderField(
                  labelText: 'Certification Body',
                  keyboardType: TextInputType.text,
                  icon: Icon(
                    Icons.account_circle_outlined,
                    size: 28,
                  ),
                  controller: FormUtils.cbController,
                ),
                ReminderField(
                  labelText: 'Contact',
                  keyboardType: TextInputType.text,
                  icon: Icon(
                    Icons.call,
                    size: 28,
                  ),
                  controller: FormUtils.contactInfoController,
                ),
                ReminderField(
                  labelText: 'Basic Amount',
                  keyboardType: TextInputType.number,
                  icon: Icon(
                    Icons.currency_rupee_sharp,
                    size: 28,
                  ),
                  controller: FormUtils.basicAmountController,
                ),
                ReminderField(
                  labelText: 'Reference',
                  keyboardType: TextInputType.multiline,
                  icon: Icon(
                    Icons.person,
                    size: 28,
                  ),
                  controller: FormUtils.referenceController,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 8, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          keyboardType: TextInputType.none,
                          controller: FormUtils.originalIssueDateController,
                          decoration: InputDecoration(
                            label: Text('Certificate Issued'),
                            filled: true,
                            fillColor: EventColors.pgreen,
                            labelStyle: TextStyle(color: Colors.black),
                            hintStyle: TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.elliptical(20, 20),
                                bottomRight: Radius.elliptical(20, 20),
                              ),
                              borderSide: BorderSide(
                                  width: 1, color: EventColors.tertiarygreen),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: EventColors.primarygreen, width: 2),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.elliptical(20, 20),
                                bottomLeft: Radius.elliptical(20, 20),
                              ),
                            ),
                            prefixIcon: Icon(Icons.date_range),
                            prefixIconColor: EventColors.primarygreen,
                          ),
                        ),
                      ),
                      SizedBox(width: 35),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: FloatingActionButton(
                          onPressed: () {
                            selectDate(isExpiryDate: false);
                          },
                          backgroundColor: EventColors.primarygreen,
                          foregroundColor: EventColors.pgreen,
                          child: Icon(Icons.date_range),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 8, top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          keyboardType: TextInputType.none,
                          controller: FormUtils.expDateController,
                          decoration: InputDecoration(
                            label: Text('Certificate Expiry'),
                            filled: true,
                            labelStyle: TextStyle(color: Colors.black),
                            hintStyle: TextStyle(color: Colors.black),
                            fillColor: EventColors.pgreen,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.elliptical(20, 20),
                                bottomRight: Radius.elliptical(20, 20),
                              ),
                              borderSide: BorderSide(
                                  width: 1, color: EventColors.tertiarygreen),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: EventColors.primarygreen, width: 2),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.elliptical(20, 20),
                                bottomLeft: Radius.elliptical(20, 20),
                              ),
                            ),
                            prefixIcon: Icon(Icons.date_range),
                            prefixIconColor: EventColors.primarygreen,
                          ),
                        ),
                      ),
                      SizedBox(width: 35),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: FloatingActionButton(
                          onPressed: () {
                            selectDate(isExpiryDate: true);
                          },
                          backgroundColor: EventColors.primarygreen,
                          foregroundColor: EventColors.pgreen,
                          child: Icon(Icons.date_range),
                        ),
                      ),
                    ],
                  ),
                ),
                DropdownButtonFormField<String>(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
                  isExpanded: true,
                  isDense: false,
                  style: TextStyle(
                    color: EventColors.white,
                    fontSize: 20,
                  ),
                  value: selectedItem,
                  hint: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Select Certificate",
                      style: TextStyle(
                        fontSize: 18,
                        color: EventColors.black,
                      ),
                    ),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedItem = newValue;
                    });
                  },
                  items: [
                    ...FormUtils.dropdownItems
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        alignment: AlignmentDirectional.bottomStart,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            value,
                            style: TextStyle(
                              color: EventColors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    }),
                    DropdownMenuItem<String>(
                      value: "Other",
                      child: Container(
                        decoration: BoxDecoration(
                          color: EventColors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: EventColors.primarygreen),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10),
                        child: Text(
                          "Add +",
                          style: TextStyle(
                            color: EventColors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                  selectedItemBuilder: (BuildContext context) {
                    return FormUtils.dropdownItems.map<Widget>((String item) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(15, 7, 5, 7),
                        child: Text(
                          item,
                          style: TextStyle(
                            color: EventColors.black,
                            fontSize: 16,
                          ),
                        ),
                      );
                    }).toList();
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: EventColors.pgreen,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                          BorderSide(color: EventColors.pgreen, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.elliptical(20, 20),
                        bottomRight: Radius.elliptical(20, 20),
                      ),
                      borderSide: BorderSide(
                          width: 1, color: EventColors.tertiarygreen),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: EventColors.primarygreen, width: 2),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.elliptical(20, 20),
                        bottomLeft: Radius.elliptical(20, 20),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  menuMaxHeight: 250,
                  itemHeight: 50,
                ),
                if (selectedItem == "Other") ...[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      controller: FormUtils.customItemController,
                      decoration: InputDecoration(
                        labelText: 'Enter Custom Item',
                        labelStyle: TextStyle(color: Colors.black),
                        hintStyle: TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: EventColors.pgreen,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.elliptical(20, 20),
                            bottomRight: Radius.elliptical(20, 20),
                          ),
                          borderSide: BorderSide(
                              width: 1, color: EventColors.tertiarygreen),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: EventColors.primarygreen, width: 2),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.elliptical(20, 20),
                            bottomLeft: Radius.elliptical(20, 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(),
                      onPressed: addCustomItem,
                      child: Text('Add Item'),
                    ),
                  ),
                ],
                Padding(
                  padding: EdgeInsets.all(25.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10.0),
                      elevation: 15.0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: EventColors.primarygreen,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      minimumSize: Size(65.0, 40.0),
                      backgroundColor: EventColors.primarygreen,
                    ),
                    onPressed: _saveForm,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Save',
                          style: TextStyle(
                              fontSize: 20, color: EventColors.pgreen),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.send,
                          size: 20,
                          color: EventColors.pgreen,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
