import 'dart:convert';
import 'package:canna_go_dev/api/api.dart';
import 'package:canna_go_dev/customPlugin/routeTransition/routeAnimation.dart';
import 'package:canna_go_dev/screen/cannabiEditPage/cannabiEditPage.dart';
import 'package:canna_go_dev/screen/cannabiSubmitPage/cannabiSubmitPage.dart';
import 'package:canna_go_dev/screen/locationSelectPage/locationSelectPage.dart';
import 'package:canna_go_dev/screen/profileEditPage/profileEditPage.dart';
import 'package:canna_go_dev/screen/profilePage/profilePage.dart';
import 'package:canna_go_dev/screen/ChangePassword/ChangePassword.dart';
import 'package:canna_go_dev/widget/bottomAppBar/bottomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:canna_go_dev/jsonModal/GetAddressModel/GetAddressModel.dart';



class Settings extends StatefulWidget {
  final userData;
  final cannagoData;
  Settings(this.userData, this.cannagoData);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var latitude;
  var longitude;
 var myAddress;
  var latitudeJson;
   var  longitudeJson;

 @override
  void initState() {
    _getUserCurrentLocation();
    super.initState();
  }
 

 Future _getUserCurrentLocation() async {


    SharedPreferences localStorage = await SharedPreferences.getInstance();

   latitudeJson = double.parse(localStorage.getString('Latitude'));
   longitudeJson = double.parse(localStorage.getString('Longitude'));

 }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      backgroundColor: Colors.white,
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
          'Settings',
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
      body: Container(
        //color: Colors.red,
        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ///////////Edit Profile Button//////////
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      SlideLeftRoute(
                          page: ProfileEditPage(
                              widget.userData, widget.cannagoData)));
                },
                child: Container(
                 // color:Colors.red,
                  width: MediaQuery.of(context).size.width,
                 //  margin: EdgeInsets.only(bottom: 5),
                  //margin: EdgeInsets.only(bottom: 40),
                  padding: EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.settings,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Edit Profile',
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  letterSpacing: 0.5,
                                  wordSpacing: 1,
                                color: Colors.black,
                               
                                  fontSize: 17.0,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'BebasNeue',
                                 fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Icon(
                          Icons.keyboard_arrow_right,
                           color: Colors.black,
                        ),
                      )
                    ],
                  ),
                )),

            Padding(
              padding:EdgeInsets.only(left: 50),
              child: Divider(
                color: Colors.grey[400],
                height: 5,
              ),
            ),
            ///////////Edit Profile Button//////////

          //  Container(width: MediaQuery.of(context).size.width, height: 0.5),

            ///////////Reset Password Button//////////

            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, SlideLeftRoute(page: ChangePassword()));
                },
                child: Container(
                //  color: Colors.black,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(
                      left: 20, right: 20, top: 12, bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.vpn_key,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Change Password',
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  letterSpacing: 0.5,
                                  wordSpacing: 1,
                                    color: Colors.black,
                                  fontSize: 17.0,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'BebasNeue',
                                   fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Icon(
                          Icons.keyboard_arrow_right,
                           color: Colors.black,
                        ),
                      )
                    ],
                  ),
                )),

            ///////////Reset Password Button end//////////

           // Container(width: MediaQuery.of(context).size.width, height: 0.5),
 Padding(
              padding:EdgeInsets.only(left: 50),
              child: Divider(
                height: 5,
                color: Colors.grey[400],
              ),
            ),
            ///////////Reset Cannbie Button//////////

           widget.cannagoData != null
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          SlideLeftRoute(
                              page: CannabiEditPage(
                                  widget.userData, widget.cannagoData)));
                    },
                    child: Container(
                      
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 12, bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.edit,
                                     color: Colors.black,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Edit Cannabis',
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                      letterSpacing: 0.5,
                                      wordSpacing: 1,
                                        color: Colors.black,
                                      fontSize: 17.0,
                                      decoration: TextDecoration.none,
                                      fontFamily: 'BebasNeue',
                                       fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ))

                ///////////Reset Cannabi Button end//////////

                :

                /////////Submit Cannbie Button//////////

                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, SlideLeftRoute(page: CannabiSubmitPage()));
                    },
                    child: Container(
                     
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 12, bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.book,
                                     color: Colors.black,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Submit Cannabis',
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                      letterSpacing: 0.5,
                                      wordSpacing: 1,
                                       color: Colors.black,
                                      fontSize: 17.0,
                                      decoration: TextDecoration.none,
                                      fontFamily: 'BebasNeue',
                                       fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Icon(
                              Icons.keyboard_arrow_right,
                             color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    )),

            ///////////Submit Cannabi Button end//////////
 Padding(
              padding:EdgeInsets.only(left: 50),
              child: Divider(
                height: 5,
                color: Colors.grey[400],
              ),
            ),
           // Container(width: MediaQuery.of(context).size.width, height: 10),

            ///////////Add delivery Address Button//////////
            GestureDetector(
                onTap: () {
                  //_showLocationHint();
                  _showLocationAlert();
                  //Navigator.push(context, SlideLeftRoute(page: ProfileEditPage(widget.userData, widget.cannagoData)));
                },
                child: Container(
                // color: Colors.green,
                  width: MediaQuery.of(context).size.width,
                  //margin: EdgeInsets.only(bottom: 40),  
                  padding: EdgeInsets.only(
                      left: 20, right: 20, top: 12, bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.location_on,
                                 color: Colors.black,
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Add Delivery Address',
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  letterSpacing: 0.5,
                                  wordSpacing: 1,
                                   color: Colors.black,
                                  fontSize: 17.0,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'BebasNeue',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                )),

            ///////////Edit Profile Button//////////
             Padding(
              padding:EdgeInsets.only(left: 50),
              child: Divider(
                height: 5,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    ));
  }



  void _deviceLocation() async {
    LocationData currentLocation;
    var location = Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }

    latitude = currentLocation.latitude;
    longitude = currentLocation.longitude;


    // get the address 

       String url =
        "https://maps.google.com/maps/api/geocode/json?key=AIzaSyAiXNjJ3WpC-U-NKUPY66eQK471y1CiWTY&language=en_US&latlng=$latitude,$longitude";


    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    var collection = json.decode(response.body);

    var addressData = GetAddressModel.fromJson(collection);
