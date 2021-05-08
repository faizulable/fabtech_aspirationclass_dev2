import 'package:flutter/material.dart';

class SubjectTab extends StatefulWidget {
  @override
  _SubjectTabState createState() => _SubjectTabState();
}

class _SubjectTabState extends State<SubjectTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      child: Center(
        child: Text('Subject Details'),
      ),
    );
  }
}

/*class SubjectTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}*/

