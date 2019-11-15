import 'package:canna_go_dev/customPlugin/routeTransition/routeAnimation.dart';
import 'package:canna_go_dev/form/logInForm/logInForm.dart';
import 'package:canna_go_dev/redux/action.dart';
import 'package:canna_go_dev/screen/notificationPage/notificationPage.dart';
import 'package:canna_go_dev/widget/bottomAppBar/bottomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:canna_go_dev/jsonModal/DirectionModel/DirectionJson.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';

import '../../main.dart';

class DriverLocation extends StatefulWidget {
  final data;
  DriverLocation(this.data);

  @override
  _DropLocationState createState() => _DropLocationState();
}

class _DropLocationState extends State<DriverLocation> {
  double latitude;
  double longitude;
  double dropLatitude;
  double dropLongitude;
  var distance;
  var duration;
  var addresses;
  var first;
  var path;
  String dropAddress;
  String newAddress;
  BitmapDescriptor texiIcon;
  bool _getData = true;
  double socketLatitude;
  double socketLongitude;
  List locList=[];



    SocketIOManager manager;

    Map<String, SocketIO> sockets = {};
  Map<String, bool> _isProbablyConnected = {};
  var resLat;
  var reslng;

  var lastLat;
  var lastLng;

  var markerLat;
  var markerLng;

 // String _isSocket = "noConnection";

  TextEditingController serchController = TextEditingController();

  Set<Marker> _markers = Set();
  Set<Polyline> _polylines = Set();
  CameraPosition _initialPosition;// = CameraPosition(target: LatLng(initLat, initLng));
  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  var allSeller;

  var latitudeJson;
  var longitudeJson;
 
  void initState() {

  manager = SocketIOManager();
     

     print(store.state.isSocket);
      
    
   _initialPosition = CameraPosition(target: LatLng(widget.data.lat, widget.data.lng), zoom: 14);
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(80, 80)), 'assets/img/taxi.png')
        .then((onValue) { 
      texiIcon = onValue;
    });

    _myMovement();
    // store.state.isSocket=="isDisconnected"?_callData():null;
    _callData();
      _getSocket();

    super.initState();

  }

  @override
  void dispose() {
    widget.data.status == 'Order is on the way' ||widget.data.status=='driver map visible' ?disconnect("${widget.data.driverId}"):null;

    super.dispose();
  }

  
  disconnect(String order) async {

     print("disconnect");
    await manager.clearInstance(sockets[order]);
     if (!mounted) return;
    setState(() => _isProbablyConnected[order] = false);

  }
