import 'package:event_reminder/firebase/auth.dart';
import 'package:event_reminder/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String selectedDate = "";
  String? selectedItem;
  TextEditingController customItemController = TextEditingController();
  List<String> dropdownItems = [
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

  Future<void> selectDate() async {
    DateTime? selected = await showDatePicker(
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      context: context,
      initialDate: DateTime.now(),
    );
    if (selected != null) {
      setState(() {
        selectedDate = "${selected.toLocal()}".split(' ')[0];
      });
    }
  }

  void addCustomItem() {
    if (customItemController.text.isNotEmpty) {
      setState(() {
        dropdownItems
            .add(customItemController.text); // Add custom item to the list
        selectedItem = customItemController
            .text; // Set the selected item to the newly added custom item
        customItemController.clear(); // Clear the text field after adding
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await AuthService().signout(context: context);
              },
              icon: Icon(Icons.power_settings_new))
        ],
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu),
            );
          },
        ),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text("Event Reminder"),
        titleTextStyle:
            GoogleFonts.ptSerif(fontSize: 20, color: EventColors.white),
        backgroundColor: EventColors.tertiarygreen,
        elevation: 20.0,
      ),
      drawer: Drawer(
        width: 250,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: EventColors.tertiarygreen,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Text(
                'Menu',
                style: GoogleFonts.ptSerif(fontSize: 24, color: Colors.white),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                // Navigate to the Home page
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {
                // Navigate to the Settings page
                Navigator.pop(context);
              },
            ),
            // Add more list items as needed
          ],
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: EventColors.bg,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                enabled: true,
                cursorColor: EventColors.primarygreen,
                decoration: InputDecoration(
                  hintText: 'Firm Name',
                  enabled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        style: BorderStyle.solid,
                        color: EventColors.primarygreen),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                enabled: true,
                cursorColor: EventColors.primarygreen,
                decoration: InputDecoration(
                  hintText: 'Address',
                  enabled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        style: BorderStyle.solid,
                        color: EventColors.primarygreen),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 12.0, bottom: 10),
              child: DropdownButton<String>(
                borderRadius: BorderRadius.circular(20),
                isExpanded: false,
                style:
                    GoogleFonts.ptSerif(fontSize: 16, color: EventColors.black),
                value: selectedItem,
                hint: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Select Certificate :",
                    style: TextStyle(color: EventColors.black),
                  ),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedItem = newValue;
                  });
                },
                items: [
                  ...dropdownItems
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width *
                            0.75, // Limit width to 80% of the screen
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                            right: 12.0,
                          ),
                          child: Text(
                            value,
                            style: TextStyle(color: EventColors.black),
                          ),
                        ),
                      ),
                    );
                  }),

                  // "Other" option
                  DropdownMenuItem<String>(
                    value: "Other",
                    child: Text("Other"),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Issued Date : $selectedDate',
                    style: TextStyle(color: EventColors.black, fontSize: 20.0),
                  ),
                ),
                ElevatedButton(
                  onPressed: selectDate,
                  child: Text('Select Date'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Expiration Date : $selectedDate',
                    style: TextStyle(color: EventColors.black, fontSize: 20.0),
                  ),
                ),
                ElevatedButton(
                  onPressed: selectDate,
                  child: Text('Select Date'),
                ),
              ],
            ),
            if (selectedItem == "Other") ...[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: customItemController,
                  decoration: InputDecoration(
                    labelText: 'Enter Custom Item',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton(
                  onPressed: addCustomItem,
                  child: Text('Add Item'),
                ),
              ),
            ],
            ElevatedButton(onPressed: () {}, child: Text('Save the Date'))
          ],
        ),
      ),
    );
  }
}
