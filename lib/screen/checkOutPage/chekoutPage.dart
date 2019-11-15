import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:canna_go_dev/api/api.dart';
import 'package:canna_go_dev/customPlugin/routeTransition/routeAnimation.dart';
import 'package:canna_go_dev/jsonModal/BraintreeTokenModel/BraintreeTokenModel.dart';
import 'package:canna_go_dev/jsonModal/GetAddressModel/GetAddressModel.dart';
import 'package:canna_go_dev/main.dart';
import 'package:canna_go_dev/redux/action.dart';
import 'package:canna_go_dev/screen/locationSelectPage/locationSelectPage.dart';
import 'package:canna_go_dev/widget/bottomAppBar/bottomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../settingPage/settingPage.dart';
import 'package:braintree_payment/braintree_payment.dart';


bool _visitMap  = false;

class CheckoutPage extends StatefulWidget {
  var totalItem = [];

  CheckoutPage(this.totalItem);
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  var totalPrice;
  var userData;
  var cannagoData;
  var lat;
  var long;
  var address;
  var price;
  var subTotal = 0;
  var delifee = 0;
  bool _isCheckingOut = false;
  bool _isPay = false;
  var clientNonce;
   var latitude;
  var longitude;
 var myAddress;
  var latitudeJson;
   var  longitudeJson;
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    _getBraintreeNonce();
    _getUserCurrentLocation();
    _calculatePrice();
    _getAddress();

