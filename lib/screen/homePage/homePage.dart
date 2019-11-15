import 'dart:convert';
import 'package:canna_go_dev/jsonModal/ShopFilterModel/ShopFilterModel.dart';
import 'package:canna_go_dev/jsonModal/shopItemsModal/shopItemsModal.dart';
import 'package:canna_go_dev/widget/bottomAppBar/bottomAppBar.dart';
import 'package:canna_go_dev/api/api.dart';
import 'package:canna_go_dev/customPlugin/routeTransition/routeAnimation.dart';
import 'package:canna_go_dev/jsonModal/shop/shopModel.dart';
import 'package:canna_go_dev/main.dart';
import 'package:canna_go_dev/screen/cartPage/cartPage.dart';
import 'package:canna_go_dev/screen/notificationPage/notificationPage.dart';
import 'package:canna_go_dev/screen/searchFilterPage/searchFilterPage.dart';
import 'package:canna_go_dev/screen/shopPage/shopPage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:canna_go_dev/jsonModal/TotalNotificationModel/TotalNotificationModel.dart';
import 'package:canna_go_dev/redux/action.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
 
class _HomePageState extends State<HomePage> {
  @override
  bool _isLoading = false;
  bool _isSomeWrong = false;
  var shopsData;
   var totalNotifi=0;
  var number;
  bool _text= false;
  bool _shopListEmpty = false;

  TextEditingController searchController  = TextEditingController();

  void initState() {
    bottomNavIndex = 0;
   store.dispatch(ConnectionCheck(true));
     store.dispatch(CheckSearch(false));
    store.state.shopList.length>0?null:_getAllShop();
     _showNewNumber();
     _showNotificationNumber();
    super.initState();
  }
     void _showNewNumber() {
      Timer.periodic(Duration(seconds: 5), (timer) {
    _showNotificationNumber();

     });
// setState(() {
//       _isLoading = false;
//     }); 
     
  }

