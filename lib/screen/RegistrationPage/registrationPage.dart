import 'package:canna_go_dev/form/registrationForm/registrationForm.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   elevation: 0,
        // ),
        backgroundColor: Colors.white,
        body: SafeArea(
      child: Container(
        //margin: EdgeInsets.only(top: 40),
        child: RegistrationForm(),
      ),
    ));
  }
}