    super.initState();
  }

  
 Future _getUserCurrentLocation() async {


    SharedPreferences localStorage = await SharedPreferences.getInstance();

   latitudeJson = double.parse(localStorage.getString('Latitude'));
   longitudeJson = double.parse(localStorage.getString('Longitude'));

 }

  void _getBraintreeNonce() async {
    setState(() {
      _isCheckingOut = true;
      _isPay = true;
    });

    var res = await CallApi().getData('/app/getBTClientToken');
    var collection = json.decode(res.body);
    clientNonce = BraintreeTokenModel.fromJson(collection);

    // print(productItems.allItems);
    // store.dispatch(AllProductItems(productItems.allItems));
    // setState(() {
    //   _isLoading = false;
    // });

    //print("delifee");

    if (!mounted) return;
    setState(() {
      _isCheckingOut = false;
      _isPay = false;
      // widget.totalItem = [];
    });

    print(clientNonce.token);
  }

  _getAddress() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var cannagoJson = localStorage.getString('cannago');
    userData = json.decode(userJson);
    cannagoData = json.decode(cannagoJson);
    setState(() {
      lat = userData['delLat'];
      long = userData['delLong'];
      address = userData['delAddress'];
    });
    print("data");

    print(cannagoData['id']);
    if (lat == null) {
      lat = "---";
    }

    if (long == null) {
      long = "---";
    }

    if (address == null) {
      address = "---";
    }
  }

  _calculatePrice() {
    // print("totalPrice");
    totalPrice = 0;
    price = 0;
    for (var d in widget.totalItem) {
      price = d.item.price * d.quantity;
      totalPrice = totalPrice + price;
    }
    print("price is");
    print(totalPrice);

    // setState(() {
    //  subTotal = totalPrice;
    // totalPrice = subTotal + delifee;
    // });

    
print(subTotal);
print(totalPrice);
print(delifee);
print("object");
  }

  void _showDialog(msg) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Colors.white,

          content: new Text(
            msg,
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
              child: new Text(
                "Done",
              ),
              onPressed: () {
                store.dispatch(CheckFilter(false));
                bottomNavIndex = 0;
                Navigator.push(context, SlideLeftRoute(page: Navigation()));
              },
            ),
          ],
        );
      },
    );
  }

  void _showPaymentErrorDialog(msg) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Colors.white,

          content: new Text(
            msg,
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
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isPay
          ? Center(child: CircularProgressIndicator(
             backgroundColor: Colors.green,
          ))
          : SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  //width: 320,
                  // color: Colors.red,
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
                  child: Column(
                    children: <Widget>[
                      ////////////Total Card///////////
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[300],
                                blurRadius: 17,
                                //offset: Offset(0.0,3.0)
                              )
                            ],
                            color: Colors.white),
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                              child: Column(
                                children: _showAddedItems(),
                              ),
                            ),

                            /////////////Subtotal////////////
                            Container(
                              color: Colors.grey[350],
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              // decoration: BoxDecoration(
                              //     border: Border(
                              //   top: BorderSide(
                              //     color: Colors.grey,
                              //     width: 1.5,
                              //   ),
                              // )
                              // ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      "Subtotal",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "sourcesanspro",
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      //   "\$$subTotal",
                                      "\$${(subTotal).toStringAsFixed(2)}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "sourcesanspro",
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            /////////////Subtotal End////////////
                            ///

                            /////////////Delivery fee////////////
                            Container(
                              // color: Colors.grey[350],
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              // decoration: BoxDecoration(
                              //     border: Border(
                              //   top: BorderSide(
                              //     color: Colors.grey,
                              //     width: 1.5,
                              //   ),
                              // )
                              // ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      "Delivery Fee",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "sourcesanspro",
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                     // delifee==null?"\$0.00":
                                      "\$${(delifee).toStringAsFixed(2)}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "sourcesanspro",
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            /////////////Delivery fee End////////////

                            /////////////Total////////////
                            Container(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                top: BorderSide(
                                  color: Colors.grey,
                                  width: 1.5,
                                ),
                              )),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      "Total",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "sourcesanspro",
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "\$${(totalPrice).toStringAsFixed(2)}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "sourcesanspro",
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            /////////////Total End////////////
                          ],
                        ),
                      ),

                      ////////////Total Card end///////////

                      ////////////Address Card///////////
                      Container(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 15, bottom: 15),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[300],
                                blurRadius: 17,
                                //offset: Offset(0.0,3.0)
                              )
                            ],
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ////////Address//////
                            Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                //color: Colors.red,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(right: 5),
                                      child: Text(
                                        "Address: ",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "sourcesanspro",
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        //color: Colors.blue,
                                        child: Text(
                                         
                                         "$address",
                                          //userData['delAddress'],
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "sourcesanspro",
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    )
                                  ],
                                )),

                            ////////Address end//////

                            ////////lat start//////
                            Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                //color: Colors.red,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(right: 5),
                                      child: Text(
                                        "Latitude: ",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "sourcesanspro",
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        //color: Colors.blue,
                                        child: Text(
                                          "$lat",
                                          //userData['delAddress'],
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "sourcesanspro",
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    )
                                  ],
                                )),

                            ////////lat end//////

                            ////////long start//////
                            Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                //color: Colors.red,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(right: 5),
                                      child: Text(
                                        "Longitude: ",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "sourcesanspro",
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        //color: Colors.blue,
                                        child: Text(
                                          "$long",
                                          //userData['delAddress'],
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "sourcesanspro",
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    )
                                  ],
                                )),

                            ////////long end//////

                            ////////address Button start//////
                            Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                width: MediaQuery.of(context).size.width,
                                //color: Colors.red,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
                                      ),
                                      child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              100,
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          decoration: BoxDecoration(
                                            //  color: Colors.teal[400],
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey[300],
                                                blurRadius: 17,
                                                //offset: Offset(0.0,3.0)
                                              )
                                            ],
                                          ),
                                          height: 42,
                                          child: FlatButton(
                                            onPressed: () {
                                                _showLocationAlert();
                                              // Navigator.push(
                                              //     context,
                                              //     SlideLeftRoute(
                                              //         page: Settings(userData,
                                              //             cannagoData)));
                                            },
                                            child: Text(
                                              'Put Address',
                                              textDirection: TextDirection.ltr,
                                              style: TextStyle(
                                                color: Color(0xFF01D56A),
                                                fontSize: 16.0,
                                                decoration: TextDecoration.none,
                                                fontFamily: 'MyriadPro',
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            color: Colors.transparent,
                                            shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        20.0)),
                                          )),
                                    ),
                                  ],
                                )),

                            //////// address Button end//////
                          ],
                        ),
                      ),

                      ////////////Address Card end///////////

                      /////////////////Promo Textfield/////////////
                      // Container(
                      //   //color: Colors.blue,
                      //   margin: EdgeInsets.only(bottom: 10),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: <Widget>[
                      //       Container(
                      //         //width: 300,
                      //         height: 30,
                      //         margin: EdgeInsets.only(left: 15, top: 15),
                      //         child: Text(
                      //           "Promo code",
                      //           textAlign: TextAlign.left,
                      //           style: TextStyle(
                      //               color: Color(0xFF000000),
                      //               fontFamily: "sourcesanspro",
                      //               fontSize: 16,
                      //               fontWeight: FontWeight.bold),
                      //         ),
                      //       ),
                      //       Container(
                      //           decoration: BoxDecoration(
                      //                              boxShadow:[
                      //            BoxShadow(color:Colors.grey[300],
                      //            blurRadius: 17,
                      //             //offset: Offset(0.0,3.0)
                      //             )

                      //          ],
                      //                           ),
                      //         child: Row(
                      //           children: <Widget>[
                      //             Expanded(
                      //               child: TextField(
                      //                 style: TextStyle(color: Color(0xFF000000)),
                      //                 cursorColor: Color(0xFF9b9b9b),
                      //                 decoration: InputDecoration(
                      //                   focusedBorder: OutlineInputBorder(
                      //                       borderRadius: BorderRadius.only(
                      //                         topLeft: Radius.circular(20.0),
                      //                         bottomLeft: Radius.circular(20.0),
                      //                       ),
                      //                       borderSide: BorderSide(
                      //                           color: Color(0xFFFFFFFF))),
                      //                   enabledBorder: UnderlineInputBorder(
                      //                       borderRadius: BorderRadius.only(
                      //                         topLeft: Radius.circular(20.0),
                      //                         bottomLeft: Radius.circular(20.0),
                      //                       ),
                      //                       borderSide: BorderSide(
                      //                           color: Color(0xFFFFFFFF))),
                      //                   hintText: "Type here ",
                      //                   hintStyle: TextStyle(
                      //                       color: Color(0xFF9b9b9b),
                      //                       fontSize: 15,
                      //                       fontFamily: "sourcesanspro",
                      //                       fontWeight: FontWeight.w300),
                      //                   contentPadding: EdgeInsets.only(
                      //                       left: 20, bottom: 12, top: 12),
                      //                   fillColor: Color(0xFFFFFFFF),
                      //                   filled: true,
                      //                 ),
                      //               ),
                      //             ),
                      //             Container(
                      //                 decoration: BoxDecoration(
                      //                   color: Colors.greenAccent[400],
                      //                   borderRadius: BorderRadius.only(
                      //                       bottomRight: Radius.circular(20.0),
                      //                       topRight: Radius.circular(20.0)),
                      //                 ),
                      //                 height: 47,
                      //                 child: FlatButton(
                      //                   onPressed: () {
                      //                     // Navigator.of(context).pushNamed("/CheckOutPage");
                      //                   },
                      //                   child: Text(
                      //                     'Apply',
                      //                     textDirection: TextDirection.ltr,
                      //                     style: TextStyle(
                      //                       color: Colors.white,
                      //                       fontSize: 17.0,
                      //                       decoration: TextDecoration.none,
                      //                       fontFamily: 'MyriadPro',
                      //                       fontWeight: FontWeight.normal,
                      //                     ),
                      //                   ),
                      //                   color: Colors.transparent,
                      //                   //elevation: 4.0,
                      //                   //splashColor: Colors.blueGrey,
                      //                   shape: new RoundedRectangleBorder(
                      //                       borderRadius:
                      //                           new BorderRadius.circular(20.0)),
                      //                 )),
                      //           ],
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),

                      /////////////////Promo Textfield end/////////////

                      // //////////////Debit card //////////

                      // Container(
                      //   margin: EdgeInsets.only(bottom: 10),
                      //   // color: Colors.blue,
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: <Widget>[
                      //       // Container(
                      //       //   //width: 300,
                      //       //   height: 30,
                      //       //   margin: EdgeInsets.only(left: 15, top: 15),
                      //       //   child: Text(
                      //       //     "Debit card",
                      //       //     textAlign: TextAlign.left,
                      //       //     style: TextStyle(
                      //       //         color: Color(0xFF000000),
                      //       //         fontFamily: "sourcesanspro",
                      //       //         fontSize: 16,
                      //       //         fontWeight: FontWeight.bold),
                      //       //   ),
                      //       // ),
                      //       // Container(
                      //       //   child: Row(
                      //       //     children: <Widget>[
                      //       //       Expanded(
                      //       //         child: Card(
                      //       //           elevation: 4,
                      //       //           shape: RoundedRectangleBorder(
                      //       //               borderRadius: BorderRadius.circular(50)),
                      //       //           child: TextField(
                      //       //             style: TextStyle(color: Color(0xFF000000)),
                      //       //             cursorColor: Color(0xFF9b9b9b),
                      //       //             decoration: InputDecoration(
                      //       //               focusedBorder: OutlineInputBorder(
                      //       //                   borderRadius: BorderRadius.all(
                      //       //                       Radius.circular(20.0)),
                      //       //                   borderSide: BorderSide(
                      //       //                       color: Color(0xFFFFFFFF))),
                      //       //               enabledBorder: UnderlineInputBorder(
                      //       //                   borderRadius: BorderRadius.all(
                      //       //                       Radius.circular(20.0)),
                      //       //                   borderSide: BorderSide(
                      //       //                       color: Color(0xFFFFFFFF))),
                      //       //               hintText: "Type here ",
                      //       //               hintStyle: TextStyle(
                      //       //                   color: Color(0xFF9b9b9b),
                      //       //                   fontSize: 15,
                      //       //                   fontFamily: "sourcesanspro",
                      //       //                   fontWeight: FontWeight.w300),
                      //       //               contentPadding: EdgeInsets.only(
                      //       //                   left: 20, bottom: 12, top: 12),
                      //       //               fillColor: Color(0xFFFFFFFF),
                      //       //               filled: true,
                      //       //             ),
                      //       //           ),
                      //       //         ),
                      //       //       ),
                      //       //       Container(
                      //       //         margin: EdgeInsets.only(left: 8),
                      //       //         //width: 150,
                      //       //         //height: 47,
                      //       //         child: ClipOval(
                      //       //           child: Image.asset(
                      //       //             'assets/img/g2.png',
                      //       //             height: 45,
                      //       //             width: 45,
                      //       //             fit: BoxFit.cover,
                      //       //           ),
                      //       //         ),
                      //       //       ),
                      //       //     ],
                      //       //   ),
                      //       // )
                      //     ],
                      //   ),
                      // ),

                      // //////////////Debit card //////////

                      /////////////////Message //////////

                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              //width: 300,
                              height: 30,
                              margin: EdgeInsets.only(left: 15, bottom: 5),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 5),
                                    child: Text(
                                      "Special request",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Color(0xFF000000),
                                          fontFamily: "sourcesanspro",
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Text(
                                      "Comments",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: "sourcesanspro",
                                          fontSize: 11,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              // height: 160,
                              margin: EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[300],
                                    blurRadius: 17,
                                    //offset: Offset(0.0,3.0)
                                  )
                                ],
                              ),
                              //color: Colors.blue,
                              //padding: EdgeInsets.all(10.0),
                              child: new ConstrainedBox(
                                constraints: BoxConstraints(
                                    // maxHeight: 160.0,
                                    ),
                                child: new Scrollbar(
                                  child: new SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    reverse: true,
                                    child: SizedBox(
                                      // height: 160.0,
                                      child: new TextField(
                                        maxLines: 3,
                                        cursorColor: Colors.black38,
                                        controller: commentController,
                                        decoration: new InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                  color: Color(0xFFFFFFFF))),
                                          enabledBorder: UnderlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                  color: Color(0xFFFFFFFF))),
                                          hintText: 'Type again',
                                          hintStyle: TextStyle(
                                              color: Color(0xFF9b9b9b),
                                              fontSize: 15,
                                              fontFamily: "sourcesanspro",
                                              fontWeight: FontWeight.w300),
                                          fillColor: Color(0xFFFFFFFF),
                                          filled: true,
                                          contentPadding: EdgeInsets.only(
                                              left: 20, bottom: 40, top: 12),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      /////////////////Message end//////////

                      /////////////////  Button Section Start///////////////
                      ///
                      ///
                      Container(
                        //color: Colors.yellow,
                        //margin: EdgeInsets.only(left: 20, right: 20, top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  'Back',
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    //decoration: TextDecoration.underline,
                                    fontFamily: 'MyriadPro',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                color: Colors.transparent,
                              ),
                            ),

                            ///////////////// Next In Button  Start///////////////

                            Container(
                                decoration: BoxDecoration(
                                  color: widget.totalItem.length < 1
                                      ? Colors.grey
                                      : Color(0xFF01D56A).withOpacity(0.8),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                ),
                                //width: 200,
                                padding: EdgeInsets.only(left: 15, right: 15),
                                height: 42,
                                child: FlatButton(
                                  onPressed: widget.totalItem.length < 1 ||
                                          _isCheckingOut
                                      ? null
                                      :  _pay,  //_pay, //_checkOut,
                                  child: Text(
                                    'Check Out',
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      decoration: TextDecoration.none,
                                      fontFamily: 'MyriadPro',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  color: Colors.transparent,
                                  //elevation: 4.0,
                                  //splashColor: Colors.blueGrey,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20.0)),
                                )),

                            ///////////////// Next In Button  End///////////////
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  List<Widget> _showAddedItems() {
    List<Widget> list = [];
    // var index = 0;

    for (var d in widget.totalItem) {
      list.add(Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        //height: 100,
        //color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  //color: Colors.red,
                  border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Text(
                      "${d.quantity}x ${d.item.name}",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "sourcesanspro",
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Container(
                    //width: 120,
                    // color: Colors.red,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              _deleteCart(d);
                            },
                          ),
                        ),
                        Container(
                          child: Text(
                            "\$${(d.item.price * d.quantity).toStringAsFixed(2)}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "sourcesanspro",
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

///////////////////
          ],
        ),
      ));
    }

    return list;
  }

  void _deleteCart(d) async {
    var i = 0;
    for (var item in widget.totalItem) {
      if (item.id == d.id) {
        break;
      }
      i++;
    }
    widget.totalItem.removeAt(i);
    setState(() {
      widget.totalItem = widget.totalItem; 
    });
    _calculatePrice();

    var data = {'id': '${d.id}'};
    CallApi().postData(data, '/app/curtsdelete');

     store.dispatch(UpdateCart(-1));
  }

  void _pay() async {
    setState(() {
      _isCheckingOut = true;
      _isPay = true;
    });
    
    BraintreePayment braintreePayment = new BraintreePayment();
    var bData = await braintreePayment.showDropIn(
        nonce: clientNonce.token, amount: "$totalPrice", enableGooglePay: false);

    print("Response of the payment $bData");

    if (bData.isNotEmpty) {
      var data = {'amount': totalPrice, 'nonce': bData};
      var res = await CallApi().postData(data, '/app/BTcheckout');
      var body = json.decode(res.body);

      // print("respose");
       print(body);

      if (body['success']) {
        _checkOut();
        print('Payment send successfully!');
      } else {
        _showPaymentErrorDialog('Sorry! Something went wrong with payment!!');
      }
    } else {
      _showPaymentErrorDialog('Sorry! Something went wrong payment!!');
    }
if (!mounted) return;
    // _checkOut();
    setState(() {
      _isCheckingOut = false;
      _isPay = false;
      widget.totalItem = [];
    });
  }

  void _checkOut() async {
    setState(() {
       _isCheckingOut = true;
      _isPay = true;
    });
    var data = {
      'commend': commentController.text,
      'title': "New Order",
      'body': "You have new order from ${userData['name']}",
      'click_action': 'FLUTTER_NOTIFICATION_CLICK'

      // 'token':
    };
    var res = await CallApi().postData(data, '/app/orders');
    var body = json.decode(res.body);

    store.dispatch(UpdateCart(-store.state.numberOfItemInCart));
    store.dispatch(CartList([]));
    // print("object");
    // print(store.state.numberOfItemInCart);
    // print(widget.totalItem.length);

    if (body['success'] == true) {
      _showDialog('Your order has been placed successfully!');
    } else {
      print(body);
      _showPaymentErrorDialog('Sorry! Something went wrong with order!!');
    }
    setState(() {
       _isCheckingOut = false;
      _isPay = false;
       widget.totalItem = [];
    });
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

                                   store.dispatch(VisitMapCheck(true));
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


    var response = await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

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

     Navigator.of(context).pop();
      _getAddress();

    
  }
}
