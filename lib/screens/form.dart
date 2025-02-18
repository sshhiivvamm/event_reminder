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

class _FormDataState extends State<FormData> with TickerProviderStateMixin {
  String selectedDate = "";
  String? selectedItem;
  List<bool> fieldVisibility = List.generate(10, (index) => false);
  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      10, // Adjust based on the number of fields
      (index) => AnimationController(
        duration: Duration(milliseconds: 2 * (index + 1)),
        vsync: this,
      ),
    );
    _animations = _controllers
        .map((controller) => Tween<Offset>(
              begin: Offset(-2, -1), // Slide in from the right
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: controller,
              curve: Curves.bounceIn,
            )))
        .toList();

    _animateFields();
  }

  // Method to animate fields one by one
  void _animateFields() async {
    for (int i = 0; i < _controllers.length; i++) {
      await Future.delayed(
          Duration(milliseconds: 12 * i)); // Delay between each field
      _controllers[i].forward();
    }
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
  void dispose() {
    // Clean up the controllers when no longer needed
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
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
            child: SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 11,
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                      animation: _controllers[index],
                      builder: (context, child) {
                        return SlideTransition(
                            position: _animations[index],
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 2,
                                ),
                                if (index == 0)
                                  ReminderField(
                                      labelText: 'Company Name',
                                      icon: Icon(
                                        Icons.villa_outlined,
                                        size: 28,
                                      ),
                                      keyboardType: TextInputType.text,
                                      controller:
                                          FormUtils.companyNameController),
                                if (index == 1)
                                  ReminderField(
                                      labelText: 'Address',
                                      keyboardType: TextInputType.streetAddress,
                                      icon: Icon(
                                        Icons.location_on_outlined,
                                        size: 28,
                                      ),
                                      controller: FormUtils.addressController),
                                if (index == 2)
                                  ReminderField(
                                      labelText: 'GST',
                                      keyboardType: TextInputType.text,
                                      icon: Icon(
                                        Icons.trending_up,
                                        size: 28,
                                      ),
                                      controller: FormUtils.gstNoController),
                                if (index == 3)
                                  ReminderField(
                                      labelText: 'Certification Body',
                                      keyboardType: TextInputType.text,
                                      icon: Icon(
                                        Icons.account_circle_outlined,
                                        size: 28,
                                      ),
                                      controller: FormUtils.cbController),
                                if (index == 4)
                                  ReminderField(
                                      labelText: 'Contact',
                                      keyboardType: TextInputType.text,
                                      icon: Icon(
                                        Icons.call,
                                        size: 28,
                                      ),
                                      controller:
                                          FormUtils.contactInfoController),
                                if (index == 5)
                                  ReminderField(
                                      labelText: 'Basic Amount',
                                      keyboardType: TextInputType.number,
                                      icon: Icon(
                                        Icons.currency_rupee_sharp,
                                        size: 28,
                                      ),
                                      controller:
                                          FormUtils.basicAmountController),
                                if (index == 6)
                                  ReminderField(
                                      labelText: 'Reference',
                                      keyboardType: TextInputType.multiline,
                                      icon: Icon(
                                        Icons.person,
                                        size: 28,
                                      ),
                                      controller:
                                          FormUtils.referenceController),
                                if (index == 7)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 10, top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: TextFormField(
                                            keyboardType: TextInputType.none,
                                            controller: FormUtils
                                                .originalIssueDateController,
                                            decoration: InputDecoration(
                                              label: Text('Cerificate Issued'),
                                              filled: true,
                                              fillColor: EventColors.pgreen,
                                              labelStyle: TextStyle(
                                                  color: Colors.black),
                                              hintStyle: TextStyle(
                                                  color: Colors.black),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.elliptical(20, 20),
                                                  bottomRight:
                                                      Radius.elliptical(20, 20),
                                                ),
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: EventColors
                                                        .tertiarygreen),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: EventColors
                                                        .primarygreen,
                                                    width: 2),
                                                borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.elliptical(20, 20),
                                                  bottomLeft:
                                                      Radius.elliptical(20, 20),
                                                ),
                                              ),
                                              prefixIcon:
                                                  Icon(Icons.date_range),
                                              prefixIconColor:
                                                  EventColors.primarygreen,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 35,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: FloatingActionButton(
                                            onPressed: () {
                                              selectDate(isExpiryDate: false);
                                            },
                                            backgroundColor:
                                                EventColors.primarygreen,
                                            foregroundColor: EventColors.pgreen,
                                            child: Icon(Icons.calendar_today),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                if (index == 8)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 10, top: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: TextFormField(
                                            keyboardType: TextInputType.none,
                                            controller:
                                                FormUtils.expDateController,
                                            decoration: InputDecoration(
                                              label: Text('Cerificate Expiry'),
                                              filled: true,
                                              labelStyle: TextStyle(
                                                  color: Colors.black),
                                              hintStyle: TextStyle(
                                                  color: Colors.black),
                                              fillColor: EventColors.pgreen,
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.elliptical(20, 20),
                                                  bottomRight:
                                                      Radius.elliptical(20, 20),
                                                ),
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: EventColors
                                                        .tertiarygreen),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: EventColors
                                                        .primarygreen,
                                                    width: 2),
                                                borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.elliptical(20, 20),
                                                  bottomLeft:
                                                      Radius.elliptical(20, 20),
                                                ),
                                              ),
                                              prefixIcon:
                                                  Icon(Icons.date_range),
                                              prefixIconColor:
                                                  EventColors.primarygreen,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 35,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: FloatingActionButton(
                                            onPressed: () {
                                              selectDate(isExpiryDate: true);
                                            },
                                            backgroundColor:
                                                EventColors.primarygreen,
                                            foregroundColor: EventColors.pgreen,
                                            child: Icon(Icons.calendar_today),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                if (index == 9)
                                  DropdownButtonFormField<String>(
                                    padding: EdgeInsets.only(
                                        left: 20.0,
                                        right: 20.0,
                                        top: 20.0,
                                        bottom: 10.0),
                                    isExpanded:
                                        true, // Ensures the dropdown takes up full width
                                    isDense: false, // Avoids compact height
                                    style: TextStyle(
                                      color: EventColors
                                          .white, // Selected item text color
                                      fontSize:
                                          20, // Optional: Adjust text size
                                    ),
                                    value: selectedItem,
                                    hint: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Select Certificate",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: EventColors
                                              .black, // Hint text color
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
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          alignment:
                                              AlignmentDirectional.bottomStart,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                color: EventColors
                                                    .black, // Item text color
                                                fontSize:
                                                    16, // Adjust text size
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color:
                                                    EventColors.primarygreen),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5.0, horizontal: 10),
                                          child: Text(
                                            "Add +",
                                            style: TextStyle(
                                              color: EventColors
                                                  .black, // "Other" item text color
                                              fontSize: 16, // Adjust text size
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                    selectedItemBuilder:
                                        (BuildContext context) {
                                      return FormUtils.dropdownItems
                                          .map<Widget>((String item) {
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                            15,
                                            7,
                                            5,
                                            7,
                                          ),
                                          child: Text(
                                            item,
                                            style: TextStyle(
                                              color: EventColors
                                                  .black, // Text color when selected
                                              fontSize: 16, // Adjust text size
                                            ),
                                          ),
                                        );
                                      }).toList();
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: EventColors.pgreen,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            20.0), // Border radius for the dropdown button
                                        borderSide: BorderSide(
                                            color: EventColors.pgreen,
                                            width: 1.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.elliptical(20, 20),
                                          bottomRight:
                                              Radius.elliptical(20, 20),
                                        ),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: EventColors.tertiarygreen),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: EventColors.primarygreen,
                                            width: 2),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.elliptical(20, 20),
                                          bottomLeft: Radius.elliptical(20, 20),
                                        ),
                                      ),
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 5.0),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    // Set a maximum height for the dropdown menu to allow scrolling
                                    menuMaxHeight: 250,
                                    itemHeight: 50,
                                    // dropdownMaxHeight: 300, // Customize the dropdown max height (optional)
                                  ),
                                if (selectedItem == "Other") ...[
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: TextField(
                                      controller:
                                          FormUtils.customItemController,
                                      decoration: InputDecoration(
                                        labelText: 'Enter Custom Item',
                                        labelStyle:
                                            TextStyle(color: Colors.black),
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        filled: true,
                                        fillColor: EventColors.pgreen,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.elliptical(20, 20),
                                            bottomRight:
                                                Radius.elliptical(20, 20),
                                          ),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: EventColors.tertiarygreen),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: EventColors.primarygreen,
                                              width: 2),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.elliptical(20, 20),
                                            bottomLeft:
                                                Radius.elliptical(20, 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: ElevatedButton(
                                      style: ButtonStyle(),
                                      onPressed: addCustomItem,
                                      child: Text('Add Item'),
                                    ),
                                  ),
                                ],
                                if (index == 10)
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
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            minimumSize: Size(65.0, 40.0),
                                            backgroundColor:
                                                EventColors.pgreen),
                                        onPressed: () {},
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Save',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: EventColors.textcolor),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              Icons.send,
                                              size: 20,
                                              color: EventColors.textcolor,
                                            )
                                          ],
                                        )),
                                  ),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            ));
                      });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
