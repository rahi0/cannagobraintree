
import 'package:canna_go_dev/form/cannabisForm/cannabisForm.dart';
import 'package:canna_go_dev/screen/loginPage/loginPage.dart';

import 'package:flutter/material.dart';

class CannabisPage extends StatefulWidget {
  @override
  _CannabisPageState createState() => _CannabisPageState();
}

class _CannabisPageState extends State<CannabisPage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.white,
      appBar: AppBar(
        //elevation: 0,
        automaticallyImplyLeading: false,
              leading: Builder(
    builder: (BuildContext context) {
      return IconButton(
        icon: const Icon(Icons.arrow_back_ios,color:Color(0xFF01d56a),),
        onPressed: () { 
           Navigator.push(
        context, 
        new MaterialPageRoute(
            builder: (context) => LogIn())); 
        },
       
      );
    },
  ), 
        title: Text(
          'Cannabis',
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
        //backgroundColor: Colors.white,
        body: SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
             // margin: EdgeInsets.only(top: 40),
              child: CannabisForm(),
            ),
          ),
        )
        );
  }
}
