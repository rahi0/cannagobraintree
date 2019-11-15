import 'dart:convert';
import 'dart:io';

import 'package:canna_go_dev/api/api.dart';
// import 'package:canna_go_dev/screen/CountryDetails/CountryDetails.dart';
// import 'package:canna_go_dev/screen/CountryDetails/CountryModel.dart';
//import 'package:canna_go_dev/form/registrationForm/imagePicker/image_picker_handler.dart';
import 'package:canna_go_dev/screen/cannabisPage/cannabisPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:canna_go_dev/form/logInForm/logInForm.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

//import 'package:flutter_country_picker/flutter_country_picker.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

enum PhotoCrop {
  free,
  picked,
  cropped,
}

class _RegistrationFormState extends State<RegistrationForm>
    with TickerProviderStateMixin
//,ImagePickerListener
{
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

/////
  // File _image;
  // AnimationController _controller;
  // ImagePickerHandler imagePicker;

  var now = new DateTime.now();
  String dayCheck = "";
  String yearCheck = "";
  String monthCheck = "Month";
  bool _isUpload;
  String image;
  var imagePath = null;
  bool _isImage = false;

  // Country _selected = Country(
  //     asset: "assets/flags/us_flag.png",
  //     dialingCode: "1",
  //     isoCode: "US",
  //     name: "Select Country");

  PhotoCrop state;

  File imageFile;

  @override
  void initState() {
    state = PhotoCrop.free;
    _getYear();

    super.initState();
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }
  ////

  List _yr = [];

  void _getYear() {
    _yr.insert(0, 'Year');

    for (var yy = now.year - 60; yy <= now.year + 20; yy++) {
      _yr.add(yy.toString());
    }
  }

  // var _countries = ['Select Country', 'United state america', 'Others'];
  // var _currentCountrySelected = 'Select Country';

  // var _states = ['Select State', 'California', 'Others'];
  // var _currentStateSelected = 'Select State';

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

  // void _groweronDropDownCountrySelected(String newValueSelected) {
  //   setState(() {
  //     this._currentCountrySelected = newValueSelected;

  //   });
  // }

  // void _groweronDropDownCitySelected(String newValueSelected) {
  //   setState(() {
  //     this._currentStateSelected = newValueSelected;
  //   });
  // }

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

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController stateController = TextEditingController();
   TextEditingController countryController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(15),
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.5),
        //     offset: Offset(1.0, 2.0),
        //     blurRadius: 5.0,
        //   ),
        // ],
      ),
      child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          //color: Colors.blue,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(10, 40, 10, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ///////////////  image  picker ////////////////
              _isImage
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ))
                  : Center(child: _buildButtonIcon()),

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
                      margin: EdgeInsets.only(left: 20, top: 10, bottom: 5),
                      child: Text(
                        "Name",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: "sourcesanspro",
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      //width: 350,
                      decoration: BoxDecoration(
                        //color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey[200],

                            /// offset: Offset(1.0, 2.0),
                            blurRadius: 8.0,
                          ),
                        ],
                      ),
                      height: 40,
                      child: TextField(
                        controller: nameController,
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Color(0xFF9b9b9b),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xFFFFFFFF))),
                          enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xFFFFFFFF))),
                          hintText: "Type here",
                          hintStyle: TextStyle(
                              color: Color(0xFF343434),
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

              ///////Email Field start//////
              Container(
                //color: Colors.red,
                margin: EdgeInsets.only(bottom: 5),
                padding: EdgeInsets.only(bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      //width: 300,
                      margin: EdgeInsets.only(left: 20, top: 10, bottom: 5),
                      child: Text(
                        "Email",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: "sourcesanspro",
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      //width: 350,
                      margin: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        //color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey[200],

                            /// offset: Offset(1.0, 2.0),
                            blurRadius: 8.0,
                          ),
                        ],
                      ),
                      height: 40,
                      child: TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Color(0xFF9b9b9b),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xFFFFFFFF))),
                          enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xFFFFFFFF))),
                          hintText: "Type here",
                          hintStyle: TextStyle(
                              color: Color(0xFF343434),
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

              ///////Email Field end//////

              ///////Phone Field start//////

              Container(
                //color: Colors.red,
                margin: EdgeInsets.only(bottom: 5),
                padding: EdgeInsets.only(bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      //width: 300,

                      margin: EdgeInsets.only(left: 20, top: 10, bottom: 5),
                      child: Text(
                        "Phone",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: "sourcesanspro",
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      //width: 350,
                      margin: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        //color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey[200],

                            /// offset: Offset(1.0, 2.0),
                            blurRadius: 8.0,
                          ),
                        ],
                      ),
                      height: 40,
                      child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Color(0xFF9b9b9b),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xFFFFFFFF))),
                          enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xFFFFFFFF))),
                          hintText: "Type here",
                          hintStyle: TextStyle(
                              color: Color(0xFF343434),
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

              ///////Phone Field end//////

              ///////Password Field start//////
              Container(
                //color: Colors.red,
                margin: EdgeInsets.only(bottom: 5),
                padding: EdgeInsets.only(bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      //width: 300,
                      margin: EdgeInsets.only(left: 20, top: 10, bottom: 5),
                      child: Text(
                        "Password",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: "sourcesanspro",
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      //width: 350,

                      margin: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        //color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey[200],

                            /// offset: Offset(1.0, 2.0),
                            blurRadius: 8.0,
                          ),
                        ],
                      ),
                      height: 40,
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Color(0xFF9b9b9b),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xFFFFFFFF))),
                          enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xFFFFFFFF))),
                          hintText: "Type here",
                          hintStyle: TextStyle(
                              color: Color(0xFF343434),
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

              ///////Password Field end//////

              ///////Confirm Password Field start//////
              Container(
                //color: Colors.red,
                margin: EdgeInsets.only(bottom: 5),
                padding: EdgeInsets.only(bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      //width: 300,
                      margin: EdgeInsets.only(left: 20, top: 10, bottom: 5),
                      child: Text(
                        "Confirm Password",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: "sourcesanspro",
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      //width: 350,
                      decoration: BoxDecoration(
                        //color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey[200],

                            /// offset: Offset(1.0, 2.0),
                            blurRadius: 8.0,
                          ),
                        ],
                      ),
                      height: 40,
                      child: TextField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Color(0xFF9b9b9b),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xFFFFFFFF))),
                          enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xFFFFFFFF))),
                          hintText: "Type here",
                          hintStyle: TextStyle(
                              color: Color(0xFF343434),
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

              /////// Confirm Password Field end//////

              ///////Country and state//////
              Container(
                margin: EdgeInsets.only(bottom: 5),
                padding: EdgeInsets.only(bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      //width: 300,
                      //height: 30,
                      margin: EdgeInsets.only(left: 20, top: 15, bottom: 10),
                      child: Text(
                        "Country and State",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: "sourcesanspro",
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),

                    //////  country dropdown /////////

                    // Container(
                    //   margin: EdgeInsets.only(left: 10, right: 10),
                    //   alignment: Alignment.centerLeft,
                    //   padding: EdgeInsets.only(left: 10),
                    //   width: MediaQuery.of(context).size.width,
                    //   height: 40,
                    //   decoration: BoxDecoration(
                    //     color: Color(0xFFFFFFFF),
                    //     borderRadius: BorderRadius.circular(20),
                    //     boxShadow: <BoxShadow>[
                    //       BoxShadow(
                    //         color: Colors.grey[200],

                    //         /// offset: Offset(1.0, 2.0),
                    //         blurRadius: 8.0,
                    //       ),
                    //     ],
                    //   ),
                    //   child: CountryPicker(
                    //     dense: false,
                    //     showFlag: false,
                    //     //displays flag, true by default
                    //     showDialingCode:
                    //         false, //displays dialing code, false by default
                    //     showName: true, //displays country name, true by default
                    //     onChanged: (Country country) {
                    //       setState(() {
                    //         _selected = country;
                    //       });
                    //     },
                    //     selectedCountry: _selected,
                    //   ),
                    // ),

                          ////       country start  ///////////

                    Container(
                      // margin: EdgeInsets.only(top: 10),
                      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                      //width: 350,
                      decoration: BoxDecoration(
                        //color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey[200],

                            /// offset: Offset(1.0, 2.0),
                            blurRadius: 8.0,
                          ),
                        ],
                      ),
                      height: 40,
                      child: TextField(
                        controller: countryController,
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Color(0xFF9b9b9b),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xFFFFFFFF))),
                          enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xFFFFFFFF))),
                          hintText: "Type Country",
                          hintStyle: TextStyle(
                              color: Color(0xFF343434),
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

                    /// country end/////////////
                    ////       state start  ///////////

                    Container(
                      // margin: EdgeInsets.only(top: 10),
                      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                      //width: 350,
                      decoration: BoxDecoration(
                        //color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey[200],

                            /// offset: Offset(1.0, 2.0),
                            blurRadius: 8.0,
                          ),
                        ],
                      ),
                      height: 40,
                      child: TextField(
                        controller: stateController,
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Color(0xFF9b9b9b),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xFFFFFFFF))),
                          enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xFFFFFFFF))),
                          hintText: "Type State",
                          hintStyle: TextStyle(
                              color: Color(0xFF343434),
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

                    /// state end/////////////

                    // DropdownButtonHideUnderline(
                    //   child: DropdownButton<String>(
                    //     items: _countries.map((String dropDownStringItem) {
                    //       return DropdownMenuItem<String>(
                    //           value: dropDownStringItem,
                    //           child: Padding(
                    //             padding: EdgeInsets.only(left: 20),
                    //             child: Text(
                    //               dropDownStringItem,
                    //               textAlign: TextAlign.left,
                    //               style: TextStyle(
                    //                   color: Color(0xFF9b9b9b),
                    //                   fontFamily: "sourcesanspro",
                    //                   fontSize: 15,
                    //                   fontWeight: FontWeight.normal),
                    //             ),
                    //           ));
                    //     }).toList(),
                    //     onChanged: (String newValueSelected) {
                    //       _groweronDropDownCountrySelected(newValueSelected);
                    //     },
                    //     value: _currentCountrySelected,
                    //   ),
                    // ),
                    //   ),

                    // /////////// state dropdown ///////
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   height: 40,
                    //   margin: EdgeInsets.only(top: 10),
                    //   decoration: BoxDecoration(
                    //     color: Color(0xFFFFFFFF),
                    //     borderRadius: BorderRadius.circular(20),
                    //     boxShadow: <BoxShadow>[
                    //       BoxShadow(
                    //         color: Colors.black.withOpacity(0.5),
                    //         offset: Offset(1.0, 2.0),
                    //         blurRadius: 5.0,
                    //       ),
                    //     ],
                    //   ),
                    //   child: DropdownButtonHideUnderline(
                    //     child: DropdownButton<String>(
                    //       items: _states.map((String dropDownStringItem) {
                    //         return DropdownMenuItem<String>(
                    //             value: dropDownStringItem,
                    //             child: Padding(
                    //               padding: EdgeInsets.only(left: 20),
                    //               child: Text(
                    //                 dropDownStringItem,
                    //                 textAlign: TextAlign.left,
                    //                 style: TextStyle(
                    //                     color: Color(0xFF9b9b9b),
                    //                     fontFamily: "sourcesanspro",
                    //                     fontSize: 15,
                    //                     fontWeight: FontWeight.normal),
                    //               ),
                    //             ));
                    //       }).toList(),
                    //       onChanged: (String newValueSelected) {
                    //         _groweronDropDownCitySelected(newValueSelected);
                    //       },
                    //       value: _currentStateSelected,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),

              ///////Country and state end/////

              ///////Dob//////
              Container(
                margin: EdgeInsets.only(bottom: 5),
                padding: EdgeInsets.only(bottom: 5),
                width: MediaQuery.of(context).size.width,
                //color: Colors.blue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      //width: 300,
                      //height: 30,
                      margin: EdgeInsets.only(left: 15, top: 15),
                      child: Text(
                        "Birth of date",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: "sourcesanspro",
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
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

                                  /// offset: Offset(1.0, 2.0),
                                  blurRadius: 8.0,
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
                                              color: Color(0xFF343434),
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

                                  /// offset: Offset(1.0, 2.0),
                                  blurRadius: 8.0,
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
                                              color: Color(0xFF343434),
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

                                  /// offset: Offset(1.0, 2.0),
                                  blurRadius: 8.0,
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
                                                    color: Color(0xFF343434),
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
                                                            Color(0xFF343434),
                                                        fontFamily:
                                                            "sourcesanspro",
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ));
                                          }).toList()
                                        : dayCheck == "Thirty One"
                                            ? _dayThirtyOne.map(
                                                (String dropDownStringItem) {
                                                return DropdownMenuItem<String>(
                                                    value: dropDownStringItem,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 20),
                                                      child: Text(
                                                        dropDownStringItem,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF343434),
                                                            fontFamily:
                                                                "sourcesanspro",
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                      ),
                                                    ));
                                              }).toList()
                                            : _dayThirty.map(
                                                (String dropDownStringItem) {
                                                return DropdownMenuItem<String>(
                                                    value: dropDownStringItem,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 20),
                                                      child: Text(
                                                        dropDownStringItem,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF343434),
                                                            fontFamily:
                                                                "sourcesanspro",
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
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

              ///////Dob end/////

              /////////////////  Button Section Start///////////////
              ///
              ///
              Container(
                margin: EdgeInsets.only(top: 40),
                padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                //color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ///////////////// Back Button  Start///////////////
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        //padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Back',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            //decoration: TextDecoration.underline,
                            fontFamily: 'MyriadPro',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        color: Colors.transparent,
                      ),
                    ),
                    ///////////////// Back Button  end///////////////

                    ///////////////// Next In Button  Start///////////////

                    Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF00CE7C),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        //  width: 120,
                        height: 42,
                        child: FlatButton(
                          child: Text(
                            _isLoading ? "Please wait..." : 'Next',
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              decoration: TextDecoration.none,
                              fontFamily: 'MyriadPro',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          color: Colors.transparent,
                          disabledColor: Colors.grey,
                          //elevation: 4.0,
                          //splashColor: Colors.blueGrey,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0)),
                          onPressed: _isLoading ? null : _registerButton,
                          //             onPressed: (){
                          //                Navigator.push(context,
                          // new MaterialPageRoute(builder: (context) => CannabisPage()));
                          //             },
                        )),

                    ///////////////// Next In Button  End///////////////
                  ],
                ),
              )

              /////////////////  Button Section End///////////////
            ],
          ),
        ),
      ),
    );
  }

  void _uploadImage() async {
    setState(() {
      _isImage = true;
    });

    if (imageFile != null) {
      List<int> imageBytes = imageFile.readAsBytesSync();
      image = base64.encode(imageBytes);
      image = 'data:image/png;base64,' + image;
      var data = {'image': image};

      var res = await CallApi().postData(data, '/app/upload/images');
      var body = json.decode(res.body);
      imagePath = body["image_path"];
    } else {
      imagePath = null;
    }
    if (!mounted) return;
    setState(() {
      _isImage = false;
    });
  }

  void _registerButton() async {
    if (nameController.text.isEmpty) {
      return showMsg(context, "Name is empty");
    } else if (emailController.text.isEmpty) {
      return showMsg(context, "Email is empty");
    } else if (phoneController.text.isEmpty) {
      return showMsg(context, "Phone is empty");
    } else if (passwordController.text.isEmpty) {
      return showMsg(context, "Password is empty");
    } else if (passwordController.text != confirmPasswordController.text) {
      return showMsg(context, "Password doesn't match");
    } else if (phoneController.text.isEmpty) {
      return showMsg(context, "Phone is empty");
    } else if (countryController.text.isEmpty) {
      return showMsg(context, "Country is empty");
    } else if (stateController.text.isEmpty) {
      return showMsg(context, "State is empty");
    } else if (_currentYearSelected == "Year") {
      return showMsg(context, "Year is empty");
    } else if (_currentMonthsSelected == 'Month') {
      return showMsg(context, "Month is empty");
    } else if (_currentDaySelected == 'Day') {
      return showMsg(context, "Day is empty");
    }

    setState(() {
      _isLoading = true;
    });

    var data = {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'img': imagePath,
      'country': countryController.text,//_selected.name, // _currentCountrySelected,
      'state': stateController.text,
      'birthday':
          "$_currentYearSelected - $_currentMonthsSelected - $_currentDaySelected",
      'phone': phoneController.text,
      'userType': '1',
      'app_Token': 'app_Token'
    };

    //print(data);

    var res = await CallApi().postData(data, '/auth/register');
    var body = json.decode(res.body);
    print(body);

    if (body['message'].contains("ER_DUP_ENTRY")) {
      showMsg(context, "Email already exists");
    } else {
      if (body['success'] == true) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', body['token']);
        localStorage.setString('user', json.encode(body['user']));

        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => CannabisPage()));

        //_showDialog(body['message']);

      } else {
        showMsg(context, "Something is wrong");
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  Widget _buildButtonIcon() {
    // _isUpload?Center(child: CircularProgressIndicator()) : Container();
    if (state == PhotoCrop.free) {
      return GestureDetector(
        onTap: () {
          _pickImage();
        },
        child: Stack(
          children: <Widget>[
            new Container(
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 2.5, color: Colors.blue[100]),
                        shape: BoxShape.circle),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/img/camera.png',
                        height: 100,
                        width: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                child: Container(
                    margin: EdgeInsets.only(top: 70, left: 75),
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF01D56A),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.photo_camera,
                        color: Color(0xFFFFFFFF),
                      ),
                    ))),
          ],
        ),
      );
    }
    // return Icon(Icons.add);
    else if (state == PhotoCrop.picked)
      return Column(
        children: <Widget>[
          // !_isUpload?Center(child: CircularProgressIndicator()) : Container(),
          imageFile == null
              ? Container(
                  padding: EdgeInsets.only(top: 100, bottom: 100),
                  child: Center(
                    child: Text(
                      'No Image Selected',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontFamily: 'MyriadPro',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  color: Colors.transparent,
                )
              : Stack(
                  children: <Widget>[
                    // Container(
                    //    padding: EdgeInsets.only(top: 100, bottom: 100),
                    //   child: Center(child:CircularProgressIndicator())),
                    Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 2.5, color: Colors.blue[100]),
                          shape: BoxShape.circle),
                      child: ClipOval(
                          child: Image.file(
                        imageFile,
                        height: 100,
                        width: 100,
                        fit: BoxFit.fill,
                      )
                          //  Image.asset(
                          //    imageFile,
                          //  // 'assets/images/nen.jpg',
                          //   height: 85,
                          //   width: 85,
                          //   fit: BoxFit.cover,
                          // ),
                          ),
                    ),
                    //  Center(child: Image.file(imageFile)),
                  ],
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                // padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xFF00aa54).withOpacity(0.8),
                ),
                margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),

                child: IconButton(
                  icon: Icon(
                    Icons.crop,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _cropImage();
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xFF00aa54).withOpacity(0.8),
                ),
                //  padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),

                child: IconButton(
                  icon: Icon(Icons.done, color: Colors.white),
                  onPressed: () {
                    _uploadImage();
                    setState(() {
                      state = PhotoCrop.cropped;
                    });
                  },
                ),
              ),
            ],
          )
        ],
      ); //Icon(Icons.crop);
    else if (state == PhotoCrop.cropped) {
      return GestureDetector(
        onTap: () {
          _pickImage();
        },
        child: Stack(
          children: <Widget>[
            new Container(
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 2.5, color: Colors.blue[100]),
                        shape: BoxShape.circle),
                    child: ClipOval(
                        child: Image.file(
                      imageFile,
                      height: 100,
                      width: 100,
                      fit: BoxFit.fill,
                    )
                        //  Image.asset(
                        //    imageFile,
                        //  // 'assets/images/nen.jpg',
                        //   height: 85,
                        //   width: 85,
                        //   fit: BoxFit.cover,
                        // ),
                        ),
                  ),
                ],
              ),
            ),
            Positioned(
              child: Container(
                  margin: EdgeInsets.only(top: 70, left: 75),
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF01D56A),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Icon(
                      Icons.photo_camera,
                      color: Color(0xFFFFFFFF),
                    ),
                  )),
            )
          ],
        ),
      );
    } // imageFile != null ? Image.file(imageFile) : Container(); //Icon(Icons.clear);
    else {
      return Container();
    }
    //  return Container(
  }

  Future<Null> _pickImage() async {
    setState(() {
      _isUpload = true;
    });

    imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    // imageQuality: 80
    );
    if (imageFile != null) {
      setState(() {
        state = PhotoCrop.picked;
        _isUpload = false;
      });
    }

    // setState(() {

    // });
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      // toolbarTitle: 'Cropper',
      // toolbarColor: Colors.blue,
      // toolbarWidgetColor: Colors.white,
    );
    if (croppedFile != null) {
      imageFile = croppedFile;
      setState(() {
        // state = PhotoCrop.free;
        state = PhotoCrop.cropped;
      });
    }

    _uploadImage();
  }
}