void _callData(){

  var latDrop;
  var lngDrop;    

  for(var d in store.state.locationList){

   

     if(d['locationid']=='${widget.data.driverId}'){

        latDrop = d['locationLat'];
        lngDrop = d['locationLng'];

//print("ifffffffffffffffffffff");
 print(d['locationid']);
   latDrop = double.parse(latDrop);
   lngDrop = double.parse(lngDrop);
 _draw(latDrop, lngDrop);
  _showDropLocation(latDrop, lngDrop);
     }
  }
//  print("locccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc");
 

    //_getSocket();
}
    void _sendSocketData() async{

 GoogleMapController controller = await _controller.future;
           var location = new Location();

          location.onLocationChanged().listen((LocationData currentLocation) {


           
            socketLatitude = currentLocation.latitude;
            socketLongitude = currentLocation.longitude;

           
            controller.animateCamera(
          CameraUpdate.newLatLngZoom(LatLng(socketLatitude, socketLongitude), 14));
            
    
            Marker marker = _markers.firstWhere(
        (p) => p.markerId == MarkerId('LocationId'),
        orElse: () => null);
         if (!mounted) return;
    setState(() {
      _markers.remove(marker);
    });
        _markers.add(
          Marker(
             icon: texiIcon,
            markerId: MarkerId('LocationId'),
            position: LatLng(socketLatitude, socketLongitude),

             onTap: () {
           // _distanceList();
            //  _draw();

            duration == null ? pleaseDialog() : dialog();
          },
           // infoWindow: InfoWindow(title: socketLatitude.toString(),snippet: socketLongitude.toString())
          ),
        );
            
     
  

});




  }

  
    void _getSocket() async{

   GoogleMapController controller = await _controller.future;

     setState(() => _isProbablyConnected['${widget.data.driverId}'] = true);

 SocketIO socket = await SocketIOManager().createInstance(SocketOptions(
      //Socket IO server URI
        'https://www.dynamyk.biz/',
        nameSpace: '/',
        //Query params - can be used for authentication
        query: {
            'orderId': '${widget.data.driverId}',
        },
        //Enable or disable platform channel logging
        enableLogging: false,
        transports: [Transports.WEB_SOCKET/*, Transports.POLLING*/] //Enable required transport
    ));       
    socket.onConnect((data){
      print("connected...");
      // print(data);
      // socket.emit("Msg", ["Hello world!"]);
     // socket.emit("driver_location", [{"lat":lat,"lng":lng}]);
     //  print("connected end..."); 
    });
    // socket.on("news", (data){   //sample event
    //   print("news");
    //   print(data);
    // });



    socket.on("driver_location_from_server_${widget.data.driverId}", (data){  
      
      
       //sample event
     
     store.dispatch(DriverSocketConnection("isConnected"));
      print(data);
     

     _initialPosition = CameraPosition(target: LatLng(data['lat'], data['lng']));

     store.dispatch(DriverLatLng(data['lat'], data['lng']));
     print(store.state.driverLat);

   

      //  lastLat = data['lat'];
      //  lastLng = data['lng'];

     _draw(data['lat'],data['lng']);
     _showDropLocation(data['lat'],data['lng']);
 
    });


    // setState(() {
    //  markerLat = lastLat;
    //  markerLng = lastLng; 
    // });


    socket.on("driver_${widget.data.driverId}_disconnected", (data){   //sample event
     
       print(data);   
    
      var lastData={
      'locationid':  '${widget.data.driverId}',
      'locationLat':  '${store.state.driverLat}',
      'locationLng' : '${store.state.driverLng}'
      };
      //    print("location");



    //print(store.state.locationList);
 // }
       store.dispatch(LocationList(lastData));
      // // locList.add(lastData);

  //  print(store.state.locationList.length);
  //      print(store.state.locationList);
     // print(locList.length);
     //  print(locList);
   
     Toast.show("Driver turned off his Gps Service", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);


    });

    

  
    socket.connect();

     sockets['${widget.data.driverId}'] = socket;

  }


  

  // void _changeWithTime() { 
  //   if (!mounted) return;
  //   Timer.periodic(Duration(seconds: 1), (timer) {
  //     _myMovement();
  //   });
  // }

  void _myMovement() async {
    // GoogleMapController controller = await _controller.future;
    // LocationData currentLocation;
    // var location = Location();

    // try {
    //   currentLocation = await location.getLocation();
    // } on Exception {
    //   currentLocation = null;
    // }

    // latitude = currentLocation.latitude;
    // longitude = currentLocation.longitude;

     SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
  
   var  userData = json.decode(userJson);
   
     setState(() {
        latitude = userData['delLat'];
        longitude = userData['delLong'];
     });

   if (!mounted) return;
    setState(() {
      _markers.add(
        Marker(
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
          markerId: MarkerId("drop"),
          position: LatLng(latitude, longitude),
        //  infoWindow: InfoWindow(title: "My Location")
         
        ),
      );
    });
    // Timer.periodic(Duration(seconds: 3), (timer) {
    //   latitude = latitude + 0.1;
    //   longitude = longitude + 0.1;
    // });

    /////  get drop location////

    // dropLatitude = widget.data.buyer.delLat;
    // dropLongitude = widget.data.buyer.delLong;

   // location.onLocationChanged().listen((LocationData currentLocation) {
      // controller.animateCamera(
      //     CameraUpdate.newLatLngZoom(LatLng(latitude, longitude), 15)); //22

    //   Marker marker = _markers.firstWhere(
    //       (p) => p.markerId == MarkerId('dropLocationId'),
    //       orElse: () => null);
    //   if (!mounted) return;
    //   setState(() {
    //     _markers.remove(marker);
    //   });
    //   _markers.add(
    //     Marker(
    //       icon: texiIcon,
    //       markerId: MarkerId('dropLocationId'),
    //       position: LatLng(latitude, longitude),
    //         onTap: () {
    //         _distanceList();
    //         //  _draw();

    //         duration == null ? pleaseDialog() : dialog();
    //       },
    //     ),
    //   );
    // });
  }

  void _showDropLocation(double lat, double lng) async {

  GoogleMapController controller = await _controller.future;

   
    // dropLatitude = widget.data.lat;
    // dropLongitude = widget.data.lng;
 
    // dropLatitude =24.897503;
    // dropLongitude = 91.8710354; 

    // print("dropLocation");
    // print(dropLatitude);

    //    controller.animateCamera(CameraUpdate.newCameraPosition(
    //   CameraPosition(
    //     target: LatLng(lat,lng),
    //     zoom: 20.0,
    //   ),
    // ));
   Marker marker = _markers.firstWhere(
          (p) => p.markerId == MarkerId('drvrId'),
          orElse: () => null);
      if (!mounted) return;
      setState(() {
        _markers.remove(marker);
      });
   

    // if (!mounted) return;
    // setState(() {
      _markers.add(
        Marker(
          icon: texiIcon,
          markerId: MarkerId('drvrId'),
          position: LatLng(lat,lng),
         // infoWindow: InfoWindow(title: lat.toString(),snippet: lng.toString())
          onTap: () {
           // _distanceList();
            //  _draw();

            duration == null ? pleaseDialog() : dialog();
          },
        ),
      );
   //  });
     
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Driver Location',
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
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            // _getData
            //     ? Center(child: CircularProgressIndicator())
            //     : 
                GoogleMap(
                    markers: _markers,
                    polylines: _polylines,
                    mapType: MapType.normal,
                    // myLocationEnabled: true,
                    // myLocationButtonEnabled: true,
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: _initialPosition,
                  ),
          ],
        ),
      ),
    );
  }

  // void _myLocation() async {
  // GoogleMapController controller = await _controller.future;

  // SharedPreferences localStorage = await SharedPreferences.getInstance();

  // latitudeJson = localStorage.getString('Latitude');
  // longitudeJson = localStorage.getString('Longitude');

  // latitude = double.parse(latitudeJson); //latitudeJson;
  // longitude = double.parse(longitudeJson);

