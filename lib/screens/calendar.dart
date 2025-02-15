// calendar_screen.dart
import 'package:flutter/material.dart';
import 'package:event_reminder/utils/colors.dart';
import 'package:event_reminder/utils/page_utils/calendar_utils.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;
  int selectedDate = DateTime.now().day;

  // Scroll controller to auto-scroll to current date
  final ScrollController _scrollController = ScrollController();

  // Function to pick a date from the date picker
  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(selectedYear, selectedMonth, selectedDate),
      barrierColor: Colors.transparent.withAlpha(220),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null &&
        pickedDate != DateTime(selectedYear, selectedMonth, selectedDate)) {
      setState(() {
        selectedYear = pickedDate.year;
        selectedMonth = pickedDate.month;
        selectedDate = pickedDate.day;
      });
      _scrollToCurrentDate(); // Scroll to the selected date after picking a date
    }
  }

  @override
  void initState() {
    super.initState();
    // Scroll to the current date when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentDate();
    });
  }

  // Scroll to the current date position
  void _scrollToCurrentDate() {
    List<int> daysInSelectedMonth = getDaysInMonth(selectedYear, selectedMonth);
    int index = daysInSelectedMonth.indexOf(selectedDate);
    if (index != -1) {
      _scrollController.jumpTo(
          index * 56.0); // Adjust scroll position based on the item size (60px)
    }
  }

  @override
  Widget build(BuildContext context) {
    List<int> daysInSelectedMonth = getDaysInMonth(selectedYear, selectedMonth);

    return Scaffold(
      backgroundColor: EventColors.bg,
      appBar: AppBar(
        title: Text("Calendar", style: TextStyle(color: EventColors.primarygreen)),
        backgroundColor: EventColors.bg,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Month Selection
          monthSelectionWidget(
            months: months,
            selectedMonth: selectedMonth,
            onMonthSelected: (month) {
              setState(() {
                selectedMonth = month;
                selectedDate = 1; // Reset to first day of the month
              });
              _scrollToCurrentDate(); // Scroll to current date after month change
            },
          ),

          SizedBox(height: 10),

          // Date Selection
          dateSelectionWidget(
            selectedDate: selectedDate,
            daysInSelectedMonth: daysInSelectedMonth,
            onDateSelected: (day) {
              setState(() {
                selectedDate = day;
              });
              _scrollToCurrentDate(); // Scroll to selected date when clicked
            },
            scrollController: _scrollController,
          ),

          SizedBox(height: 20),

          // Task Display
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_today, color: Colors.grey, size: 80),
                  SizedBox(height: 10),
                  Text(
                    "No Task At this Date\nTap To Add",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Button to Jump to Desired Date
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: _selectDate,
          style: ElevatedButton.styleFrom(
            backgroundColor: EventColors.primarygreen,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            'Jump to Date',
            style: TextStyle(color: EventColors.white),
          ),
        ),
      ],
    );
  }
}
