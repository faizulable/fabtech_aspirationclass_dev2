import 'package:flutter/material.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/topHeadline.dart';
import 'package:fabtech_aspirationclass_dev/customPainter/LabelCustomPainter.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/BaseContainerL.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/BaseContainerR.dart';
class PersonalTab extends StatefulWidget {
  @override
  _PersonalTabState createState() => _PersonalTabState();
}

class _PersonalTabState extends State<PersonalTab> {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          topContainer('Md Faizul Haque','Class 05'),
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height/8,
                      padding: EdgeInsets.all(2.0),
                      child: BaseContainerRight(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomPaint(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Center(
                                  child: Text('Email Id',
                                    style: headingTextStyle,
                                  ),
                                ),
                              ),
                              painter: RPSCustomPainter(
                              ),
                            ),
                            Center(
                              child: Text('inzy.hak@gmail.com',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: amountHeadingTextStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height/8,
                          width: MediaQuery.of(context).size.width/2 - 5,
                          //padding: EdgeInsets.all(2.0),
                          child: BaseContainerLeft(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomPaint(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Center(
                                      child: Text('Contact Num',
                                        style: headingTextStyle,
                                      ),
                                    ),
                                  ),
                                  painter: RPSCustomPainter(
                                  ),
                                ),
                                Center(
                                  child: Text('9654341325',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: amountHeadingTextStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height/8,
                          width: MediaQuery.of(context).size.width/2 -5,
                          //padding: EdgeInsets.all(2.0),
                          child: BaseContainerLeft(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomPaint(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Center(
                                      child: Text('Gender',
                                        style: headingTextStyle,
                                      ),
                                    ),
                                  ),
                                  painter: RPSCustomPainter(
                                  ),
                                ),
                                Center(
                                  child: Text('Male',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: amountHeadingTextStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: MediaQuery.of(context).size.height/8,
                            //padding: EdgeInsets.all(2.0),
                            child: BaseContainerLeft(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomPaint(
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Center(
                                        child: Text('School',
                                          style: headingTextStyle,
                                        ),
                                      ),
                                    ),
                                    painter: RPSCustomPainter(
                                    ),
                                  ),
                                  Center(
                                    child: Text('The Frank Anthony Public school',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: amountHeadingTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 2.0),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: MediaQuery.of(context).size.height/8,
                            //padding: EdgeInsets.all(2.0),
                            child: BaseContainerLeft(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomPaint(
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Center(
                                        child: Text('Board',
                                          style: headingTextStyle,
                                        ),
                                      ),
                                    ),
                                    painter: RPSCustomPainter(
                                    ),
                                  ),
                                  Center(
                                    child: Text('ICSE',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: amountHeadingTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height/8,
                          //padding: EdgeInsets.all(2.0),
                          child: BaseContainerLeft(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomPaint(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Center(
                                      child: Text("Adm (Mm\\YY)",
                                        style: headingTextStyle,
                                      ),
                                    ),
                                  ),
                                  painter: RPSCustomPainter(
                                  ),
                                ),
                                Center(
                                  child: Text('04-2021',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: amountHeadingTextStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height/8,
                          //padding: EdgeInsets.all(2.0),
                          child: BaseContainerLeft(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomPaint(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Center(
                                      child: Text('Adm Fees',
                                        style: headingTextStyle,
                                      ),
                                    ),
                                  ),
                                  painter: RPSCustomPainter(
                                  ),
                                ),
                                Center(
                                  child: Text('1200',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: amountHeadingTextStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height/8,
                          //padding: EdgeInsets.all(2.0),
                          child: BaseContainerLeft(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomPaint(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Center(
                                      child: Text('Monthly Fees',
                                        style: headingTextStyle,
                                      ),
                                    ),
                                  ),
                                  painter: RPSCustomPainter(
                                  ),
                                ),
                                Center(
                                  child: Text('900',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: amountHeadingTextStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 25.0),
                          height: 60,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.teal.shade400),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20),),
                                ),
                              ),
                            ),
                            //icon: Icon(Icons.exit_to_app_rounded),
                            child: Text('Promoted'),
                            onPressed: () async {
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 25.0),
                          height: 60,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.red.shade400),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20),),
                                ),
                              ),
                            ),
                            //icon: Icon(Icons.exit_to_app_rounded),
                            child: Text('Deactivate'),
                            onPressed: () async {
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const amountHeadingTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 20,
  fontFamily: 'ApeMount',
);

const headingTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 25,
  fontFamily: 'Overtaking',
);