// latitude = 24.897503;
// longitude = 91.8710354;

  // controller.animateCamera(
  //     CameraUpdate.newLatLngZoom(LatLng(latitude, longitude), 14)); //17

  //}

  void _distanceList() async {
    // SharedPreferences localStorage = await SharedPreferences.getInstance();

    // latitudeJson = localStorage.getString('Latitude');
    // longitudeJson = localStorage.getString('Longitude');

    // latitude = double.parse(latitudeJson); //latitudeJson;
    // longitude = double.parse(longitudeJson);
//  dropLatitude =24.897503;
//     dropLongitude = 91.8710354; 

     dropLatitude = widget.data.lat;
    dropLongitude = widget.data.lng;
 

      SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
  
   var  userData = json.decode(userJson);
   
     setState(() {
        latitude = userData['delLat'];
        longitude = userData['delLong'];
        //address = userData['delAddress'];
     });

    
   

    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=$latitude,$longitude&destination=$dropLatitude,$dropLongitude&key=AIzaSyAiXNjJ3WpC-U-NKUPY66eQK471y1CiWTY";

    // "https://maps.googleapis.com/maps/api/directions/json?origin=Sylhet&destination=Dhaka&key=AIzaSyAiXNjJ3WpC-U-NKUPY66eQK471y1CiWTY";

    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    var collection = json.decode(response.body);

    var data = DirectionList.fromJson(collection);

    var status = data.status;

    // if (status == 'OK') {
    for (var d in data.routes) {
      path = d.overview_polyline.points;
    }

    // } else {
    //   path = "";
    // }

    for (var d in data.routes) {
      for (var dd in d.legs) {
        distance = dd.distance.text;
        duration = dd.duration.text;
      }
    }
  }

  void dialog() {
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
                  height: 110,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new AssetImage('assets/img/camera.png'),
                      ))),
            ],
          ),
          content: Container(
            padding: EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3,
            margin: EdgeInsets.only(right: 10, left: 10, bottom: 5),
            child: Column(
              children: <Widget>[
                duration == null
                    ? Text("Network error...")
                    : RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Driver Name: ',
                              style: TextStyle(
                                  color: Color(0xFF343434),
                                  fontFamily: "grapheinpro-black",
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: widget.data.driver.user.name == null
                                  ? ""
                                  : widget.data.driver.user.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "grapheinpro-black",
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                // duration == null
                //     ? Text("Network error...")
                //     : RichText(
                //         text: TextSpan(
                //           children: <TextSpan>[
                //             TextSpan(
                //               text: 'Delivery Address : ',
                //               style: TextStyle(
                //                   color: Colors.teal,
                //                   fontFamily: "grapheinpro-black",
                //                   fontSize: 14,
                //                   fontWeight: FontWeight.bold),
                //             ),
                //             TextSpan(
                //               text: widget.data.driver.lat == null
                //                   ? ""
                //                   : widget.data.driver.lng,
                //               style: TextStyle(
                //                   color: Colors.black,
                //                   fontFamily: "grapheinpro-black",
                //                   fontSize: 14,
                //                   fontWeight: FontWeight.normal),
                //             ),
                //           ],
                //         ),
                //       ),
               
                distance == null
                    ? Text("Network error...")
                    : RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Duration: ',
                              style: TextStyle(
                                   color: Color(0xFF343434),
                                  fontFamily: "grapheinpro-black",
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: distance == null ? "" : distance,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "grapheinpro-black",
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ), SizedBox(height: 5),
                duration == null
                    ? Text("Network error...")
                    : RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Duration: ',
                              style: TextStyle(
                                   color: Color(0xFF343434),
                                  fontFamily: "grapheinpro-black",
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: duration == null ? "" : duration,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "grapheinpro-black",
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                SizedBox(height: 12),
                // distance == null
                //     ? Text("Network error...")
                //     : RichText(
                //         text: TextSpan(
                //           children: <TextSpan>[
                //             TextSpan(
                //               text: 'Distance: ',
                //               style: TextStyle(
                //                   color: Colors.teal,
                //                   fontFamily: "grapheinpro-black",
                //                   fontSize: 14,
                //                   fontWeight: FontWeight.bold),
                //             ),
                //             TextSpan(
                //               text: distance == null ? "" : distance,
                //               style: TextStyle(
                //                   color: Colors.black,
                //                   fontFamily: "grapheinpro-black",
                //                   fontSize: 14,
                //                   fontWeight: FontWeight.normal),
                //             ),
                //           ],
                //         ),
                //       ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.greenAccent[400],
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        height: 30,
                        // width: 90,
                        margin: EdgeInsets.only(top: 20, bottom: 15),
                        child: OutlineButton(
                            color: Colors.greenAccent[400],
                            child: new Text(
                              "Close",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            borderSide:
                                BorderSide(color: Colors.green, width: 0.5),
                            shape: new RoundedRectangleBorder(
                                borderRadius:
                                    new BorderRadius.circular(20.0)))),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void pleaseDialog() {
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
                  height: 110,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new AssetImage('assets/images/neterror.png'),
                      ))),
            ],
          ),
          content: Container(
            padding: EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: 100,
            margin: EdgeInsets.only(right: 10, left: 10, bottom: 5),
            child: Column(
              children: <Widget>[
                Text(
                  "Network error...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: "grapheinpro-black",
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.greenAccent[400],
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        height: 30,
                        // width: 120,
                        margin: EdgeInsets.only(top: 15, bottom: 15),
                        child: OutlineButton(
                            color: Colors.greenAccent[400],
                            child: new Text(
                              "Try Again",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            borderSide:
                                BorderSide(color: Colors.green, width: 0.5),
                            shape: new RoundedRectangleBorder(
                                borderRadius:
                                    new BorderRadius.circular(20.0)))),
                  ],
                )
              ],
            ),
          ),
        );
        //return SearchAlert(duration);
      },
    );
  }

  List<LatLng> decodePolyline(String encoded) {
    List<LatLng> points = new List<LatLng>();

    int index = 0;
    int len;

    len = encoded.length;

    if (len == 0) {
      points = [];
    }

    int lat = 0, lng = 0;
    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;
      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;
      LatLng p = new LatLng(lat / 1E5, lng / 1E5);
      points.add(p);
    }
    return points;
  }

  Future<void> _draw(double lat, double lng) async {



   // print("check dataaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");

      dropLatitude = widget.data.lat;
    dropLongitude = widget.data.lng;
      SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
  
   var  userData = json.decode(userJson);
   if (!mounted) return;
     setState(() {
        latitudeJson = userData['delLat'];
        longitudeJson = userData['delLong'];
        //address = userData['delAddress'];
     });

  
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=$latitudeJson,$longitudeJson&destination=$lat,$lng&key=AIzaSyAiXNjJ3WpC-U-NKUPY66eQK471y1CiWTY";

    // "https://maps.googleapis.com/maps/api/directions/json?origin=Sylhet&destination=Dhaka&key=AIzaSyAiXNjJ3WpC-U-NKUPY66eQK471y1CiWTY";

    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    var collection = json.decode(response.body);

    var data = DirectionList.fromJson(collection);

    // var status = data.status;
 
    // if (status == 'OK') {
    for (var d in data.routes) {
      path = d.overview_polyline.points;
    }

    // } else {
    //   path = "";
    // }

    for (var d in data.routes) {
      for (var dd in d.legs) {
        distance = dd.distance.text;
        duration = dd.duration.text;
      }
    }

    var drawPoints = decodePolyline(path);
    if (!mounted) return;

    setState(() {
      _polylines.clear();
      _polylines.add(Polyline(
          visible: true,
          color: Colors.red,
          polylineId: PolylineId("polyLineId"),
          points: drawPoints));

      _getData = false;
    });
  }
}
