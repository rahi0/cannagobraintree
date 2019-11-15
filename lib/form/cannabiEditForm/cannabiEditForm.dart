import 'dart:convert';

import 'package:canna_go_dev/api/api.dart';
import 'package:canna_go_dev/customPlugin/routeTransition/routeAnimation.dart';
import 'package:canna_go_dev/form/logInForm/logInForm.dart';
import 'package:canna_go_dev/widget/bottomAppBar/bottomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class CannabiEditForm extends StatefulWidget { 
 final userData;
 var cannagoData;
  CannabiEditForm(this.userData, this.cannagoData);

  @override
  _CannabiEditFormState createState() => _CannabiEditFormState();
}

class _CannabiEditFormState extends State<CannabiEditForm>{

 
  TextEditingController cannabisController;
  TextEditingController dateController;
  String date;

 DateTime selectedDate = DateTime.now();
 var format;


  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
     //  locale: Locale("yyyy-MM-dd"),
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
     date = "${DateFormat("yyyy - MMMM - dd").format(selectedDate)}"; 
      });
  }



  @override
  void initState() {
    _getUserInfo();
    format = DateFormat("yyyy-MM-dd").format(selectedDate);
    date =widget.cannagoData!=null && widget.cannagoData['medicalCannabisExpiration']!= null ? '${widget.cannagoData['medicalCannabisExpiration']}' : '';
    super.initState();
  }
  // SOME INITIAL VALUES 
  bool _isLoading = false;
  void _getUserInfo() {

   cannabisController = TextEditingController(
        text:
            widget.cannagoData!=null && widget.cannagoData['medicalCannabis']!= null ? '${widget.cannagoData['medicalCannabis']}' : '');

   dateController = TextEditingController(
        text:
           widget.cannagoData!=null && widget.cannagoData['medicalCannabisExpiration']!= null ? '${widget.cannagoData['medicalCannabisExpiration']}' : '');

  
    
  }


  Container profileContainer(
      String label,TextEditingController controller, bool obscure, String text) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 10,right: 20),
      padding: EdgeInsets.only(left: 0, right: 10),
     // color: Colors.red,
      child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ////////  name /////////
          Container(
            width: MediaQuery.of(context).size.width/3,
            margin: EdgeInsets.only(left: 20),
            //color: Colors.blue,
            child: Text(
              label,
              textAlign: TextAlign.left,
              style: TextStyle(
                                color: Color(0xFF343434),
                                fontFamily: "sourcesanspro",
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
            ),
          ),

          ////////  name textfield /////////

          Expanded(
                      child: Container(
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
                                    controller: controller,
                                    obscureText: obscure,
                                    style: TextStyle(
                                       color: Color(0xFF606060),
                                      fontSize: 15,
                                          letterSpacing: 0.5,
                                          fontFamily: "sourcesanspro",
                                          fontWeight: FontWeight.normal
                                    ),
                                    cursorColor: Color(0xFF9b9b9b),
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide:
                                              BorderSide(color: Color(0xFFFFFFFF))),
                                      enabledBorder: UnderlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide:
                                              BorderSide(color: Color(0xFFFFFFFF))
                                              ),
                                      hintText: text,
                                      hintStyle: TextStyle(
                                          color: Color(0xFF606060),
                                          fontSize: 15,
                                          letterSpacing: 0.5,
                                          fontFamily: "sourcesanspro",
                                          fontWeight: FontWeight.w300
                                          ),
                                      contentPadding:
                                          EdgeInsets.only(left: 20, bottom: 10, top: 10, right: 15),
                                      fillColor: Color(0xFFFFFFFF),
                                      filled: true,
                                    ),
                                  ),
                                ),
          ),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 5),
              margin: EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[


        ///////////// Form Start //////////

        profileContainer("Medical Cannabis License",cannabisController, false, widget.cannagoData!=null && widget.cannagoData['medicalCannabis']!= null ? '${widget.cannagoData['medicalCannabis']}' : ''),
        
      //  profileContainer("Expiration Date", dateController, false, widget.cannagoData!=null && widget.cannagoData['medicalCannabisExpiration']!= null ? '${widget.cannagoData['medicalCannabisExpiration']}' : ''),
    
        


            Container( 
      margin: EdgeInsets.only(top: 5, bottom: 10,right: 20),
      padding: EdgeInsets.only(left: 0, right: 10),
     // color: Colors.red,
      child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ////////  name /////////
          Container(
            width:MediaQuery.of(context).size.width/3,
            margin: EdgeInsets.only(left: 20),
            //color: Colors.blue,
            child: Text(
             "Expiration Date",
              textAlign: TextAlign.left,
              style: TextStyle(
                                color: Color(0xFF343434),
                                fontFamily: "sourcesanspro",
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
            ),
          ),

          ////////  license textfield /////////

          Expanded(
                      child: Container(
                                       decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                   boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey[200],
                   // offset: Offset(1.0, 2.0),
                    blurRadius: 14.0,
                  ),
                ],
              ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                 
                                padding: EdgeInsets.only(left: 20),
                              //  width: MediaQuery.of(context).size.width/2,
                                          //width: 350,
                                          // decoration: BoxDecoration(
                                          //   //color: Colors.red,
                                          //   borderRadius: BorderRadius.circular(20),
                                          //   boxShadow: <BoxShadow>[
                                          //     BoxShadow(
                                          //       color: Colors.black.withOpacity(0.2),
                                          //       offset: Offset(1.0, 2.0),
                                          //       blurRadius: 5.0,
                                          //     ),
                                          //   ],
                                          // ),
                                         // height: 35,
                                          child:Text(
             widget.cannagoData!=null && widget.cannagoData['medicalCannabisExpiration']!= null ? date.toString() : '',
              textAlign: TextAlign.right,
              style: TextStyle(
                                    color: Color(0xFF606060),
                                    fontFamily: "sourcesanspro",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
            ),
                                          //  TextField(
                                          //   controller: dateController,
                                          //   obscureText: false,
                                          //   style: TextStyle(
                                          //     color: Color(0xFF000000),
                                          //     fontSize: 15,
                                          //         letterSpacing: 0.5,
                                          //         fontFamily: "sourcesanspro",
                                          //         fontWeight: FontWeight.normal
                                          //   ),
                                          //   cursorColor: Color(0xFF9b9b9b),
                                          //   decoration: InputDecoration(
                                          //     focusedBorder: OutlineInputBorder(
                                          //         borderRadius: BorderRadius.circular(20),
                                          //         borderSide:
                                          //             BorderSide(color: Color(0xFFFFFFFF))),
                                          //     enabledBorder: UnderlineInputBorder(
                                          //         borderRadius: BorderRadius.circular(20),
                                          //         borderSide:
                                          //             BorderSide(color: Color(0xFFFFFFFF))
                                          //             ),
                                          //     hintText: widget.cannagoData!=null && widget.cannagoData['medicalCannabisExpiration']!= null ? '${widget.cannagoData['medicalCannabisExpiration']}' : '',
                                          //     hintStyle: TextStyle(
                                          //         color: Colors.grey[600],
                                          //         fontSize: 15,
                                          //         letterSpacing: 0.5,
                                          //         fontFamily: "sourcesanspro",
                                          //         fontWeight: FontWeight.w300
                                          //         ),
                                          //     contentPadding:
                                          //         EdgeInsets.only(left: 20, bottom: 10, top: 10, right: 15),
                                          //     fillColor: Color(0xFFFFFFFF),
                                          //     filled: true,
                                          //   ),
                                          // ),
                                        ),


                                        IconButton(
                                         
                               onPressed: () {

                                _selectDate(context);
                            
                               },

                                          icon: Icon(Icons.calendar_today),
                                        )
                            ],
                          ),
                      ),
          ),
        ],
      ),
    ),
        /////////////Action BAr///////////////////
      
            // SizedBox(height: 20.0,),
            // RaisedButton(
            //   onPressed: () => _selectDate(context),
            //   child: Text('Select date'),
            // ),
        Container(
          width: MediaQuery.of(context).size.width,
          //height: 90,
          padding: EdgeInsets.fromLTRB(25, 10, 25, 20),
          margin: EdgeInsets.only(top: 40),
          decoration: BoxDecoration(
            //color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)
            )
          ),
          child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.pop(context);
                      //     //           Navigator.push(
                      //     // context,
                      //     // new MaterialPageRoute(
                      //     //   builder: (context) => Shop()
                      //     // ));
                      //   },
                      //   child: Container(
                      //     //padding: EdgeInsets.only(left: 20),
                      //      child: Text(
                      //                   'Back',
                                        
                      //                 //  textDirection: TextDirection.ltr,
                      //                   style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontSize: 18.0,
                      //                       decoration: TextDecoration.underline,
                      //                       fontFamily: 'MyriadPro',
                      //                       fontWeight: FontWeight.normal,
                      //                   ),
                      //                 ),
                      //     //color: Colors.red,
                      //   ),
                      // ),

                      ///////////////// Add to cart Button  Start///////////////

                      Container(
                          decoration: BoxDecoration(
                            color: _isLoading? Colors.grey : Color(0xFF01d56a).withOpacity(0.8),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          //width: 150,
                          height: 45,
                          child: FlatButton(
                             onPressed: _isLoading? null : _saveEditButton,
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Icon( _isLoading? Icons.repeat : Icons.save, 
                                color: Colors.black,),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                            _isLoading? 'Saving...' :  'Save',
                                            //textDirection: TextDirection.ltr,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17.0,
                                                decoration: TextDecoration.none,
                                                fontFamily: 'MyriadPro',
                                                fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                ),
                              ],
                            ),
                            color: Colors.transparent,
                            // elevation: 4.0,
                            //splashColor: Colors.blueGrey,
                            shape: new RoundedRectangleBorder(
                                borderRadius:
                                    new BorderRadius.circular(20.0)),
                           
                          )),

                      ///////////////// Add to cart Button  End///////////////
                    ],
                  ),
        )



        /////////////Action BAr end///////////////////
                ],
              ),
            ),
          );
  }



  void _saveEditButton() async{
    
    if(cannabisController.text.isEmpty){
        return showMsg(context, "Licence is empty");
      }

      else if( date.isEmpty){
        return showMsg(context, "Day is empty");
      }

    setState(() {
       _isLoading = true;
    });
   
      var data = {
        'id' : '${widget.cannagoData['id']}',
        'medicalCannabis' : cannabisController.text,
        'medicalCannabisExpiration' : date//dateController.text,
     };
     var res = await CallApi().postData(data, '/app/cannagoEdit');
     var body = json.decode(res.body);
      if(body['success']){
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.remove('cannago');
        var editedInfo = json.encode(body['data']);
        localStorage.setString('cannago', json.encode(body['data']));
       _showDialog('Information has been saved successfully!');
        
      }else{
        print('user is not updated');
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
                     Navigator.of(context).pop(); 
                    Navigator.push(context, SlideLeftRoute(page: Navigation()));
                  },
                ),
              ],
            );
          },
        );
  }

}
