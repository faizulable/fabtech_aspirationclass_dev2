import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<String> callDatePicker(BuildContext context) async {
  DateTime now = DateTime.now();
  var formatter = new DateFormat('dd-MM-yyyy');
  var selectDate = await getDate(context) ?? now;
  String formattedDate = formatter.format(selectDate);
  return formattedDate.toString();
}

// future method for datePicker
Future<DateTime> getDate(BuildContext context) {
  return showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    helpText: 'Select Date of Admission',
    firstDate: DateTime(2020),
    lastDate: DateTime(2050),
    builder: (BuildContext context, Widget child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(primary: Colors.purple),
        ),
        child: child,
      );
    },
  );
}