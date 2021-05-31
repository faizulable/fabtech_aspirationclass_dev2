import 'package:flutter/material.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/topHeadline.dart';
import 'package:fabtech_aspirationclass_dev/screens/paymentDetail/dues/listWidgetDue.dart';

class DueTab extends StatefulWidget {
  final String facultyId,subject,studentId,studentName;
  DueTab({this.facultyId,this.subject,this.studentId,this.studentName});
  @override
  _DueTabState createState() => _DueTabState();
}

class _DueTabState extends State<DueTab> {
  String _facultyNameStr = 'Teacher Name';
  String _totalAmountStr = '0000';
  List<DueList> _dueList;


  @override
  void initState() {
    _dueList = [];
    _dueList.add(DueList('APRIL','400','220','180'));
    _dueList.add(DueList('MAY','400','220','180'));
    _dueList.add(DueList('JUNE','400','220','180'));
    _dueList.add(DueList('JULY','400','220','180'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(width: MediaQuery.of(context).size.width,
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
            topContainer(widget.studentName,widget.subject + ' (DUES)'),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5,horizontal: 7),
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
              height: 40.0,
              decoration: BoxDecoration(
                color: Colors.teal.shade100,
                borderRadius: BorderRadius.all(Radius.circular(25)),
                shape: BoxShape.rectangle,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Teacher: ',
                      style: amountHeadingTextStyle),
                  Text(_facultyNameStr,
                      style: amountValueTextStyle),
                  SizedBox(width: 15),
                  Text('Amount: ',
                      style: amountHeadingTextStyle),
                  Text(_totalAmountStr,
                      style: amountValueTextStyle),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                      child: ListView.builder(
                        itemCount: _dueList.length,
                        itemBuilder:(BuildContext context, int index) {
                          return ListDueWidget(month: _dueList[index].month,due: _dueList[index].due,
                              aspShare: _dueList[index].aspShare,facShare: _dueList[index].facShare);
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: FloatingActionButton(
                        child: Icon(Icons.navigate_before),
                        onPressed: () {
                          //go back
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 100.0),
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
                child: Text('Add Payment'),
                onPressed: () async {
                  //TODO need to add code for accept payment
                },
              ),
            ),
            SizedBox(height: 5.0)
          ],
      ),
    );
  }
}

class DueList {
  final String month,due,aspShare,facShare;
  DueList(this.month,this.due,this.aspShare,this.facShare);
}

//Text Styling
const amountValueTextStyle = TextStyle(
  color: Colors.black54,
  fontSize: 20,
  fontFamily: 'LandasansMedium',
);

const amountHeadingTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 20,
  fontFamily: 'LandasansMedium',
);
