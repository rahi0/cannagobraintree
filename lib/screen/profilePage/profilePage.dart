import 'dart:convert';
import 'package:canna_go_dev/api/api.dart';
import 'package:canna_go_dev/customPlugin/routeTransition/routeAnimation.dart';
import 'package:canna_go_dev/main.dart';
import 'package:canna_go_dev/redux/action.dart';
import 'package:canna_go_dev/screen/loginPage/loginPage.dart';
import 'package:canna_go_dev/screen/settingPage/settingPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:canna_go_dev/widget/bottomAppBar/bottomAppBar.dart';
//import 'package:adhara_socket_io/adhara_socket_io.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var userData;
  var cannagoData;
  var imgData;
  bool _isLoading = true;
  bool _isLoaded = false;
  @override
  void initState() {
    bottomNavIndex = 3;
    store.dispatch(CheckFilter(false));
    _getUserInfo();
    // _getSocket();
    super.initState();
  }

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    //Scaffold.of(context).showSnackBar(snackBar);
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var cannagoJson = localStorage.getString('cannago');
    var user = json.decode(userJson);
    var cannago = json.decode(cannagoJson);
    setState(() {
      userData = user;
      cannagoData = cannago;
      _isLoaded = true;
      userData['img'] != null
          ? imgData = "https://www.dynamyk.biz" + '${userData['img']}'
          : "";
      // imgData = 'http://10.0.2.2:3333' + '${userData['img']}'
      // : "";
      _isLoading = false;
    });

    print(userData);
  }

  Container profileContainer(String label, String text) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),

      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ////////  name /////////
          Container(
            width: MediaQuery.of(context).size.width / 3,
            margin: EdgeInsets.only(left: 20),
            //color: Colors.blue,
            child: Text(
              label,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color(0xFF343434),
                  fontFamily: "sourcesanspro",
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ),

          ////////  name textfield /////////

          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 20),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
              //color: Colors.yellow,
              child: Text(
                text,
                style: TextStyle(
                    color: Color(0xFF505050),
                    fontFamily: "sourcesanspro",
                    fontSize: 15,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.normal),
                //  fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoaded
        ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  //height: MediaQuery.of(context).size.height - 20,
                  // color: Colors.red,
                  padding: EdgeInsets.only(top: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //////// photo part //////////

                      _isLoading
                          ? Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : Container(
                              //color: Colors.red,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    // margin: EdgeInsets.only(left: 80, top: 40, bottom: 10),
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                            //padding: EdgeInsets.all(100),
                                            width: 120,
                                            height: 120,
                                            decoration: new BoxDecoration(
                                              border: Border.all(
                                                  width: 3,
                                                  color: Color(0xFF01d56a)
                                                      .withOpacity(0.4)),
                                              shape: BoxShape.circle,
                                            ),
                                            child: ClipOval(
                                              child: userData['img'] != null
                                                  ? Image.network(
                                                      // "https://dynamyk.co"+'${userData['img']}',

                                                      imgData,
                                                      //  'https://picsum.photos/250?image=9',
                                                      height: 120,
                                                      width: 120,
                                                      fit: BoxFit.cover,
                                                    )
                                                  :
                                                  // Image.asset(

                                                  //                     'assets/img/camera.png',
                                                  //          // 'assets/img/camera.png',
                                                  //           height: 100,
                                                  //           width: 100,
                                                  //           fit: BoxFit.cover,
                                                  //         ):
                                                  Image.asset(
                                                      // 'assets/img/profile.png',
                                                      'assets/img/camera.png',
                                                      height: 120,
                                                      width: 120,
                                                      fit: BoxFit.cover,
                                                    ),
                                            )),

                                        //////   camera icon  ////////////

                                        //new Positioned(
                                        // child: Container(
                                        //     width: 35,
                                        //     height: 35,
                                        //     margin: EdgeInsets.only(top: 60, left: 70),
                                        //     decoration: new BoxDecoration(
                                        //       shape: BoxShape.circle,
                                        //       color: Color(0xFF01D56A),
                                        //     ),
                                        //     child: Icon(
                                        //       Icons.photo_camera,
                                        //       color: Color(0xFFFFFFFF),
                                        //     )),
                                        //)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                      ///////////// Form Start //////////
                      SizedBox(
                        height: 10,
                      ),
                      /////////// name field //////
                      profileContainer(
                          "Name",
                          userData['name'] != null
                              ? '${userData['name']}'
                              : '---'),
                      //profileContainer("User Name",   userData!= null ? 'rahi.humayun' : ''),
                      profileContainer(
                          "Medical Cannabis License#",
                          cannagoData != null &&
                                  cannagoData['medicalCannabis'] != null
                              ? '${cannagoData['medicalCannabis']}'
                              : '---'),
                      profileContainer(
                          "License Expiration",
                          cannagoData != null &&
                                  cannagoData['medicalCannabisExpiration'] !=
                                      null
                              ? '${cannagoData['medicalCannabisExpiration']}'
                              : '---'),
                      profileContainer(
                          "Country",
                          userData['country'] != null
                              ? '${userData['country']}'
                              : '---'),
                      profileContainer(
                          "State",
                          userData['state'] != null
                              ? '${userData['state']}'
                              : '---'),
                      // profileContainer(
                      //     "County", userData['country'] != null ? 'County' : ''),
                      profileContainer(
                          "Email",
                          userData['email'] != null
                              ? '${userData['email']}'
                              : '---'),
                      //profileContainer( "Password", userData!= null ? '${userData['password']}' : '',),
                      //profileContainer( "Confirm Password",  userData!= null ? '${userData['password']}' : '',),
                      profileContainer(
                        "Birth Date",
                        userData['birthday'] != null
                            ? '${userData['birthday']}'
                            : '---',
                      ),
                      profileContainer(
                          "Phone",
                          userData['phone'] != null
                              ? '${userData['phone']}'
                              : '---'),

                      profileContainer(
                          "Latitude",
                          userData['delLat'] != null
                              ? '${userData['delLat']}'
                              : '---'),

                      profileContainer(
                          "Longitude",
                          userData['delLong'] != null
                              ? '${userData['delLong']}'
                              : '---'),

                      profileContainer(
                          "Address",
                          userData['delAddress'] != null
                              ? '${userData['delAddress']}'
                              : '---'),

                      /////////////Action BAr///////////////////
                      Container(
                        color: Colors.white,
                        margin: EdgeInsets.only(
                            top: 30, left: 20, right: 20, bottom: 20),
                        width: MediaQuery.of(context).size.width,
                        //height: 90,
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF01d56a).withOpacity(0.8),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                ),
                                //width: 150,
                                height: 45,
                                child: FlatButton(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Icon(
                                        Icons.settings,
                                        color: Colors.white,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 5),
                                        child: Text(
                                          'Settings',
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                            color: Colors.white,
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
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => Settings(
                                                userData, cannagoData)));
                                  },
                                )),
                            ///////////////// Add to cart Button  Start///////////////

                            Container(
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                ),
                                //width: 150,
                                height: 45,
                                child: FlatButton(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Icon(
                                        Icons.exit_to_app,
                                        color: Colors.white,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 5),
                                        child: Text(
                                          'Logout',
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                            color: Colors.white,
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
                                  onPressed: () {
                                    _logout();
                                  },
                                )),
                          ],
                        ),
                      ),

                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: <Widget>[
                      //     Container(
                      //        margin: EdgeInsets.only(
                      //           top: 40, bottom: 30, left: 20, right: 20),
                      //       padding: EdgeInsets.only(
                      //           bottom: 10, top: 10, right: 10, left: 10),
                      //       decoration: BoxDecoration(
                      //         color: Color(0xFFFFFFFF),
                      //          boxShadow:[
                      //        BoxShadow(color:Colors.grey[200],
                      //        blurRadius: 14.0,
                      //        // offset: Offset(0.0,3.0)
                      //         )

                      //      ],
                      //         borderRadius: BorderRadius.circular(50),
                      //       ),
                      //       child: Row(
                      //         mainAxisAlignment:
                      //             MainAxisAlignment.spaceAround,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: <Widget>[
                      //           ///////////Deactive Button Start/////////
                      //           GestureDetector(
                      //             onTap: () {
                      //               Navigator.push(
                      //                   context,
                      //                   SlideLeftRoute(
                      //                       page: Settings(
                      //                           userData, cannagoData)));
                      //             },
                      //             child: Container(
                      //               //color: Colors.red,
                      //               child: Column(
                      //                 children: <Widget>[
                      //                   Container(
                      //                     child: Text(
                      //                       "Settings",
                      //                       textAlign: TextAlign.left,
                      //                       style: TextStyle(
                      //                           color: Color(0xFF000000),
                      //                           fontFamily: "sourcesanspro",
                      //                           fontSize: 14,
                      //                           fontWeight: FontWeight.w500),
                      //                     ),
                      //                   ),
                      //                   Icon(
                      //                     Icons.settings,
                      //                     color: Color(0xFF01D56A),
                      //                   )
                      //                 ],
                      //               ),
                      //             ),
                      //           ),

                      //           //////////Deactive Button end/////////
                      //           Container(
                      //             width: 2,
                      //             height: 30,
                      //             color: Colors.grey[300],
                      //           ),

                      //           ///////////Logout Button Start/////////
                      //           GestureDetector(
                      //             onTap: _logout,
                      //             child: Container(
                      //               //color: Colors.red,
                      //               child: Column(
                      //                 children: <Widget>[
                      //                   Container(
                      //                     child: Text(
                      //                       "Log Out",
                      //                       textAlign: TextAlign.left,
                      //                       style: TextStyle(
                      //                           color: Color(0xFF000000),
                      //                           fontFamily: "sourcesanspro",
                      //                           fontSize: 14,
                      //                           fontWeight: FontWeight.w500),
                      //                     ),
                      //                   ),
                      //                   Icon(
                      //                     Icons.exit_to_app,
                      //                     color: Color(0xFF01D56A),
                      //                   )
                      //                 ],
                      //               ),
                      //             ),
                      //           ),

                      //           //////////Deactive Button end/////////
                      //           // Container(
                      //           //   width: 2,
                      //           //   height: 30,
                      //           //   color: Colors.grey[300],
                      //           // ),

                      //           // ///////////Deactive Button Start/////////
                      //           // GestureDetector(
                      //           //   onTap: () {
                      //           //     // Navigator.push(
                      //           //     //     context,
                      //           //     //     new MaterialPageRoute(
                      //           //     //         builder: (context) => Inquire()));
                      //           //   },
                      //           //   child: Container(
                      //           //     // color: Colors.red,
                      //           //     child: Column(
                      //           //       children: <Widget>[
                      //           //         Container(
                      //           //           child: Text(
                      //           //             "Share Code",
                      //           //             textAlign: TextAlign.left,
                      //           //             style: TextStyle(
                      //           //                 color: Color(0xFF000000),
                      //           //                 fontFamily: "sourcesanspro",
                      //           //                 fontSize: 14,
                      //           //                 fontWeight: FontWeight.w500),
                      //           //           ),
                      //           //         ),
                      //           //         Icon(
                      //           //           Icons.share,
                      //           //           color: Color(0xFF01D56A),
                      //           //         )
                      //           //       ],
                      //           //     ),
                      //           //   ),
                      //           // ),

                      //           //////////Deactive Button end/////////
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // )

                      /////////////Action BAr end///////////////////
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  // logout the user
  _logout() async {
    var data = {'userId': '${userData['id']}'};
    var res = await CallApi().postData(data, '/auth/logout');
    var body = json.decode(res.body);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('token');
    localStorage.remove('firebaseToken');
    localStorage.remove('user');
    localStorage.remove('cannago');

    store.state.itemCart = [];
    store.state.cart = {};
    store.state.numberOfItemInCart = 0;
    store.state.notificationCount = 0;
    store.state.connection = true;
    store.state.cartList = [];
    store.state.shopList = [];
    store.state.isFilter = false;
    store.state.filterItemsList = [];
    store.state.searchItemList = [];
    store.state.isSearch = false;
    store.state.isLoadingSearch = false;
    store.state.driverLat = 0.0;
    store.state.driverLng = 0.0;
    store.state.isSocket = "noConnection";
    store.state.locationList = [];
    store.state.historyOrderList = [];
    store.state.visitCheckToMap = false;
    store.state.visitItemToMap = false;
    store.state.notifiCheck = true;
    store.state.notiList = [];
    store.state.shopLocationList = [];
    store.state.notiToOrder = [];
    store.state.isClickFilter = false;
    store.state.isHistory = false;

    Navigator.push(context, SlideLeftRoute(page: LogIn()));
  }
}
