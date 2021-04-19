import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BaseContainerLeft extends StatelessWidget {
  final Widget child;
  double width;
  double hight;
  BaseContainerLeft({this.child, this.width, this.hight});

  final kInnerDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Colors.white),
    borderRadius: BorderRadius.only(topLeft: Radius.circular(25),bottomRight: Radius.circular(25)),
  );

  final kGradientBoxDecoration = BoxDecoration(
    gradient: LinearGradient(colors: [Colors.black, Colors.redAccent]),
    borderRadius: BorderRadius.only(topLeft: Radius.circular(25),bottomRight: Radius.circular(25)),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: hight,
      decoration: kGradientBoxDecoration,
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: Container(
          decoration: kInnerDecoration,
          child: child,
        ),
      ),
    );
  }
}