setState(() {
   myAddress = addressData.results[0].formatted_address;
});

                   //// plugin start////////
  
    // var coordinates = new Coordinates(latitude, longitude);
    // var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    // var first = addresses.first;
    // var myAddress = first.addressLine;

          //// plugin start////////
    // save this in user table 
    CallApi().postData({'delLat' : latitude, 'delLong' : longitude, 'delAddress': myAddress}, '/app/update-lat-long');
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var userData = json.decode(userJson);
    userData['delLat'] = latitude;
    userData['delLong'] = longitude;
    userData['delAddress'] = myAddress;
    localStorage.setString('user', json.encode(userData)); 


print(userData);
   
    Navigator.of(context).pop();
   // Navigator.push(context, SlideLeftRoute(page: Navigation()));

    
  }
void _showLocationAlert(){

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: EdgeInsets.all(5),
          title: 
              Text(
                                "Choose Delivery Address",
                               // textAlign: TextAlign.,
                                style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontFamily: "grapheinpro-black",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),

                              content:Container(
                    height: 80,
                    width: 250,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                              width: 110,
                              height: 45,
                              margin: EdgeInsets.only(
                                top: 25,
                                bottom: 15,
                              ),
                              
                              child: OutlineButton(
                                child: new Text(
                                  "Pick Location",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black),
                                ),
                                color: Colors.white,
                                onPressed: () {
                                   Navigator.of(context).pop();
                                   Navigator.push(context, SlideLeftRoute(page: MapPage(latitudeJson, longitudeJson)));
                                },
                                borderSide:
                                    BorderSide(color: Colors.black, width: 0.5),
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(20.0)),
                              )),
                          Container(
                              decoration: BoxDecoration(
                             color:Color(0xFF00CE7C).withOpacity(0.8),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                              width: 110,
                              height: 45,
                              margin: EdgeInsets.only(top: 25, bottom: 15),
                              child: OutlineButton(
                                  color:Color(0xFF00CE7C).withOpacity(0.8),
                                  child: new Text(
                                    "Current Location",
                                     textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {

                                      bottomNavIndex = 3;
                                    _deviceLocation();
                                  
                                  },
                                  borderSide: BorderSide(
                                      color: Colors.green, width: 0.5),
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20.0))))
                        ])),
            
        );
        //return SearchAlert(duration);
      },
    );
  }
}
