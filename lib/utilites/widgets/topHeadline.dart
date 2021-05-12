import 'package:flutter/material.dart';

Container topContainer(String title, String subTitle)
{
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5,horizontal: 7),
    height: 110.0,
    decoration: BoxDecoration(
      color: Colors.teal.shade100,
      borderRadius: BorderRadius.all(Radius.circular(25)),
      shape: BoxShape.rectangle,
    ),
    child: SingleChildScrollView(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5.0),
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage('images/emblame.png'),
                    fit: BoxFit.fill
                ),
                shape: BoxShape.circle
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Center(
                      child: Text(title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'LemonMilkBold',
                        ),
                      ),
                    ),
                    width: 280.0,
                  ),
                  Container(
                    width: 250,
                    child: Center(
                      child: Text(subTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'LandasansMedium',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}