import 'dart:convert';
import 'package:canna_go_dev/api/api.dart';
import 'package:canna_go_dev/customPlugin/routeTransition/routeAnimation.dart';
import 'package:canna_go_dev/jsonModal/GetAddressModel/GetAddressModel.dart';
import 'package:canna_go_dev/jsonModal/reviewModel/rev.dart';
import 'package:canna_go_dev/main.dart';
import 'package:canna_go_dev/redux/action.dart';
import 'package:canna_go_dev/screen/cannabiSubmitPage/cannabiSubmitPage.dart';
import 'package:canna_go_dev/screen/cartPage/cartPage.dart';
import 'package:canna_go_dev/screen/locationSelectPage/locationSelectPage.dart';
import 'package:canna_go_dev/screen/settingPage/settingPage.dart';
import 'package:canna_go_dev/widget/bottomAppBar/bottomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:http/http.dart' as http;

class ItemPage extends StatefulWidget {
  final item;
  // final shop;

  ItemPage(this.item);
  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  bool _isLoading = false;
  bool _isRevLoading = true;
  bool _isSomeWrong = false;
  double rating = 0.0;
  var rev = [];
  var userData;
  var cannagoData;
  var shopId;
  var cartCheckList = [];
   var latitude;
  var longitude;
 var myAddress;
  var latitudeJson;
   var  longitudeJson;
   var lat;
  var long;
  var address;
  void initState() {
   // print(widget.item.id);
    _getitemReview();
    _getUserCurrentLocation();
    _ratingConvert();
    _getUserInfo();
    super.initState();
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
 Future _getUserCurrentLocation() async {


    SharedPreferences localStorage = await SharedPreferences.getInstance();

   latitudeJson = double.parse(localStorage.getString('Latitude'));
   longitudeJson = double.parse(localStorage.getString('Longitude'));

 }
  _getitemReview() async {
    print(widget.item.avgRating);
    if (widget.item.avgRating == null) {
      setState(() {
        _isRevLoading = false;
      });
      return;
    }
    var res = await CallApi().getData('/app/productReview/${widget.item.id}');
    var data = json.decode(res.body);
    if (data['success']) {
      setState(() {
        var r = Review.fromJson(data);
        rev = r.rev;
        _isRevLoading = false;
      });
    } else {
      setState(() {
        _isSomeWrong = true;
      });
    }
  }

  void _ratingConvert() {
    if (widget.item.avgRating == null) {
      rating = 0;
      return;
    }
    if (widget.item.avgRating.averageRating is int) {
      rating = widget.item.avgRating.averageRating.toDouble();
    } else {
      rating = widget.item.avgRating.averageRating;
    }
    print(rating);
  }

  ///
  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var cannagoJson = localStorage.getString('cannago');
    var user = json.decode(userJson);
    var cannago = json.decode(cannagoJson);
    setState(() {
      userData = user;
      cannagoData = cannago;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          //elevation: 0,
          automaticallyImplyLeading: false,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFF01d56a),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              );
            },
          ),
          title: Text(
            widget.item.name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Color(0xFF01d56a),
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
          child: Stack (
            children: <Widget>[
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.only(bottom: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(bottom: 20, top: 20),
                            height: MediaQuery.of(context).size.width - 100,
                            width: MediaQuery.of(context).size.width - 100,
                            decoration: BoxDecoration(
                              //borderRadius: BorderRadius.circular(10),
                              // border: Border.all(
                              //     color: Colors.black38, width: 0.5),
                              image: DecorationImage(
                                  image: widget.item.img == null
                                      ? AssetImage('assets/img/medicine_icon.PNG')
                                      : NetworkImage("https://www.dynamyk.biz" +
                                          widget.item.img),
                                  fit: BoxFit.fill),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        //height: 40,

                        //color: Colors.blue,
                        margin: EdgeInsets.only(left: 20),
                        // alignment: Alignment.center,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ////////////////
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              //height: 20,
                              //color: Colors.blue,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    //margin: EdgeInsets.only(left: 10),
                                    width: MediaQuery.of(context).size.width / 2,
                                    //height: 10,
                                    //color: Colors.green,
                                    //alignment: Alignment.centerRight,
                                    child: Text(
                                      widget.item.name,
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25.0,
                                        decoration: TextDecoration.none,
                                        fontFamily: 'MyriadPro',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 20),
                                    //width: 120,
                                    //height: 10,
                                    //color: Colors.green,
                                    //alignment: Alignment.centerRight,
                                    child: Text(
                                      "\$ ${(widget.item.price).toStringAsFixed(2)}",
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                        color: Color(0xFF00bb5d),
                                        fontSize: 23.0,
                                        decoration: TextDecoration.none,
                                        fontFamily: 'MyriadPro',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              //height: 20,
                              //color: Colors.blue,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    //width: 120,
                                    //height: 10,
                                    //color: Colors.yellow,
                                    child: Text(
                                      "Quantity:",
                                      //textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17.0,
                                        decoration: TextDecoration.none,
                                        fontFamily: 'MyriadPro',
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    //width: 120,
                                    //height: 10,
                                    //color: Colors.green,
                                    //alignment: Alignment.centerRight,
                                    child: Text(
                                      "${widget.item.quantity}",
                                      textDirection: TextDirection.ltr,
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
                            ),

////////////////
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              //height: 20,
                              //color: Colors.blue,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Container(
                                      child: widget.item.avgRating == null
                                          ? Row(
                                              children: <Widget>[
                                                SmoothStarRating(
                                                    allowHalfRating: false,
                                                    onRatingChanged: null,
                                                    starCount: 5,
                                                    rating: 0,
                                                    size: 20.0,
                                                    color: Color(0xFFffa900),
                                                    borderColor: Color(0xFF707070),
                                                    spacing: 0.0),
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: Text(
                                                    "(0)",
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15.0,
                                                      decoration:
                                                          TextDecoration.none,
                                                      fontFamily: 'MyriadPro',
                                                      fontWeight: FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Row(
                                              children: <Widget>[
                                                SmoothStarRating(
                                                    allowHalfRating: false,
                                                    onRatingChanged: null,
                                                    starCount: 5,
                                                    rating:
                                                        rating, //widget.item.avgRating.averageRating,
                                                    size: 20.0,
                                                    color: Color(0xFFffa900),
                                                    borderColor: Color(0xFF707070),
                                                    spacing: 0.0),
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: Text(
                                                    "(${widget.item.totalrev.total})",
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15.0,
                                                      decoration:
                                                          TextDecoration.none,
                                                      fontFamily: 'MyriadPro',
                                                      fontWeight: FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

/////////////////
                      Container(
                        //color: Colors.yellow,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(bottom: 15, top: 15),
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Description",
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                color: Color(0xFF343434),
                                fontSize: 20.0,
                                decoration: TextDecoration.none,
                                fontFamily: 'MyriadPro',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              //   width: 250,
                              //color: Colors.green,
                              child: Text(
                                widget.item.description,
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 15.0,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'MyriadPro',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
///////////////////////////////////////////

                      Column(
                        children: <Widget>[
                          rev.length > 0
                              ? Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  child: Divider(
                                    color: Colors.grey[400],
                                  ),
                                )
                              : Container(),
                          rev.length > 0
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(bottom: 15, top: 15),
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Review",
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                      color: Color(0xFF343434),
                                      fontSize: 20.0,
                                      decoration: TextDecoration.none,
                                      fontFamily: 'MyriadPro',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : Container(),
                          _isRevLoading
                              ? Container(
                                  margin: EdgeInsets.only(
                                      left: 40, right: 20, bottom: 20),
                                  child: Text('Review is loading...'),
                                )
                              : Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  //color: Colors.red,
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: _displayReview()),
                                ),
                        ],
                      ),
                     ///   cart///
                    ],
                  ),
                ),
              ),

               Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                       crossAxisAlignment: CrossAxisAlignment.center ,
                        children: <Widget>[
                          Center(
                            child: Container(
                                
                                margin: EdgeInsets.only(bottom: 20), 
                                alignment: Alignment.bottomCenter,
                                padding: EdgeInsets.only(left: 3, right: 3),
                                decoration: BoxDecoration(
                                  color: _isLoading
                                      ? Colors.grey
                                      : Color(0xFF01D56A),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                ),
                                height: 42,
                                width: MediaQuery.of(context).size.width/2, 
                                child: FlatButton(
                                  
                                  onPressed: _isLoading ? null : _addToCart,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        _isLoading
                                            ? Icons.repeat
                                            : Icons.add_shopping_cart,
                                        color: Colors.black,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 8),
                                        padding: EdgeInsets.only(top: 3),
                                        child: Text(
                                          _isLoading ? 'Adding...' : 'Add to cart',
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 18.0,
                                            decoration: TextDecoration.none,
                                            fontFamily: 'MyriadPro',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  color: Colors.transparent,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(20.0)),
                                )),
                          ),
                        ],
                      ), 
            ],
          ),
        ));
  }

  List<Widget> _displayReview() {
    List<Widget> lists = [];
    for (var d in rev) {
      lists.add(
        Container(
          margin: EdgeInsets.only(bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 90,
                height: 90,
                margin: EdgeInsets.only(right: 10),
                decoration: new BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: d.user.img == null
                        ? new AssetImage('assets/img/camera.png')
                        : NetworkImage("https://www.dynamyk.biz" + d.user.img),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    padding: EdgeInsets.only(left: 2, top: 3, bottom: 4),
                    child: Text(
                      "${d.user.name}",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        color: Color(0xFF343434),
                        fontSize: 15.0,
                        decoration: TextDecoration.none,
                        fontFamily: 'MyriadPro',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          child: SmoothStarRating(
                              allowHalfRating: false,
                              onRatingChanged: null,
                              starCount: 5,
                              rating: d.rating,
                              size: 20.0,
                              color: Color(0xFFffa900),
                              borderColor: Color(0xFF707070),
                              spacing: 0.0),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, left: 2),
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(
                      "${d.content}",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14.0,
                        decoration: TextDecoration.none,
                        fontFamily: 'MyriadPro',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
    return lists;
  }

  void _addToCart() async {
    setState(() {
      _isLoading = true;
    });

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var cannagoJson = localStorage.getString('cannago');
    var user = json.decode(userJson);
    var cannago = json.decode(cannagoJson);
    setState(() {
      userData = user;
      cannagoData = cannago;
    });

    if (cannagoData == null) {
      _showDialog('Please submit your "Cannabi License"');
    } else if (userData['delLat'] == null &&
        userData['delLong'] == null &&
        userData['delAddress'] == null) {
          _showLocationAlert();
     // _showDialog('Please submit your "Address"');
    } else {
      if (store.state.numberOfItemInCart == 0) {
        store.dispatch(UpdateCart(1));
      } else {
        for (var d in store.state.cartList) {
          cartCheckList.add(d.item.id);

          print(cartCheckList);
        }

        if (cartCheckList.contains(widget.item.id)) {
        } else {
          store.dispatch(UpdateCart(1));
        }
      }

      var data = {'itemId': '${widget.item.id}', 'quantity': 1};
      var res = await CallApi().postData(data, '/app/curts');
      var body = json.decode(res.body);

      print("item");
      print(body);

      Navigator.push(context, SlideLeftRoute(page: CartPage()));
    }

    setState(() {
      _isLoading = false;
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

                                   store.dispatch(VisitItemTOMapCheck(true));
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
              child: new Text("Ok"),
              onPressed: () {
                Navigator.pop(context);
                msg == 'Please submit your "Cannabi License"'
                    ?
                     Navigator.push(
                        context, SlideLeftRoute(page: CannabiSubmitPage()))
                    : Navigator.push(context,
                        SlideLeftRoute(page: Settings(userData, cannagoData)));
              },
            ),
          ],
        );
      },
    );
  }
}
