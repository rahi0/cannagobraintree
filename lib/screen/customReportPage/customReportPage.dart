import 'package:canna_go_dev/form/customReportFoem/customReportForm.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart'; 


class CustomReport extends StatefulWidget {
  final orderIdd;
  CustomReport(this.orderIdd);
  @override
  _CustomReportState createState() => _CustomReportState();
}

class _CustomReportState extends State<CustomReport> {

  var userData;
  bool _isLoaded = false;

  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }


  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson); 
    setState(() {
      userData = user;
      _isLoaded = true;
    });

    print(userData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
              appBar: AppBar(
        //elevation: 0,
        automaticallyImplyLeading: false,
              leading: Builder(
    builder: (BuildContext context) {
      return IconButton(
        icon: const Icon(Icons.arrow_back_ios,color:Color(0xFF01d56a),),
        onPressed: () { 
          Navigator.of(context).pop();
        },
       
      );
    },
  ), 
        title: Text(
          'Custom Report',
          style: TextStyle(
          color:Color(0xFF01d56a),
           // fontSize: 21.0,
            fontWeight: FontWeight.normal,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.white,
       // centerTitle: true,
      ),
      body: SafeArea(
              child: CustomReportForm(userData, widget.orderIdd),
      ),
    );
  }
}