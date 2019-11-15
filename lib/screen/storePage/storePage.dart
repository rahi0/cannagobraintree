import 'dart:convert';
import 'package:canna_go_dev/api/api.dart';
import 'package:canna_go_dev/customPlugin/routeTransition/routeAnimation.dart';
import 'package:canna_go_dev/jsonModal/shop/shopModel.dart';
import 'package:canna_go_dev/screen/shopPage/shopPage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {

  void _showOverlay(BuildContext context, d) {
    Navigator.of(context).push(StoreDialog(d));
  }


  CameraPosition _initialPosition = CameraPosition(
   bearing: 192.8334901395799,
      target: LatLng(24.3112702, 91.8500061),
      zoom: 14,
  );
  Completer<GoogleMapController> _controller = Completer();
  void _onMapCreated(GoogleMapController controller) {_controller.complete(controller);}

  
  Set<Marker> _markers = Set();
  @override
  void initState() {
    _getShopData();
    super.initState();
  }

  

  _getShopData() async {
      var res = await CallApi().getData('/app/cannagrowAllSearch');
      var collection = json.decode(res.body);
      var shopData = ShopData.fromJson(collection);
      

      for(var d in shopData.shop){
       setState(() {
            _markers.add(
                Marker(
                  markerId: MarkerId('locationId'),
                  position: LatLng(d.lat, d.lng),
                  infoWindow: InfoWindow(title: '${d.lat}, ${d.lng}'),
                  onTap : (){
                     //_showShopInfo(d);
                     _showOverlay(context, d);
                  }
                ),
            );
        });
      }
  }

  void _showShopInfo(d){
     print(d.lat);
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
          width: MediaQuery.of(context).size.width,
          //color: Colors.blue,
          child: Stack(
            children: <Widget>[
        GoogleMap(
          markers: _markers, 
          // polylines: _polylines,
          mapType: MapType.normal,
          onMapCreated: _onMapCreated,
          initialCameraPosition: _initialPosition,
        ),


        Positioned(
          child: Container(
            height: 40.0,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 10, right: 10, top: 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white),
              child: TextField(
                //controller: serchController,
                decoration: InputDecoration(
                  hintText: 'Enter Address',
                  border: InputBorder.none,
                  contentPadding:EdgeInsets.only(left: 15.0, top: 12.0),
                  suffixIcon: IconButton(
                    onPressed: (){
                      
                    },
                    icon: Icon(Icons.search),
                    color: Colors.deepOrangeAccent,
                    //onPressed: searchLocation,
                    iconSize: 30.0)),
                    onChanged: (val) {
                       setState(() {
                         //searchAddr = val;
                         });
                        },
                      ),
                    ),
        ),



        // Positioned(
        //   child: Container(

        //     //color: Colors.red,
        //     child: Center(
        //       child: RaisedButton(
        //         onPressed: ()=>_showOverlay(context),
        //       ),
        //     ),
              
        //             ),
        // )
            ],
          ),
        ),
    );
  }
}



/////////////////////



class StoreDialog extends ModalRoute<void> {
  final d;
  StoreDialog(this.d);
  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Container(
      child: StoreDetails(d),
      //color: Colors.yellow,
    );
  }

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}


//////////////////Store Details///////////////


class StoreDetails extends StatelessWidget {
  final d;
  StoreDetails(this.d);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.70,
          margin: EdgeInsets.only(left: 20, right: 20),
          padding: EdgeInsets.only(top: 15, bottom: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                //color: Colors.blue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  
                  children: <Widget>[
                    Container(
                                margin: EdgeInsets.only(bottom: 20),
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.center,
                                //color: Colors.yellow,
                                child: Text(
                                      "Awsome store",
                                      
                                      //textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 27.0,
                                          decoration: TextDecoration.none,
                                          fontFamily: 'MyriadPro',
                                          fontWeight: FontWeight.normal,
                                      ),
                                    ),
                              ),
                    Container(
                      //height: 40,

                      //color: Colors.blue,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ////////////////
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            //height: 20,
                            //color: Colors.blue,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  width: 120,
                                  //height: 10,
                                  //color: Colors.yellow,
                                  child: Text(
                                        ":Name",
                                        
                                        textDirection: TextDirection.rtl,
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
                                  width: 120,
                                  //height: 10,
                                  //color: Colors.green,
                                  //alignment: Alignment.centerRight,
                                  child: Text(
                                        "Napa",
                                        
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  width: 120,
                                  //height: 10,
                                  //color: Colors.yellow,
                                  child: Text(
                                        ":Average Price",
                                        
                                        textDirection: TextDirection.rtl,
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
                                  width: 120,
                                  //height: 10,
                                  //color: Colors.green,
                                  //alignment: Alignment.centerRight,
                                  child: Text(
                                        "\$ 40",
                                        
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  width: 120,
                                 // height: 10,
                                  //color: Colors.yellow,
                                  child: Text(
                                        ":Store,s House",
                                        
                                        textDirection: TextDirection.rtl,
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
                                  width: 120,
                                  //height: 10,
                                  //color: Colors.green,
                                  //alignment: Alignment.centerRight,
                                  child: Text(
                                      "24",
                                        
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  width: 120,
                                  //height: 10,
                                  //color: Colors.yellow,
                                  child: Text(
                                        ":Item",
                                        
                                        textDirection: TextDirection.rtl,
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
                                  width: 120,
                                  //height: 10,
                                  //color: Colors.green,
                                  //alignment: Alignment.centerRight,
                                  child: Text(
                                      "12",
                                        
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
                        ],
                      ),
                    ),




/////////////////
                    Container(
                      //color: Colors.yellow,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only( bottom: 15, top: 15),
                      padding: EdgeInsets.only(left: 40, right: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                                        "Description",
                                        
                                        textDirection: TextDirection.ltr,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0,
                                            decoration: TextDecoration.none,
                                            fontFamily: 'MyriadPro',
                                            fontWeight: FontWeight.bold,
                                        ),
                                      ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            width: 250,
                            //color: Colors.green,
                            child: Text(
                                        "jhbfkd dajfls wjfh l flwiefjw wlf gdv adg  auf  lflaiefh l alief",  
                                        textDirection: TextDirection.ltr,
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 12.0,
                                            decoration: TextDecoration.none,
                                            fontFamily: 'MyriadPro',
                                            fontWeight: FontWeight.normal,
                                        ),
                                      ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
///////////////////////////////////////////
              Container(
                //color: Colors.yellow,
                margin: EdgeInsets.only(top: 10),
                 padding: EdgeInsets.only(left: 20, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    

                    ///////////////// Shop Now Button  Start///////////////

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
                              Icon(Icons.add_shopping_cart, color: Colors.white,),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                          'Shop Now',
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
                            Navigator.push( context, SlideLeftRoute(page: ShopPage(d)));
                          },
                        )),

                    ///////////////// Next In Button  End///////////////
                    




                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        //padding: EdgeInsets.only(left: 20),
                         child: Text(
                                      'Close',
                                      
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          decoration: TextDecoration.underline,
                                          fontFamily: 'MyriadPro',
                                          fontWeight: FontWeight.normal,
                                      ),
                                    ),
                        //color: Colors.red,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          ),
        ],
      ),
    );
  }
}

