import 'package:canna_go_dev/customPlugin/routeTransition/routeAnimation.dart';
import 'package:canna_go_dev/form/logInForm/logInForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  
  // @override 
  // void dispose() {
  //   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.white,
        body: SafeArea(
                  child: Center(
            child: SingleChildScrollView(
      child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                Container(
                  //padding: EdgeInsets.only(left: 20),
                  alignment: Alignment.center,  
                  height: 90,
                  width: MediaQuery.of(context).size.width,
                  //color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'CannaGo',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 31.0,
                          decoration: TextDecoration.none,
                          fontFamily: 'sourcesanspro',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/img/g2.png',
                            height: 85,
                            width: 85,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),


                LogInForm()
              ],
            ),
      ),
    ),
          ),
        ));
  }
}
