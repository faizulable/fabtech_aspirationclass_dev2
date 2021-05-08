import 'package:flutter/material.dart';
class PersonalTab extends StatefulWidget {
  @override
  _PersonalTabState createState() => _PersonalTabState();
}

class _PersonalTabState extends State<PersonalTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      child: Center(
        child: Text('Personal Details'),
      ),
    );
  }
}

/*class PersonalTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}*/

