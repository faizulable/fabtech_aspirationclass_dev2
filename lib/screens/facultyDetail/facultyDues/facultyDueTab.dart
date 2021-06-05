import 'package:flutter/material.dart';

class FacultyDueTab extends StatefulWidget {
  @override
  _FacultyDueTabState createState() => _FacultyDueTabState();
}

class _FacultyDueTabState extends State<FacultyDueTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple.shade600, Colors.teal.shade400]
        ),
      ),
      child: Center(
        child: Text('Payment Received'),
      ),
    );
  }
}
