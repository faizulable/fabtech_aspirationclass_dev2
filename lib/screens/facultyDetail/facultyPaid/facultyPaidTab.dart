import 'package:flutter/material.dart';

class FacultyPaidTab extends StatefulWidget {
  @override
  _FacultyPaidTabState createState() => _FacultyPaidTabState();
}

class _FacultyPaidTabState extends State<FacultyPaidTab> {
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
