import 'dart:convert';
import 'package:canna_go_dev/api/api.dart';
import 'package:canna_go_dev/customPlugin/routeTransition/routeAnimation.dart';
import 'package:canna_go_dev/jsonModal/shop/shopModel.dart';
import 'package:canna_go_dev/screen/shopPage/shopPage.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:canna_go_dev/widget/bottomAppBar/bottomAppBar.dart';
import 'package:canna_go_dev/redux/action.dart';
import 'package:canna_go_dev/main.dart';
import 'package:http/http.dart' as http;
import 'package:canna_go_dev/jsonModal/GetAddressModel/GetAddressModel.dart';
import 'package:canna_go_dev/jsonModal/SearchAddressModel/SearchAddressModel.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ShowStore extends StatefulWidget {
  final lat;
  final lng;
  ShowStore(this.lat, this.lng);

  @override
  _ShowStoreState createState() => _ShowStoreState();
}

class _ShowStoreState extends State<ShowStore> {
  double latitude;
  double longitude;

  double searchLat = 0;
  double searchLong = 0;
  var shopAddress;
  var addresses;
  var first;
  String myAddress;
  String newAddress;

  String searchAddr;

  TextEditingController serchController = TextEditingController();

  Set<Marker> _markers = Set();
  Set<Polyline> _polylines = Set();
  CameraPosition _initialPosition ;
  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  var allSeller;

  void initState() {
    _initialPosition =  CameraPosition(target: LatLng(widget.lat, widget.lng));
        bottomNavIndex = 1;
    _myLocation();
    store.state.shopLocationList.length>0?_showpin():_showAllSeller();
     store.dispatch(ConnectionCheck(true));
       store.dispatch(CheckFilter(false));
    

    super.initState();
  }

 Future <void> _showAllSeller() async {
    var res = await CallApi().getData('/app/cannagrowAllSearch');
    var collection = json.decode(res.body);
    var allSellerDetails = ShopData.fromJson(collection);
    print(allSellerDetails);

    if (!mounted) return;
    setState(() {
      allSeller = allSellerDetails.shop;
    });

    store.dispatch(ShopLocationList(allSeller));

print("ttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt");
  
    _showpin();
  }



  Future<void> _searchLocation() async {

    if(serchController.text.isEmpty){
        return _showDialog("Address is empty.");
      }

     else{

 String url =
        "https://maps.google.com/maps/api/geocode/json?key=AIzaSyAiXNjJ3WpC-U-NKUPY66eQK471y1CiWTY&language=en_US&address=${serchController.text}";


    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    var collection = json.decode(response.body);

    var addressData = SearchAddressModel.fromJson(collection);


  // searchStatus = addressData.status;

   if(addressData.status=="ZERO_RESULTS"){
     // print("object");
       return _showDialog("Address Not Found");
    }

    else{

setState(() {
   searchLat= addressData.results[0].geometry.location.lat;
   searchLong = addressData.results[0].geometry.location.lng;
 
   });
    }

      
      /////////  use plugin ///////////
    // try {
    //   addresses = await Geocoder.local.findAddressesFromQuery(searchAddr);
    // } on Exception {
    //   addresses = null;
    // }

    // if(addresses==null){
    //   _showDialog("Enter a valid address!");
    // }else{
    //   first = addresses.first;
    // }

   

    // searchLat = first.coordinates.latitude;
    // searchLong = first.coordinates.longitude;


      /////////  use plugin end ///////////

    GoogleMapController controller = await _controller.future;
    controller.moveCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(searchLat, searchLong),
        zoom: 14.0,
      ),
    ));
    setState(() {
      _markers.clear();
      _polylines.clear();
      _markers.add(
        Marker(
          markerId: MarkerId('searchId'),
          position: LatLng(searchLat, searchLong),
          infoWindow: InfoWindow(
            title: '$searchAddr',
          ),
        ),
      );
    });

  //   _showpin();

    serchController.text = "";


    }