    void _showNotificationNumber() async {
   

    var res = await CallApi().getData('/app/getUnseenNoti');
    var collection = json.decode(res.body);
    var totalOrder = TotalNotificationModel.fromJson(collection);
  if(totalOrder.notification==null || totalOrder.notification.count==null){
     if (!mounted) return;
    setState(() {
      totalNotifi = 0;
    });
    }
    else{
       if (!mounted) return;
       setState(() {
      totalNotifi = totalOrder.notification.count;
      print("Notific");
     // print(totalNotifi);
    });
    }
    

      if(totalOrder.notification.count>store.state.notificationCount){

          store.dispatch(NotificationCheck(true));

          print("HomePage soman na");
      }
     
     store.dispatch(NotificationCountAction(totalOrder.notification.count)); 


 
    print(totalNotifi);
    print(store.state.notificationCount);
  }

  
  void _updateNotification() async {


    
      if(totalNotifi>0){

          var data = {};

    var res = await CallApi().postData(data, '/app/updateNoti');
    var body = json.decode(res.body);

    print(body);
    print("update homepage body");
   // setState(() {
     // _showNotificationNumber();
       
      }
   
   // });
  
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => NotificationPage()));
  
  }




  Future<void> _getAllShop() async {

    setState(() {
     _isLoading = true; 
    });

    var res = await CallApi().getData('/app/cannagrowAllSearch');
    var data = json.decode(res.body);
    //print(data);
    if (data['success']==true) {
      if (!mounted) return;
      setState(() {
        shopsData = ShopData.fromJson(data);
        _isLoading = false;
      });

        
      store.dispatch(ShopList(shopsData.shop));
    //  store.dispatch(FilterItemsList(shopsData.shop));

    } else {
       if (!mounted) return;
      setState(() {
        _isSomeWrong = true;
      });
    }

    // print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                    backgroundColor: Color(0xFFFFFFFF),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.teal,
      //   child: Icon(Icons.location_searching, color:Colors.white),
      //   onPressed: (){
      //     Navigator.push(
      //                   context, SlideLeftRoute(page: MapPage()));
      //   },
      // ),
      appBar: AppBar(
     //   backgroundColor:Color(0xFFFFFFFF),// Colors.greenAccent,
       backgroundColor: Colors.grey[200],
        automaticallyImplyLeading: false,
        elevation: 0, 
        title: Text("CannaGO",
        style: TextStyle(
          color:Color(0xFF01d56a),
          fontWeight: FontWeight.bold,
          fontSize: 25),),
        actions: <Widget>[

          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
             
              children: <Widget>[
         Container(
              padding: EdgeInsets.only(right: 5),
              child: Stack(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                     _updateNotification();
                    },
                    icon: Icon(Icons.notifications,
                    size: 32,
                    color: Color(0xFF343434),)
                  ),
                     totalNotifi==0 || totalNotifi==null? Container():
                      Positioned(
                        right: 6,
                        top: 3,
                       // left: 10,
                        child: Container(
                          
                         // alignment: Alignment.center,
                          // height: 21,
                          // width: 21,
                          decoration: BoxDecoration(
                            //border: Border.all(color: Colors.white),
                              color: Color(0xFFd20000),
                              borderRadius: BorderRadius.circular(10)
                           // shape: BoxShape.circle
                            ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                         // totalNotifi
                            child: Text(totalNotifi==0?"":totalNotifi>9?"9+":'$totalNotifi',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                          ),
                          //count
                        ),
                      ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 5),
              child: Stack(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.push(context, SlideLeftRoute(page: CartPage()));
                    },
                    icon: Icon(Icons.add_shopping_cart,  size: 30, color: Color(0xFF343434),),
                  ),
                  store.state.numberOfItemInCart==0? Container():Positioned(
                    right: 4,
                    top: 2,
                    child: Container(
                     
                      alignment: Alignment.center,
                      // height: 21,
                      // width: 21,
                      decoration: BoxDecoration(
                          color:  Color(0xFFd20000),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("${store.state.numberOfItemInCart}",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                      ),
                    ),
                  )
                ],
              ), 
            ),
              ],
            ),
          ),
 
        ],
      ),
      body: SafeArea(
        top: false,
        child: Container(
          color: Color(0xFFFFFFFF),
          width: MediaQuery.of(context).size.width,
          //height: MediaQuery.of(context).size.height * 0.50,
          child: Stack(
            children: <Widget>[
              _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.green,
                      ),
                    )
                  : RefreshIndicator(
                    onRefresh: _getAllShop,
                    child:SingleChildScrollView(
                       physics: const AlwaysScrollableScrollPhysics(),
                      child: Container(
                            padding:
                                EdgeInsets.only(top: 60, left: 10, right: 10),
                            child:store.state.isFilter && store.state.filterItemsList.length<1? Container(
                               padding:
                                EdgeInsets.only(top: MediaQuery.of(context).size.height/4),
                              alignment: Alignment.center,
                              child: Text(
                                      'No Shop Found',
                                   
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        decoration: TextDecoration.none,
                                      
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )): _shopListEmpty?//
                            Container(
                               padding:
                                EdgeInsets.only(top: MediaQuery.of(context).size.height/4),
                              alignment: Alignment.center,
                              child: Text(
                                      'No Shop Found',
                                   
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        decoration: TextDecoration.none,
                                      
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ))
                             : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: store.state.isFilter? _filterShops():
                              _displayShops()
                            )),
                    )),

/////////////////  Search BAr//////////
              Positioned(
                child: Container( 
                  height: 50.0,
                 // color:Color(0xFFFFFFFF),// Colors.greenAccent,
                  color: Colors.grey[200],
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 5),
                
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 40.0,
                              
                              //width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(right: 10,left: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.0),
                                   boxShadow:[
                           BoxShadow(color:Colors.grey[200],
                           blurRadius: 17,
                            //offset: Offset(0.0,3.0)
                            )
                         
                         ], 
                                  ///color: Color(0xFFf1f1f1)
                                  color: Colors.white
                                  ),
                              child: TextField(
                               // autofocus: true, 
                               
                               cursorColor: Colors.black,
                                controller: searchController,
                               textInputAction: TextInputAction.search,
                                decoration: InputDecoration(

                                  
                                  prefixIcon: Icon(
                                          
                                           Icons.search,
                                          color:Colors.grey,
                                           //onPressed: searchLocation,
                                          // iconSize: 30.0
                                          ),
                                    
                                    hintText: 'Search',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.only(left: 15.0, top: 10.0),
                                        // suffixIcon: IconButton(
                                        //   onPressed: (){

                                        //   },
                                        //   icon: Icon(Icons.cancel),
                                        // )
                                        suffixIcon: _text?IconButton(
                                         onPressed: () {
                                           searchController.text="";
                                           
                                             setState(() {

                                              _text = false; 

                                             }); 
                                              store.dispatch(CheckFilter(false));
                                                _displayShops();

                                         },
                                         icon: Icon(Icons.cancel),
                                        color:Colors.grey,
                                         //onPressed: searchLocation,
                                        // iconSize: 30.0
                                        ):Icon(
                                          Icons.cancel,
                                          color: Colors.transparent,
                                        ),
                                  ),
                                onChanged: (val) { 
                                  setState(() {
                                    _searchShop();
                                    _text = true;
                                    //searchAddr = val;
                                  });
                                },
                                
                                // onSubmitted:(term) {
                                //   setState(() {
                                //     _text = true; 
                                //   });
                                //         _searchShop();
                                //        searchController.text="";
                                // },
                              ),
                            ),

                      //             Positioned(
                      //  //  padding: EdgeInsets.only(right: 30, top: 8),
                      //  // alignment: Alignment.topRight,
        
                      //    child: Container(
                      //   alignment: Alignment.topLeft,
                     
                      //       child: Padding(
                      //          padding: EdgeInsets.only(right: 10),
                      //         child: IconButton(
                      //                    onPressed: () {
                      //                        _searchShop();

                      //                    },
                      //                    icon: Icon(Icons.search),
                      //                   color:Colors.grey,
                      //                    //onPressed: searchLocation,
                      //                   // iconSize: 30.0
                      //                   ),
                      //       ),
                      //    ),
                      //  )  
                          ], 
                        ),
                      ),
                      Container(
                          height: 45.0,
                          padding: EdgeInsets.only(bottom: 5),
                       //  alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () { 
                            Navigator.push(
                                context, SlideLeftRoute(page: SearchFilter()));
                          },
                          child: Container(
                           
                           // width: 80,
                          
                            padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                        //        // color: Colors.greenAccent.withOpacity(0.6),
                        //           boxShadow:[
                        //    BoxShadow(color:Colors.grey[400],
                        //    blurRadius: 1,
                        //     //offset: Offset(0.0,3.0)
                        //     )
                         
                        //  ], 
                                borderRadius: BorderRadius.circular(6)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                // Text( 
                                //   "Filter",
                                //   style: TextStyle(color: Color(0xFF000000)),
                                // ),
                                Icon(
                                  Icons.filter_list, 
                                  color: Colors.greenAccent[700],
                                )
                              ],
                            ),
                          ),
                        ), 
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

