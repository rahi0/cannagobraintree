import 'package:canna_go_dev/ShowStorePage/ShowStorePage.dart';
import 'package:canna_go_dev/screen/historyPage/historyPage.dart';
import 'package:canna_go_dev/screen/homePage/homePage.dart';
import 'package:canna_go_dev/screen/locationSelectPage/locationSelectPage.dart';
import 'package:canna_go_dev/screen/profilePage/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:canna_go_dev/main.dart';
import 'dart:convert';
import 'package:canna_go_dev/api/api.dart';
import 'package:canna_go_dev/jsonModal/TotalNotificationModel/TotalNotificationModel.dart';
import 'package:canna_go_dev/screen/NotificationPage/NotificationPage.dart';
import 'dart:async';
import 'package:canna_go_dev/redux/action.dart';
import 'package:connectivity/connectivity.dart';
import 'package:canna_go_dev/customPlugin/routeTransition/routeAnimation.dart';
import 'package:firebase_messaging/firebase_messaging.dart'; 
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';



int bottomNavIndex = 0;
 double currentLongitude=0.0;
    double currentLatitude=0.0;
class Navigation extends StatefulWidget {

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
   
   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging(); 
   var totalNotifi;
   var number;
   
   @override
   void initState() {

  

/////// add firebase notification/////

   _firebaseMessaging.getToken().then((token) async {
      print("Notification token");
      print(token);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
       localStorage.setString('firebaseToken',token);
      
   });

 _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
       // Navigator.push(context, SlideLeftRoute(page: NotificationPage()));
      },
      onLaunch: (Map<String, dynamic> message) async {
        pageLaunch(message);
      },
      onResume: (Map<String, dynamic> message) async {
       pageDirect(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

/////// end firebase notification/////

    // _showNotification();
   
    _showNewNumber();
    _deviceLocation();

      super.initState();
  }

 void _deviceLocation() async {
    LocationData currentLocation;
    var location = Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }

    currentLatitude = currentLocation.latitude;
   currentLongitude = currentLocation.longitude;
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('Latitude', '$currentLatitude');
    localStorage.setString('Longitude', '$currentLongitude');
  }


  // @override
  // void dispose() {
   
  //   super.dispose();
  // }
  
///// handle looping onlaunch firebase //////
  void pageDirect(Map<String, dynamic> msg) {
    print("onResume: $msg");
    setState(() {
      index = 1;
    });
    Navigator.push(context, SlideLeftRoute(page: NotificationPage()));
  }

  void pageLaunch(Map<String, dynamic> msg) {
    print("onLaunch: $msg");  
    pageRedirect();
   
  }

  void pageRedirect() {
   

    if (index != 1 && index != 2) {
     
      Navigator.push(context, SlideLeftRoute(page: NotificationPage()));
      setState(() {
        index = 2;
      });
    }
  }

