import 'package:flutter/material.dart';
import 'package:event_reminder/utils/colors.dart';
import 'package:intl/intl.dart';

final List<String> months = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
];

// Function to get the list of days in the selected month
List<int> getDaysInMonth(int year, int month) {
  int days = DateTime(year, month + 1, 0).day;
  return List.generate(days, (index) => index + 1);
}

// Function to format a day to weekday name (e.g., 'Mon', 'Tue')
String getWeekday(int year, int month, int day) {
  return DateFormat('E').format(DateTime(year, month, day));
}

// Widget for displaying month selection
Widget monthSelectionWidget({
  required List<String> months,
  required int selectedMonth,
  required Function(int) onMonthSelected,
}) {
  return SizedBox(
    height: 50,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: months.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            onMonthSelected(index + 1); // Update the month when selected
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: selectedMonth == index + 1
                  ? EventColors.primarygreen
                  : Colors.transparent,
            ),
            child: Text(
              months[index].substring(0, 3).toUpperCase(),
              style: TextStyle(
                color: selectedMonth == index + 1
                    ? Colors.white
                    : EventColors.primarygreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    ),
  );
}

// Widget for displaying date selection
Widget dateSelectionWidget({
  required int selectedDate,
  required List<int> daysInSelectedMonth,
  required Function(int) onDateSelected,
  required ScrollController scrollController,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
    child: SizedBox(
      height: 80,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: daysInSelectedMonth.length,
        itemBuilder: (context, index) {
          int day = daysInSelectedMonth[index];
          return GestureDetector(
            onTap: () {
              onDateSelected(day);
            },
            child: Container(
              width: 60,
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: selectedDate == day
                    ? EventColors.primarygreen
                    : Colors.transparent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    day.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      color: selectedDate == day
                          ? Colors.white
                          : EventColors.primarygreen,
                    ),
                  ),
                  Text(
                    getWeekday(selectedDate, selectedDate, day),
                    style: TextStyle(
                      color: selectedDate == day
                          ? Colors.white
                          : EventColors.primarygreen,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}