List<Widget> _displayShops(){
   List<Widget> lists = [];
   for(var d in store.state.shopList){

// print("display");
// print(store.state.shopList.length);
    // print("deliveryFee");
    //  print(d.deliveryFee);
      lists.add(
        ShopCard(d)
      );
   }
   return lists;
}

List<Widget> _filterShops(){
   List<Widget> listFilter = [];
   for(var d in store.state.filterItemsList){

    //   print(d.store.deliver);
    //  print("deliveryFee");
    //  print(d.deliveryFee);
      listFilter.add(
        ShopCard(d)
      );
   }
   return listFilter;
}

void _searchShop() async {
 
          
           


  if(searchController.text.isNotEmpty){
    store.dispatch(CheckFilter(true));
      store.dispatch(FilterItemsList([]));
   // return _showErrorDialog("Search field is empty");
  }
  // else{
  //    store.dispatch(CheckFilter(true));
  //     store.dispatch(FilterItemsList([]));
  // }

   setState(() {
       _isLoading = true;
       _shopListEmpty = false; 
    });
   
   var urlSearch = '/app/shopAllSearch?shopName=${searchController.text}'; 
  // var urlSearch = '/app/cannagrowAllSearch';
    var res = await CallApi().getData(urlSearch);
    var collection = json.decode(res.body);

  var filterShop = ShopFilterModel.fromJson(collection);


    store.dispatch(FilterItemsList(filterShop.allShops));
    if(filterShop.allShops == null || filterShop.allShops.length==0){
      setState(() {
       _shopListEmpty = true; 
      });
    }
     print(filterShop.allShops);
    // print(store.state.filterItemsList.length);

    setState(() {
       _isLoading = false;
    });

    // searchController.text="";
}

   void _showErrorDialog(msg) {
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

}