 ///// end handle looping onlaunch firebase //////
  void internetCheck() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
    } else if (connectivityResult == ConnectivityResult.wifi) {
    } else {
      if (store.state.connection == false) {
      } else {
        _showInternetConnnection();
      }
    }
  }

  void _showNewNumber() {
   // Timer.periodic(Duration(seconds: 2), (timer) {
     // _showNotificationNumber();

      internetCheck();
   // });
  }

  void _showNotificationNumber() async {
    // setState(() {
    //   _isLoading = true;
    // });

    var res = await CallApi().getData('/app/getUnseenNoti');
    var collection = json.decode(res.body);
    var totalOrder = TotalNotificationModel.fromJson(collection);

    if (totalOrder.notification == null) {
      if (!mounted) return;
      setState(() {
        totalNotifi = 0;
      });
    } else {
      if (!mounted) return;
      setState(() {
        totalNotifi = totalOrder.notification.count;
      });
    }
    // setState(() {
    //    totalNotifi = totalOrder.notification.count;

    // });

    if (totalNotifi > store.state.notificationCount) {
      // number = totalNotifi - store.state.notificationCount;
      _showNotification();

      // setState(() {
      store.dispatch(NotificationCountAction(
          totalNotifi)); //store.state.notificationCount==newOrderData.length;
    }

// setState(() {
//       _isLoading = false;
//     });
    //print(totalNotifi);
  }

  final List<Widget> children = [
    HomePage(),
    ShowStore(currentLatitude, currentLatitude),
    //StorePage(),
    HistoryPage(),
    ProfilePage(),
  ];
  int _currentIndex = bottomNavIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: children[_currentIndex],
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
            // sets the background color of the BottomNavigationBar
            // canvasColor: Colors.transparent,
            //backgroundColor: Colors.lightBlue,
            // sets the active color of the BottomNavigationBar if Brightness is light
            primaryColor: Color(0xFF00aa54).withOpacity(0.8),
            //disabledColor: Colors.blue,
            // textTheme: Theme
            //     .of(context)
            //     .textTheme
            //     .copyWith(caption: new TextStyle(color: Colors.white54))
            ),
        child: new BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: onTabTapped,
          currentIndex:
              _currentIndex, //store.state.bottomNavigationState, // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: new Icon(
                Icons.home,
              ),
              title: Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.store),
              title: Text(
                "Store",
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              title: Text("History"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text("Profile"),
            ),
          ],
        ),
      ),
    );
  }

  void onTabTapped(bottomNavIndex) {
    setState(() {
      _currentIndex = bottomNavIndex;
    });
  }

  void _showInternetConnnection() {
    store.dispatch(ConnectionCheck(false));
    // Timer.periodic(Duration(seconds: 20), (timer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: EdgeInsets.all(5),
          title: Text(
            "No Internet Connection",
            // textAlign: TextAlign.justify,
            style: TextStyle(
                color: Color(0xFF000000),
                fontFamily: "grapheinpro-black",
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
          content: Container(
              height: 70,
              width: 250,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.greenAccent[400],
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        width: 110,
                        height: 45,
                        margin: EdgeInsets.only(top: 25, bottom: 15),
                        child: OutlineButton(
                            color: Colors.greenAccent[400],
                            child: new Text(
                              "Retry",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            borderSide:
                                BorderSide(color: Colors.green, width: 0.5),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0))))
                  ])),
        );
      },
    );
    // });
  }

  void _showNotification() {
    // Timer.periodic(Duration(seconds: 20), (timer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: EdgeInsets.all(5),
          title: Text(
            totalNotifi == 1
                ? "You have " + '$totalNotifi' + " new notification"
                : "You have " + '$totalNotifi' + " new notifications",
            // textAlign: TextAlign.justify,
            style: TextStyle(
                color: Color(0xFF000000),
                fontFamily: "grapheinpro-black",
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
          content: Container(
              height: 70,
              width: 250,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        width: 110,
                        height: 45,
                        margin: EdgeInsets.only(
                          top: 25,
                          bottom: 15,
                        ),
                        child: OutlineButton(
                          child: new Text(
                            "Close",
                            style: TextStyle(color: Colors.black),
                          ),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          borderSide:
                              BorderSide(color: Colors.black, width: 0.5),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0)),
                        )),
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.greenAccent[400],
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        width: 110,
                        height: 45,
                        margin: EdgeInsets.only(top: 25, bottom: 15),
                        child: OutlineButton(
                            color: Colors.greenAccent[400],
                            child: new Text(
                              "View",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              // Navigator.push(
                              //         context,
                              //         new MaterialPageRoute(
                              //             builder: (context) =>
                              //                 NotificationPage()));
                              _updateNotification();
                            },
                            borderSide:
                                BorderSide(color: Colors.green, width: 0.5),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0))))
                  ])),
        );
      },
    );
    // });
  }

  void _updateNotification() async {
    var data = {};

    var res = await CallApi().postData(data, '/app/updateNoti');
    var body = json.decode(res.body);

    print(body);
    if (body['success'] == true) {
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => NotificationPage()));
    }
  }
}
