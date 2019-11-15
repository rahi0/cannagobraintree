
import 'dart:convert';
import 'package:canna_go_dev/api/api.dart';
import 'package:canna_go_dev/customPlugin/routeTransition/routeAnimation.dart';
import 'package:canna_go_dev/form/logInForm/logInForm.dart';
import 'package:canna_go_dev/widget/bottomAppBar/bottomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CannabisSubmitForm extends StatefulWidget { 
  @override
  _CannabisSubmitFormState createState() => _CannabisSubmitFormState();
}

class _CannabisSubmitFormState extends State<CannabisSubmitForm>{
  // _showMsg(msg) { //
  //   final snackBar = SnackBar(
  //     content: Text(msg),
  //     action: SnackBarAction(
  //       label: 'Close',
  //       onPressed: () {
  //         // Some code to undo the change!
  //       },
  //     ),
  //   );
  //   Scaffold.of(context).showSnackBar(snackBar);
  //  }
bool _isLoading = false;
TextEditingController cannabisController = TextEditingController();

 var now = new DateTime.now();
  String dayCheck = "";
  String yearCheck = "";
  String monthCheck="Month";

   @override
  void initState() {
    _getYear();

    super.initState();
  }

   List _yr = [];

  void _getYear() {
    _yr.insert(0, 'Year');

    for (var yy = now.year - 60; yy <= now.year + 20; yy++) {
      _yr.add(yy.toString());
    }
  }
  var _months = [
    'Month',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  var _currentMonthsSelected = 'Month';

 
  var _currentYearSelected = 'Year';

  var _dayThirtyOne = [
    'Day',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];

  var _dayThirty = [
    'Day',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30'
  ];

  var _dayTwentyEight = [
    'Day',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28'
  ];

  var _dayTwentyNine = [
    'Day',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29'
  ];
  var _currentDaySelected = 'Day';

 void _dropDownMonthSelected(String newValueSelected) {
    setState(() {
      this._currentMonthsSelected = newValueSelected;
      monthCheck = newValueSelected;
      _currentDaySelected = 'Day';
      if (newValueSelected == 'April' ||
          newValueSelected == 'June' ||
          newValueSelected == 'September' ||
          newValueSelected == 'November') {
           
        dayCheck = "Thirty";
      } else if (newValueSelected == 'February') {
         

        if ((int.parse(yearCheck) % 4 == 0) &&
            ((int.parse(yearCheck) % 100 != 0) ||
                (int.parse(yearCheck) % 400 == 0))) {

        
          dayCheck = "Twenty Nine";
         
        } else {
            
          dayCheck = "Twenty Eight";

        }
      } else {
      
        dayCheck = "Thirty One";
      }
    });
  }

  void _dropDownYearSelected(String newValueSelected) {
    setState(() {
      this._currentYearSelected = newValueSelected;
      yearCheck = newValueSelected;
    _dropDownMonthSelected(monthCheck);



    });
  }

  void _dropDownDaySelected(String newValueSelected) {
    setState(() {
      this._currentDaySelected = newValueSelected;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        //color: Colors.blue,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(10, 30, 10, 20),
        child: Column(
          children: <Widget>[
            ///////Name Field start//////
            Container(
              //color: Colors.red,
              margin: EdgeInsets.only(bottom: 5),
              padding: EdgeInsets.only(bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    //width: 300,
                    margin: EdgeInsets.only(left: 20, top: 10, bottom: 8),
                    child: Text(
                      "Medical Cannabis",
                      textAlign: TextAlign.left,
                       style: TextStyle(
                                color: Colors.black,
                                fontFamily: "sourcesanspro",
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    //width: 350,
                    decoration: BoxDecoration(
                      //color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey[200],
                   // offset: Offset(1.0, 2.0),
                    blurRadius: 14.0,
                  ),
                ],
                    ),
                    height: 40,
                    child: TextField(
                      controller: cannabisController,
                      style:TextStyle(
                            color: Color(0xFF606060),
                            fontSize: 15,
                            fontFamily: "sourcesanspro",
                            fontWeight: FontWeight.normal),
                      cursorColor: Color(0xFF9b9b9b),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                BorderSide(color: Color(0xFFFFFFFF))),
                        enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                BorderSide(color: Color(0xFFFFFFFF))),
                        hintText: "Type here",
                        hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: "sourcesanspro",
                            fontWeight: FontWeight.normal),
                        contentPadding:
                            EdgeInsets.only(left: 20, bottom: 12, top: 12),
                        fillColor: Color(0xFFFFFFFF),
                        filled: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ///////Name Field end//////

            ///////Expiration Field start//////
            Container(
              //color: Colors.red,
              margin: EdgeInsets.only(bottom: 5),
              padding: EdgeInsets.only(bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left: 20, top: 10, bottom: 5),
                    child: Text(
                      "Medical Cannabis Expiration",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                           color: Color(0xFF343434),
                          fontFamily: "sourcesanspro",
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                               /////////// year dropdown ///////
                    Container(
                      width: MediaQuery.of(context).size.width / 3 - 30,
                      height: 40,
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(20),
                         boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey[200],
                   // offset: Offset(1.0, 2.0),
                    blurRadius: 14.0,
                  ),
                ],
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          items: _yr.map((var dropDownStringItem) {
                            return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    dropDownStringItem,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "sourcesanspro",
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ));
                          }).toList(),
                          onChanged: (String newValueSelected) {
                            _dropDownYearSelected(newValueSelected);
                          },
                          value: _currentYearSelected,
                        ),
                      ),
                    ),
                    /////////// month dropdown ///////
                    Container(
                      width: MediaQuery.of(context).size.width / 3 - 3,
                      height: 40,
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(20),
                         boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey[200],
                   // offset: Offset(1.0, 2.0),
                    blurRadius: 14.0,
                  ),
                ],
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          items: _months.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    dropDownStringItem,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "sourcesanspro",
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ));
                          }).toList(),
                          onChanged: (String newValueSelected) {
                            _dropDownMonthSelected(newValueSelected);
                          },
                          value: _currentMonthsSelected,
                        ),
                      ),
                    ),
                    /////////// day dropdown ///////
                    Container(
                      width: MediaQuery.of(context).size.width / 3 - 35,
                      height: 40,
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey[200],
                   // offset: Offset(1.0, 2.0),
                    blurRadius: 14.0,
                  ),
                ],
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          items: dayCheck == "Twenty Eight"
                              ? _dayTwentyEight
                                  .map((String dropDownStringItem) {
                                  return DropdownMenuItem<String>(
                                      value: dropDownStringItem,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(left: 20),
                                        child: Text(
                                          dropDownStringItem,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "sourcesanspro",
                                              fontSize: 15,
                                              fontWeight:
                                                  FontWeight.normal),
                                        ),
                                      ));
                                }).toList()
                              : dayCheck == "Twenty Nine"
                                  ? _dayTwentyNine
                                      .map((String dropDownStringItem) {
                                      return DropdownMenuItem<String>(
                                          value: dropDownStringItem,
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(left: 20),
                                            child: Text(
                                              dropDownStringItem,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color:
                                                     Colors.black,
                                                  fontFamily:
                                                      "sourcesanspro",
                                                  fontSize: 15,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ));
                                    }).toList()
                                  : dayCheck == "Thirty One"
                              ? _dayThirtyOne
                                  .map((String dropDownStringItem) {
                                  return DropdownMenuItem<String>(
                                      value: dropDownStringItem,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(left: 20),
                                        child: Text(
                                          dropDownStringItem,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "sourcesanspro",
                                              fontSize: 15,
                                              fontWeight:
                                                  FontWeight.normal),
                                        ),
                                      ));
                                }).toList():_dayThirty
                                      .map((String dropDownStringItem) {
                                      return DropdownMenuItem<String>(
                                          value: dropDownStringItem,
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(left: 20),
                                            child: Text(
                                              dropDownStringItem,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color:
                                                      Colors.black,
                                                  fontFamily:
                                                      "sourcesanspro",
                                                  fontSize: 15,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ));
                                    }).toList(),
                          onChanged: (String newValueSelected) {
                            _dropDownDaySelected(newValueSelected);
                          },
                          value: _currentDaySelected,
                        ),
                      ),
                    ),
         
                  ],
                ),
              )
                ],
              ),
            ),

            ///////Expiration Field end//////
            


            /////////////////  Button Section Start///////////////
                        ///
                        ///
                    Container(
                          margin: EdgeInsets.only(top: 40),
                          padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                          //color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ///////////////// Back Button  Start///////////////
               
                                      ///////////////// Back Button  end///////////////


                                      ///////////////// Next In Button  Start///////////////
                      



                      Container(
                                      decoration: BoxDecoration(color: Color(0xFF00CE7C), borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                                      ),
                                     // width: 120,
                                      height: 42,
                                     // padding: EdgeInsets.only(left: 10, right: 10),
                                      child: FlatButton(
                                        disabledColor: Colors.grey,
                                        child: Text(
                                          _isLoading ?'Saving...':'Done',
                                          
                                          //textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.0,
                                              decoration: TextDecoration.none,
                                              fontFamily: 'MyriadPro',
                                              fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        color: Colors.transparent,
                                        //elevation: 4.0,
                                        //splashColor: Colors.blueGrey,
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(20.0)),
                                        onPressed: _isLoading ? null : _registerButton2,
                                        // () {
                                        //   //Navigator.push( context, SlideLeftRoute(page: CannabisPage()));
                                        //   print("object");
                                        //   _o();
                                        // },
                                      )),

                                      ///////////////// Next In Button  End///////////////



                                     

                    ],
                  ),
                )

             /////////////////  Button Section End///////////////
          ],
        ),
      ),
    );
  }


  void _registerButton2() async{

   SharedPreferences localStorage = await SharedPreferences.getInstance();

    // if(cannabisController.text.isEmpty){
    //     return _showMsg("Medical Cannabis is empty");
    //   }

     if(cannabisController.text.isEmpty){
        return showMsg(context, "Licence is empty");
      }
      else if( _currentYearSelected=="Year"){
        return showMsg(context, "Year is empty");
      }
      else if(_currentMonthsSelected=='Month'){
        return showMsg(context, "Month is empty");
      }
      else if( _currentDaySelected=='Day'){
        return showMsg(context, "Day is empty");
      }
      
      


    setState(() {
       _isLoading = true;
    });
   
    print('selectedDate');
    print("$_currentYearSelected - $_currentMonthsSelected - $_currentDaySelected",);
     var userJsonString = localStorage.getString('user');
     var user = json.decode(userJsonString);
     print(user);
     print(user['id']);


      var data = {
        'userId' : user['id'],
        'medicalCannabis' : cannabisController.text,
        'medicalCannabisExpiration' : "$_currentYearSelected - $_currentMonthsSelected - $_currentDaySelected",
     };

     print(data);
    
   
      var res = await CallApi().postData(data, '/auth/registerGo');
    var body = json.decode(res.body);
    print(body);
    
    if(body['success']){
    //  // SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));
      localStorage.setString('cannago', json.encode(body['cannago']));
       
       Navigator.of(context).pop();
     // _showDialog("License Submitted Successfully");
        
    //   }else{
    //     print('user is not updated');
       }


     setState(() {
        _isLoading = false;
     });


    
  }


  void _showDialog(msg) {
    // flutter defined function
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              backgroundColor: Colors.white,
              content: new Text(msg,
              style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      decoration: TextDecoration.none,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.normal,
                    ),
              ),
              //content: new Text("Alert Dialog body"),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("Done"),
                  onPressed: () {
                    Navigator.push(context, SlideLeftRoute(page: Navigation()));
                  },
                ),
              ],
            );
          },
        );
  }
}