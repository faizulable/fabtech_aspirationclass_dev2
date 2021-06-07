import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fabtech_aspirationclass_dev/utilites/constantValue.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/topHeadline.dart';
import 'package:fabtech_aspirationclass_dev/utilites/stringListValues.dart';
import 'package:fabtech_aspirationclass_dev/screens/facultyDetail/facultyPaid/paidWidget.dart';
import 'package:fabtech_aspirationclass_dev/services/classFacultyStdList.dart';
import 'package:fabtech_aspirationclass_dev/models/appPref.dart';
import 'package:fabtech_aspirationclass_dev/main.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fabtech_aspirationclass_dev/models/TR002P.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/progress.dart';

class FacultyPaidTab extends StatefulWidget {
  final String classNum,subject,facultyName,facultyId;
  FacultyPaidTab({this.classNum,this.subject,this.facultyName,this.facultyId});
  @override
  _FacultyPaidTabState createState() => _FacultyPaidTabState();
}

class _FacultyPaidTabState extends State<FacultyPaidTab> {

  String _yearValue = yearList[0];
  String _monthValue = monthList[0];
  String _amountStr = '00000';
  List<PaymentList> _paymentList = [];
  bool _isLoading = true;


  @override
  void initState() {
    //get the previous month
    var now = new DateTime.now();
    var prevDateMonth = new DateTime(now.year, now.month - 1, now.day);
    var formatter = new DateFormat('MM');
    String prevMonth = formatter.format(prevDateMonth);
    formatter = new DateFormat('yyyy');
    String prevYear = formatter.format(prevDateMonth);
    monthList.forEach((element) {
      if(element == getMonthFrmNbr(prevMonth)){
        _monthValue = element;
      }
    });
    yearList.forEach((element) {
      if(element == prevYear){
        _yearValue = element;
      }
    });
    //
    //now call the method to get list from the server
    getPaymentDetails();
/*    _paymentList.add(PaymentList('SNKSUH6415','Sharuk Khan','05','160','05-06-2021'));
    _paymentList.add(PaymentList('SNKSUH6415','Sharuk Khan','05','160','05-06-2021'));
    _paymentList.add(PaymentList('SNKSUH6415','Sharuk Khan','05','160','05-06-2021'));
    _paymentList.add(PaymentList('SNKSUH6415','Sharuk Khan','05','160','05-06-2021'));
    _paymentList.add(PaymentList('SNKSUH6415','Sharuk Khan','05','160','05-06-2021'));
    _paymentList.add(PaymentList('SNKSUH6415','Sharuk Khan','05','160','05-06-2021'));
    _paymentList.add(PaymentList('SNKSUH6415','Sharuk Khan','05','160','05-06-2021'));
    _paymentList.add(PaymentList('SNKSUH6415','Sharuk Khan','05','160','05-06-2021'));
    _paymentList.add(PaymentList('SNKSUH6415','Sharuk Khan','05','160','05-06-2021'));
    _paymentList.add(PaymentList('SNKSUH6415','Sharuk Khan','05','160','05-06-2021'));*/

    super.initState();
  }

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
          topContainer(widget.facultyName,'CLASS ' + widget.classNum + ' PAYMENTS'),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5,horizontal: 7),
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.teal.shade100,
              borderRadius: BorderRadius.all(Radius.circular(25)),
              shape: BoxShape.rectangle,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton(
                  value: _yearValue,
                  onChanged: (newValue) {
                    setState(() {
                      _yearValue = newValue;
                      _isLoading = true;
                    });
                    getPaymentDetails();
                  },
                  items: yearList.map((year) {
                    return DropdownMenuItem(
                      child: Text(year),
                      value: year,
                    );
                  }).toList(),
                ),
                SizedBox(width: 5.0),
                DropdownButton(
                  value: _monthValue,
                  onChanged: (newValue) {
                    setState(() {
                      _monthValue = newValue;
                      _isLoading = true;
                    });
                    getPaymentDetails();
                  },
                  items: monthList.map((month) {
                    return DropdownMenuItem(
                      child: Text(month),
                      value: month,
                    );
                  }).toList(),
                ),
                SizedBox(width: 5.0),
                Text(_amountStr,
                    style: amountValueTextStyle),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5,horizontal: 7),
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.all(Radius.circular(25)),
              shape: BoxShape.rectangle,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 120.0,
                  child: Center(
                    child: Text(
                      'STD-ID',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: amountHeadingTextStyle,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      'DETAILS',
                      style: amountHeadingTextStyle,
                    ),
                  ),
                ),
                Container(
                  width: 100.0,
                  child: Center(
                    child: Text(
                      'AMOUNT',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: amountHeadingTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _isLoading ?  circularProgress() : ListView.builder(
              itemCount: _paymentList.length,
              itemBuilder: (BuildContext context, int index){
                return PaidWidget(studentId: _paymentList[index].studentId,name: _paymentList[index].name,
                    month: _paymentList[index].month,fees: _paymentList[index].fee, date: _paymentList[index].date);
              },
            ),
          ),
        ],
      ),
    );
  }

  //
  String getMonthFrmNbr(String monthVal){
    String returnValue = '';
    switch(monthVal){
      case "01": {
        returnValue = 'JAN';
        break;
      }
      case "02": {
        returnValue = 'FEB';
        break;
      }
      case "03": {
        returnValue = 'MAR';
        break;
      }
      case "04": {
        returnValue = 'APR';
        break;
      }
      case "05": {
        returnValue = 'MAY';
        break;
      }
      case "06": {
        returnValue = 'JUN';
        break;
      }
      case "07": {
        returnValue = 'JLY';
        break;
      }
      case "08": {
        returnValue = 'AUG';
        break;
      }
      case "09": {
        returnValue = 'SEP';
        break;
      }
      case "10": {
        returnValue = 'OCT';
        break;
      }
      case "11": {
        returnValue = 'NOV';
        break;
      }
      case "12": {
        returnValue = 'DEC';
        break;
      }
      default: {
        returnValue = 'SLT';
        break;
      }
    }
    return returnValue;
  }
  //
  //
  String getNbrFrmMonth(String monthVal){
    String returnValue = '';
    switch(monthVal){
      case "JAN": {
        returnValue = '01';
        break;
      }
      case "FEB": {
        returnValue = '02';
        break;
      }
      case "MAR": {
        returnValue = '03';
        break;
      }
      case "APR": {
        returnValue = '04';
        break;
      }
      case "MAY": {
        returnValue = '05';
        break;
      }
      case "JUN": {
        returnValue = '06';
        break;
      }
      case "JLY": {
        returnValue = '07';
        break;
      }
      case "AUG": {
        returnValue = '08';
        break;
      }
      case "SEP": {
        returnValue = '09';
        break;
      }
      case "OCT": {
        returnValue = '10';
        break;
      }
      case "NOV": {
        returnValue = '11';
        break;
      }
      case "DEC": {
        returnValue = '12';
        break;
      }
      default: {
        returnValue = '00';
        break;
      }
    }
    return returnValue;
  }
  //
  //
  getPaymentDetails() async {
    int totalAmount = 0;
    _paymentList.clear();
    try{
      ClassFacultyStdListService classFacultyStdListService = ClassFacultyStdListService(branchId: sp.getString(AppPref.userIdPref),
          classNum: widget.classNum,facultyId: widget.facultyId,subject: widget.subject);
      dynamic httpResult = await classFacultyStdListService.selectFacultyPayment(kgetFacultyPayments,getNbrFrmMonth(_monthValue),_yearValue);
      String positiveStatus = 'true';
      //failed as server end
      if(httpResult is String){
        EasyLoading.showToast(httpResult);
      }
      //data fetch from server end
      if(httpResult['status'] == positiveStatus) {
        //Data is fetch successfully
        httpResult['Data'].forEach((element){
          _paymentList.add(PaymentList(element[TR002P.studentIDFld], element[TR002P.nameFld], element[TR002P.monthFld],
              element[TR002P.perShareFacultyFld],element[TR002P.payDateFld]));
          totalAmount = totalAmount + int.parse(element[TR002P.perShareFacultyFld]);
        });
      }
      else {
        EasyLoading.showToast(httpResult['message']);
      }
    } catch (e) {
      EasyLoading.showToast(e.toString());
      setState(() {
        _isLoading = false;
        _amountStr = totalAmount.toString();
      });
    }
    //finally hide the progress bar
    setState(() {
      _isLoading = false;
      _amountStr = totalAmount.toString();
    });
  }
  //
}

class PaymentList
{
  final String studentId,name,month,fee,date;
  PaymentList(this.studentId,this.name,this.month,this.fee,
      this.date);
}

const amountValueTextStyle = TextStyle(
  color: Colors.black54,
  fontSize: 30,
  fontFamily: 'LandasansMedium',
);

const amountHeadingTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontFamily: 'Swansea',
);