// RaisedButton(
//               onPressed: (){
//                 Navigator.push( context, SlideLeftRoute(page: ShopItemsPage()));
//               },
//               child: Text('Items'),
//             ),
//shop////
class ShopCard extends StatelessWidget {
  final shop; 
  ShopCard(this.shop);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
         store.dispatch(CheckSearch(false));
        store.dispatch(SearchItemsList([]));
        Navigator.push(context, SlideLeftRoute(page: ShopPage(shop)));
      },
      child: Container(
         margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
        decoration: BoxDecoration(
         // color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(15),
            color:Colors.white,
                         boxShadow:[
                           BoxShadow(color:Colors.grey[300],
                           blurRadius: 17,
                            //offset: Offset(0.0,3.0)
                            )
                         
                         ],  
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 180,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    image: new DecorationImage(
                        fit: BoxFit.cover,
                       // image: shop.user.img==null?  new AssetImage('assets/img/ph.jpg'): NetworkImage("https://dynamyk.co"+shop.user.img),
                        image:  new AssetImage('assets/img/shopBanner.jpg'),
                         colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.3), BlendMode.darken)),
                  ),
                ),

                ///////////Offer//////////
               
              // store.state.isFilter? shop.store.deliver=="Yes" ? Container(
              //     margin: EdgeInsets.only(top: 15),
              //     padding:
              //         EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              //     decoration: BoxDecoration(
              //         color: Colors.greenAccent,
              //         borderRadius: BorderRadius.only(
              //             bottomRight: Radius.circular(15),
              //             topRight: Radius.circular(15))),
              //     child: Text(
              //       "Free Delivery",
              //       textAlign: TextAlign.left,
              //       overflow: TextOverflow.ellipsis,
              //       style: TextStyle(
              //           color: Colors.black,
              //           fontFamily: "sourcesanspro",
              //           fontSize: 14,
              //           fontWeight: FontWeight.bold),
              //     ),
              //   ) : Container():
             shop.deliver=="Yes" ?//|| shop.deliver == "Yes" ? 
                Container(
                  margin: EdgeInsets.only(top: 15),
                  padding:
                      EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFFffa900),
                    //  color: Colors.greenAccent,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  child: Text(
                    "Free Delivery",
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "sourcesanspro",
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ) : Container(),

                ////////////offer end//////
              ],
            ),

            ///////////////Details Info/////////////

            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              //color: Colors.blue,
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            shop.name==null?"":"${shop.name}",
                           // store.state.isFilter?shop.store.name==null?"":"${shop.store.name}" :shop.name==null?"":"${shop.name}",
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "DINPro",
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        ///////// rating start //////////
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                size: 15,
                                color: Color(0xFF01D56A),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 3, right: 3),
                                child: Text(
                                  '${shop.avgRating.averageRating}',
                                  //overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'sourcesanspro',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  '(${shop.totalrev.total})',
                                  //overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14.0,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'sourcesanspro',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //////// rating end/////////////
                      ],
                    ),
                  ),

                  ////////////Addresss////////

                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Text(
                            "Address:",
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "sourcesanspro",
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                         shop.address==null?"":"${shop.address}",
                          // store.state.isFilter?shop.store.address==null?"":"${shop.store.address}" :shop.address==null?"":"${shop.address}",
                            //overflow: TextOverflow.ellipsis,
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              decoration: TextDecoration.none,
                              fontFamily: 'sourcesanspro',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ////////Address end////////

                  ////////////open start////////
shop.openingTime==null && shop.closingTime==null?Container():
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Text(
                            "Open:",
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "sourcesanspro",
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            shop.openingTime+' to '+shop.closingTime,
                            //overflow: TextOverflow.ellipsis,
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              decoration: TextDecoration.none,
                              fontFamily: 'sourcesanspro',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),




                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Text(
                            "Free Delivery:",
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "sourcesanspro",
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                          shop.deliver==null?"":"${shop.deliver}",
                          // store.state.isFilter?shop.store.deliver==null?"":"${shop.store.deliver}" :shop.deliver==null?"":"${shop.deliver}",
                            //overflow: TextOverflow.ellipsis,
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              decoration: TextDecoration.none,
                              fontFamily: 'sourcesanspro',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),



                        
                      ],
                    ),
                  ),

                  ////////open end////////
                ],
              ),
            ),

            ///////////////Details Info end/////////////
          ],
        ),
      ),
    );
  }
}
