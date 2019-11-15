import 'package:canna_go_dev/customPlugin/routeTransition/routeAnimation.dart';
import 'package:canna_go_dev/screen/customReportPage/customReportPage.dart';
import 'package:flutter/material.dart';
import 'package:canna_go_dev/form/logInForm/logInForm.dart';
import 'dart:convert';
import 'package:canna_go_dev/widget/bottomAppBar/bottomAppBar.dart';
import 'package:canna_go_dev/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportPage extends StatefulWidget {
  var  orderIdd;
  ReportPage(this.orderIdd);
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {

  bool _isLoading = false;

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
          'Report',
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
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 40.0, top: 75.0, right: 40.0),
            child: Column(
              children: <Widget>[
                ///////////////// Forget Button  End///////////////

                Container(
                  alignment: Alignment.centerLeft,
                  //height: 90,
                  width: 320,
                  //color: Colors.yellow,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  left: 10, top: 60, bottom: 15),
                              child: Text(
                                'Report an issue',
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  color: Colors.greenAccent[400],
                                  fontSize: 15.0,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'sourcesanspro',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                            ///////////////// Order Button  Start///////////////

                            Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  gradient: LinearGradient(
                                    begin: Alignment.centerRight,
                                    end: Alignment.topLeft,
                                    stops: [0.1, 0.4, 0.6, 0.9],
                                    colors: [
                                      Colors.greenAccent[400],
                                      Colors.greenAccent[400],
                                      Colors.tealAccent[400],
                                      Colors.tealAccent[700],
                                    ],
                                  ),
                                ),
                                width: 320,
                                height: 45,
                                child: FlatButton(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: 20),
                                      ),
                                      Container(
                                        //width: 150,
                                        //color: Colors.grey,
                                        child: Text(
                                          'Order was wrong',
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            decoration: TextDecoration.none,
                                            fontFamily: 'MyriadPro',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: EdgeInsets.only(left: 90),
                                      // ),

                                      Container(
                                          //width: 80,
                                          // color: Colors.red,
                                          child: Icon(
                                        Icons.keyboard_arrow_right,
                                        color: Colors.white,
                                        size: 30,
                                      ))
                                    ],
                                  ),
                                  color: Colors.transparent,
                                  //elevation: 4.0,
                                  //splashColor: Colors.blueGrey,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20.0)),
                                  onPressed:  _isLoading ? null : _orderWrongButton,
                                )),
                          ],
                        ),
                      ),

                      ///////////////// Order Button  End///////////////

                      Container(
                        margin: EdgeInsets.only(top: 35, bottom: 35),
                        child: Text(
                          'OR',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 17.0,
                            decoration: TextDecoration.none,
                            fontFamily: 'sourcesanspro',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),

                      ///////////////// Custom Button///////////////

                      Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          width: 320,
                          height: 40,
                          margin: EdgeInsets.only(top: 5, bottom: 15),
                          child: OutlineButton(
                            onPressed: (){
                              Navigator.push( context, SlideLeftRoute(page: CustomReport(widget.orderIdd)));
                            },
                            child: Text(
                              "Custom",
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                decoration: TextDecoration.none,
                                fontFamily: 'MyriadPro',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            // borderSide:
                            //     BorderSide(color: Colors.black, width: 0.5),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0)),
                          )),

                      ///////////////// Custom Button  End///////////////
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }



  void _orderWrongButton() async{

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJsonString = localStorage.getString('user');
     var user = json.decode(userJsonString);
      


    setState(() {
       _isLoading = true;
    });
   
    
      var data = {
        'orderId' : widget.orderIdd,
        'name' : user['name'],
        'email' : user['email'],
        'description' : "Order was wrong",
     };

     print(data);
    
   
      var res = await CallApi().postData(data, '/app/userreport');
    var body = json.decode(res.body);
    print(body);
    
    
        if(body['success']){
       
       _showDialog(body['message']);
        
      }
      else{
          showMsg(context, "Something is wrong");
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
