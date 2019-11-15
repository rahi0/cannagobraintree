import 'dart:async';
import 'dart:convert';
import 'package:canna_go_dev/api/api.dart';
import 'package:canna_go_dev/customPlugin/routeTransition/routeAnimation.dart';
import 'package:canna_go_dev/redux/action.dart';
import 'package:canna_go_dev/screen/itemPage/itemPage.dart';
import 'package:canna_go_dev/widget/bottomAppBar/bottomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import 'package:geopoint/geopoint.dart';
import 'package:http/http.dart' as http;
import 'package:canna_go_dev/jsonModal/SearchAddressModel/SearchAddressModel.dart';
import 'package:canna_go_dev/jsonModal/GetAddressModel/GetAddressModel.dart';
import 'package:toast/toast.dart';
import 'package:canna_go_dev/screen/checkOutPage/chekoutPage.dart';
import '../../main.dart';
import '../settingPage/settingPage.dart';



double pickLatitude;
double pickLongitude;
var userData;
  var cannagoData;
class MapPage extends StatefulWidget {

  final lat;
  final lng;

  MapPage(this.lat, this.lng);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

 
  double latitude;
  double longitude;

  double searchLat = 0;
  double searchLong = 0;

  var addresses;
  var first;
  String myAddress = '';
  String newAddress;

  String searchAddr;

  TextEditingController serchController = TextEditingController();

