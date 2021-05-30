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
    //firstDate: DateTime(2020),
    firstDate: DateTime.now().subtract(Duration(days: 730)),
    //lastDate: DateTime(2035),
    lastDate: DateTime.now().add(Duration(days: 30)),
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