//_showpin();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
             appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title:  Text(
          'Select Shop',
          style: TextStyle( 
          color:Color(0xFF01d56a),
           // fontSize: 21.0,
            fontWeight: FontWeight.normal,
          ),
        ),
      
        // title: Container(
        //   margin: EdgeInsets.only(top: 8, bottom: 8),
        //   decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(10.0),
        //            color: Color(0xFFf1f1f1),),
        //   child: TextField(
        //           autofocus: false, 
                  
        //           controller: serchController,
        //           decoration: InputDecoration(
        //               hintText: 'Search Address',
                    
        //               border: InputBorder.none,
        //               contentPadding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
        //               suffixIcon:  IconButton(
        //           icon: Icon(Icons.search, color: Colors.grey),
        //           onPressed: (){
        //             _searchLocation();
        //           },
        //         )
        //                   ),
        //           onChanged: (val) {
        //             setState(() {
        //               searchAddr = val;
        //             });
        //           },
        //         ),
        // ),

              actions: <Widget>[
                 Container(
                   padding: EdgeInsets.only(top: 3),
                   child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
               Container(
       alignment: Alignment.topRight,
       child: IconButton(
                   icon: Icon(Icons.refresh),
                   onPressed: () {
                    _showAllSeller();
                   },
                ),
             ),
              Container(
       alignment: Alignment.topRight,
       child: IconButton(
                       icon: Icon(Icons.location_searching),
                       onPressed: () {
                        _myLocation();
                       },
                      ),
                   ),
            ],
          ),
                 ),
                // IconButton(
                //   icon: Icon(Icons.search, color: Colors.grey),
                //   onPressed: (){
                //     _searchLocation();
                //   },
                // )
              ],
    ),
      body: SafeArea(
            child: Stack(
        children: <Widget>[
          GoogleMap(
      markers: _markers,
      polylines: _polylines,
      mapType: MapType.normal,
      // myLocationEnabled: true,
      // myLocationButtonEnabled: true,
      onMapCreated: _onMapCreated,
      initialCameraPosition: _initialPosition,
      // onCameraMove: ((_position) => _updatePosition(_position)),
            ),

         


          // Column(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: <Widget>[
          //     Container(
          //       height: 45,
          //       width: MediaQuery.of(context).size.width,
          //       margin: EdgeInsets.only(left: 20, bottom: 10, right: 20),
          //       child: FlatButton(
          //         color: Color(0xFF01D56A),
          //         disabledColor: Colors.grey,
          //         onPressed: () {
          //           _showpin();
          //         },
          //         child: Text(
          //           "Find Shop",
          //           style: TextStyle(color: Colors.white),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
          ),
    );
  }



  void _myLocation() async {
    GoogleMapController controller = await _controller.future;
    LocationData currentLocation;
    var location = Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }

    latitude = currentLocation.latitude;
    longitude = currentLocation.longitude;

    // latitude = 24.9112692;
    // longitude = 91.8499715;

    // var coordinates = new Coordinates(latitude, longitude);
    // addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    // first = addresses.first;

    controller.moveCamera(
        CameraUpdate.newLatLngZoom(LatLng(latitude, longitude), 17));
    // controller.animateCamera(
    //     CameraUpdate.newLatLngZoom(LatLng(latitude, longitude), 17));
    //setState(() {
    //myAddress = first.addressLine;
    //_markers.clear();
    _markers.add(
      Marker(
        markerId: MarkerId('locationId'),
        position: LatLng(latitude, longitude),
       // infoWindow: InfoWindow(title: "$latitude"),
      ),
    );
    //});
  }

  // Future<void> _searchLocation() async {
  //   try {
  //     addresses = await Geocoder.local.findAddressesFromQuery(searchAddr);
  //   } on Exception {
  //     addresses = null;
  //   }
  //   try {
  //     first = addresses.first;
  //   } on Exception {
  //     first = null;
  //   }

  //   searchLat = first.coordinates.latitude;
  //   searchLong = first.coordinates.longitude;

  //   GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(
  //     CameraPosition(
  //       target: LatLng(searchLat, searchLong),
  //       zoom: 17.0,
  //     ),
  //   ));
  //   setState(() {
  //     //_markers.clear();
  //     _polylines.clear();
  //     _markers.add(
  //       Marker(
  //         markerId: MarkerId('searchId'),
  //         position: LatLng(searchLat, searchLong),
  //         infoWindow: InfoWindow(
  //             title: '$searchAddr',),
  //       ),
  //     );
  //   });

  //   serchController.text = "";
  // }

  // void _updatePosition(CameraPosition _position) async{

  //   Marker marker = _markers.firstWhere(
  //       (p) => p.markerId == MarkerId('marker_2'),
  //       orElse: () => null);
  //   _markers.remove(marker);
  //   _markers.add(
  //     Marker(
  //       markerId: MarkerId('marker_2'),
  //       position: LatLng(_position.target.latitude, _position.target.longitude),
  //        infoWindow: InfoWindow(
  //             title: '${_position.target.latitude}', snippet: '${_position.target.longitude}'),
  //       draggable: true,
  //       //icon: _searchMarkerIcon,
  //     ),
  //   );
  //  setState(() {
  //    pickLatitude = _position.target.latitude;
  //    pickLongitude = _position.target.longitude;
  //  });
  // }

  void _showpin() async {
    for (var d in store.state.shopLocationList) {
     
    //  var coordinates = new Coordinates(d.lat, d.lng);

//            String url =
//         "https://maps.google.com/maps/api/geocode/json?key=AIzaSyAiXNjJ3WpC-U-NKUPY66eQK471y1CiWTY&language=en_US&latlng=${d.lat},${d.lng}";


//     var response = await http
//         .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

//     var collection = json.decode(response.body);

//     var addressData = GetAddressModel.fromJson(collection);
    
//   if (!mounted) return;


// setState(() {
//    shopAddress =addressData.results[0].formatted_address;
// });

      ////     plugin use start  ////////
      // addresses =
      //     await Geocoder.local.findAddressesFromCoordinates(coordinates);
      // first = addresses.first;

      // var shopAddress = first.addressLine;

        ////     plugin use end  ////////
        ///
         SharedPreferences localStorage = await SharedPreferences.getInstance();
    // localStorage.setString('Latitude', '$currentLatitude');
    // localStorage.setString('Longitude', '$currentLongitude');

   var  latitudeJson = localStorage.getString('Latitude');
   var  longitudeJson = localStorage.getString('Longitude');

  var   lati = double.parse(latitudeJson); //latitudeJson;
  var   longi = double.parse(longitudeJson);
      GoogleMapController controller = await _controller.future;
      controller.moveCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
       //   target: LatLng(24.9112692, 91.8499715),
       target: LatLng(lati, longi),
          zoom: 17.0,
        ),
     ));

      var idd;

      setState(() {
        idd = d.id.toString();
      });

      _markers.add(
        Marker(
            markerId: MarkerId(idd),
            position: LatLng(d.lat, d.lng), 
            onTap: () {
              dialog(d.name, d.address,d.user.img, d);
            }),
      );
    }
  }

  void dialog(String name, String shop, String img, d) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: EdgeInsets.all(5),
          title: Column(
            children: <Widget>[
              Container(
                  width: 100,
                  height: 100,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: img==null? AssetImage('assets/img/camera.png'): NetworkImage("https://www.dynamyk.biz"+img),
                      ))),
            ],
          ),
          content: Container(
            padding: EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width,
            height: 100,
            margin: EdgeInsets.only(right: 10, left: 10, bottom: 15),
            child: Column(
              children: <Widget>[
                Text(
                  "Shop Name : " + name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: "grapheinpro-black",
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                Text(
                  "Address : " + shop,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: "grapheinpro-black",
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),

          actions: <Widget>[
            Container(
                      
                        // decoration: BoxDecoration(
                        //   color: Colors.greenAccent[400],
                        //   borderRadius:
                        //       BorderRadius.all(Radius.circular(20.0)),
                        // ),
                        //width: 150,
                        //height: 35,
                        child: FlatButton(
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(Icons.home, color: Colors.white,),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                          'Visit Shop',
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
                          color: Colors.greenAccent[400],
                          // elevation: 4.0,
                          //splashColor: Colors.blueGrey,
                          shape: new RoundedRectangleBorder(
                              borderRadius:
                                  new BorderRadius.circular(20.0)),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push( context, SlideLeftRoute(page: ShopPage(d)));
                            
                          },
                        )),
          ],
        );
        //return SearchAlert(duration);
      },
    );
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
                  child: new Text("Ok"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
  }
}