  Set<Marker> _markers = Set();
  Set<Polyline> _polylines = Set();
  CameraPosition _initialPosition;
   //=CameraPosition(target: LatLng(26.8206, 30.8025));
  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void initState() {

    _initialPosition=CameraPosition(target: LatLng(widget.lat, widget.lng));
    _myLocation();
     _getUserInfo();
    super.initState();
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
    });

    //print(userData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.white, 
           automaticallyImplyLeading: false,
              leading: Builder(
    builder: (BuildContext context) { 
      return IconButton(
        icon: const Icon(Icons.arrow_back_ios,color:Color(0xFF01d56a),),
        onPressed: () { 
          //  Navigator.push(
          //             context,
          //             new MaterialPageRoute(
          //                 builder: (context) => Settings(userData, cannagoData)));
      //                     .then((result) {
      // Navigator.of(context).pop(); });
         Navigator.of(context).pop();
         
        },
       
      );
    },
  ),
      
        title: Container(
          margin: EdgeInsets.only(top: 8, bottom: 8),
          decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                   color: Color(0xFFf1f1f1),),
          child: TextField(
                  autofocus: false, 
                  
                  controller: serchController,
                  decoration: InputDecoration(
                      hintText: 'Search Address',
                    
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
                      suffixIcon:  IconButton(
                  icon: Icon(Icons.search, color: Colors.grey),
                  onPressed: (){
                    _searchLocation();
                  },
                )
                          ),
                  onChanged: (val) {
                    setState(() {
                      searchAddr = val;
                    });
                  },
                ),
        ),

              // actions: <Widget>[
              //   IconButton(
              //     icon: Icon(Icons.search, color: Colors.grey),
              //     onPressed: (){
              //       _searchLocation();
              //     },
              //   )
              // ],
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
              onCameraMove: ((_position) => _updatePosition(_position)),
            ),
             Container(
                 alignment: Alignment.topRight,
                 child: Card(
                    elevation: 4,
                    color: Colors.white,
                    child:  IconButton(
                              icon: Icon(Icons.location_searching),
                              onPressed: () {
                               _myLocation();
                              },
                             ),
                  ),
               ),
            // Container(
            //   margin: EdgeInsets.only(top: 8.0, right: 10, left: 10),
            //   // height: 50.0,
            //   width: MediaQuery.of(context).size.width,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10.0),
            //       color: Colors.white),
            //   child: TextField(
            //     controller: serchController,
            //     decoration: InputDecoration(
            //         hintText: 'Enter Address',
            //         border: InputBorder.none,
            //         contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
            //         suffixIcon: IconButton(
            //             icon: Icon(Icons.search),
            //             color: Colors.deepOrangeAccent,
            //             onPressed: () {
            //               _searchLocation();
            //             },
            //             iconSize: 30.0)),
            //     onChanged: (val) {
            //       setState(() {
            //         searchAddr = val;
            //       });
            //     },
            //   ),
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 20, bottom: 15, right: 20),
                  child: FlatButton(
                    color: Color(0xFF01D56A).withOpacity(0.8),
                    disabledColor: Colors.grey,
                    onPressed: () {
                       _updateAddress();
                   
      //                  Navigator.push(
      //                 context,
      //                 new MaterialPageRoute(
      //                     builder: (context) => Settings(userData, cannagoData))).then((result) {
      // Navigator.of(context).pop(); });
                      //  Navigator.push(
                      //   context, SlideLeftRoute(page: Navigation()));
                    },
                    child: Text(
                      "Pick this location",
                      style: TextStyle(color: Colors.white,
                      fontSize: 15),
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                ),
              ],
            ),
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
        if (!mounted) return;
    setState(() {
  // myAddress = first.addressLine;
    _markers.clear();
    _markers.add(
      Marker(

        markerId: MarkerId('locationId'),
        position: LatLng(latitude, longitude),
       // infoWindow: InfoWindow(title: "$myAddress"),
      ),
    );
    });
  }

  Future<void> _searchLocation() async {

    if(serchController.text.isEmpty){
        return _showDialog("Address is empty");
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

    serchController.text = "";
    }
  }

  void _updatePosition(CameraPosition _position) async {
    Marker marker = _markers.firstWhere(
        (p) => p.markerId == MarkerId('marker_2'),
        orElse: () => null);
    setState(() {
      _markers.remove(marker);
    });

    _markers.add(
      Marker(
        markerId: MarkerId('marker_2'),
        position: LatLng(_position.target.latitude, _position.target.longitude),
        // infoWindow: myAddress != ''
        //     ? InfoWindow(title: "$myAddress")
        //     : InfoWindow(
        //         title: '${_position.target.latitude}',
        //         snippet: '${_position.target.longitude}'),
        // infoWindow: InfoWindow(title: '${_position.target.latitude}',
        //         snippet: '${_position.target.longitude}'),
        draggable: true,
        //icon: _searchMarkerIcon,
      ),
    );
    setState(() {
      pickLatitude = _position.target.latitude;
      pickLongitude = _position.target.longitude;
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

  _updateAddress() async{
    latitude = pickLatitude;
    longitude = pickLongitude;
    var myAddress;
    // get the address 
    var coordinates = new Coordinates(latitude, longitude);
    if(coordinates == null){

    myAddress="";
    }
      else{
     
     String url =
        "https://maps.google.com/maps/api/geocode/json?key=AIzaSyAiXNjJ3WpC-U-NKUPY66eQK471y1CiWTY&language=en_US&latlng=$latitude,$longitude";


    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    var collection = json.decode(response.body);

    var addressData = GetAddressModel.fromJson(collection);

    if(addressData.results.length>0){
      if (!mounted) return;

setState(() {
    myAddress=addressData.results[0].formatted_address;
});
    }
    else{
     
       Toast.show("Put your correct address", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
    }



    //      var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
       
    //  var first = addresses.first;
    //  myAddress = first.addressLine;
    //  print("addresses -$myAddress");
      }

      
   
    // save this in user table 
    CallApi().postData({'delLat' : latitude, 'delLong' : longitude, 'delAddress': myAddress}, '/app/update-lat-long');
    // update location shared perferences 
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var userData = json.decode(userJson);
    print(userData['id']);
    userData['delLat'] = latitude;
    userData['delLong'] = longitude;
    userData['delAddress'] = myAddress;
    localStorage.setString('user', json.encode(userData));

    print(userData);


if(store.state.visitCheckToMap==true){
      store.dispatch(VisitMapCheck(false));
       Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => CheckoutPage(store.state.cartList)));
}
// else if(store.state.visitItemToMap==true){
//    store.dispatch(VisitItemTOMapCheck(false));
//        Navigator.push(
//                       context,
//                       new MaterialPageRoute(
//                           builder: (context) => ItemPage(store.state.cartList)));
// }
     
else{
 Navigator.of(context).pop();
}
 
  
  }

}
