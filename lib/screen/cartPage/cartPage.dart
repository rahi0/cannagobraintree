import 'dart:convert';
import 'dart:async';
import 'package:canna_go_dev/api/api.dart';
import 'package:canna_go_dev/customPlugin/routeTransition/routeAnimation.dart';
import 'package:canna_go_dev/jsonModal/cartModal/cartModal.dart';
import 'package:canna_go_dev/jsonModal/shopItemsModal/shopItemsModal.dart';
import 'package:canna_go_dev/main.dart';
import 'package:canna_go_dev/redux/action.dart';
import 'package:canna_go_dev/screen/checkOutPage/chekoutPage.dart';
import 'package:canna_go_dev/widget/CartPageWidget/recomendCard.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var cartData;
  bool _isLoading = true;
  bool _isDeleted = false;
  var itemData;
  var addedItem;
  var shopId;
  List cartItemList = [];
  var recommendeditems;
  @override
  void initState() {
    _showProducts();
    super.initState();
  }

  Future _showProducts() async {
    var res = await CallApi().getData('/app/curts');
    var data = json.decode(res.body);

    var curtItems = CurtData.fromJson(data);

    setState(() {
      addedItem = curtItems.curt;
      print(addedItem);
    });

    for (var d in addedItem) {
      cartItemList.add(d.itemId);
      shopId = d.item.growId;
    }
    store.dispatch(CartList(addedItem));

    if (store.state.numberOfItemInCart < addedItem.length) {
      if (store.state.numberOfItemInCart == 0) {
        store.dispatch(UpdateCart(addedItem.length));
      }
      if (store.state.numberOfItemInCart == 1) {
        store.dispatch(UpdateCart(addedItem.length - 1));
      }
    }

    var dataCurt = {
      'itemIds': cartItemList,
    };

    print(dataCurt);
    var resCurt = await CallApi()
        .postData(dataCurt, '/app/allShopRecommendedItems/$shopId');
    var collectionCurt = json.decode(resCurt.body);
    print("recommended");
    //  print(bodyCurt);
    var recommend = ShopItems.fromJson(collectionCurt);
    setState(() {
      recommendeditems = recommend.allItems;
      _isLoading = false;
    });

    // for(var d in recommendeditems){
    //   print(d.name);
    // }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 6) / 1.6;
    final double itemWidth = size.width / 2+10;

    return Scaffold(
      //  resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xFFFFFFFF),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green,
              ),
            )
          : SafeArea(
              child:OrientationBuilder(builder: (context, orientation) { 
               return orientation ==
                                                  Orientation.portrait?
                                                   Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ///////// left arrow icon///////

                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        //color: Colors.blue,
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.keyboard_arrow_left,
                            size: 50, color: Color(0xFF01D56A)),
                      ),
                    ),

                    Container(
                      //color: Colors.yellow,
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ////////////////  cart text /////////
                          Container(
                            child: Text(
                              "Cart",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontFamily: "MyriadPro",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /////////// Add Grid //////////
                    Expanded(
                      child: Card(
                        elevation: 1,
                        child: Container(
                            // color: Colors.blue,
                            padding: EdgeInsets.only(
                                left: 10, bottom: 5, top: 5, right: 10),
                            //height: 320,
                            width: MediaQuery.of(context).size.width,
                            child: addedItem == null
                                ? Center(child: Text('Your cart is empty.'))
                                : addedItem.length < 1
                                    ? Center(child: Text('Your cart is empty.'))
                                    : GridView.count(
                                        crossAxisCount: 3,
                                         crossAxisSpacing: 8.0,
                           childAspectRatio:(MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2) /
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      1.8),/// (
                                        // childAspectRatio:
                                        //     (itemWidth / itemHeight),
                                        physics: BouncingScrollPhysics(),
                                        //controller: new ScrollController(keepScrollOffset: false),
                                        shrinkWrap: true,
                                        children: List.generate(
                                            addedItem.length, (index) {
                                          return //_isDeleted ? Container() :
                                              Container(
                                                padding: EdgeInsets.only(top: 10),
                                                child: Stack(
                                                  children: <Widget>[
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          top: 5),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xFFFFFFFF),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15),
                                                                      
                            boxShadow:[
                           BoxShadow(color:Colors.grey[300],
                           blurRadius: 17,
                            //offset: Offset(0.0,3.0)
                            )
                         
                         ], 
                                                                      ),
                                                                      
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                         addedItem[index]
                                                                            .item
                                                                            .img ==
                                                                        null
                                                                    ? Container(
                                                              width: 110,
                                                              height: 110, 
                                                              //margin: EdgeInsets.only(left: 15),
                                                              decoration:
                                                                  new BoxDecoration(
                                                                      shape: BoxShape.circle,

                                                                      image:
                                                                          new DecorationImage(
                                                                fit:
                                                                    BoxFit.fill,
                                                                image: 
                                                                // addedItem[index]
                                                                //             .item
                                                                //             .img ==
                                                                //         null
                                                                 //   ?
                                                                     new AssetImage(
                                                                        "assets/img/medicine_icon.PNG")
                                                                    // : NetworkImage("https://www.dynamyk.biz" +
                                                                    //     addedItem[index]
                                                                    //         .item
                                                                    //         .img),
                                                                // NetworkImage('http://10.0.2.2:3333'+addedItem[index].item.img)
                                                              ))):
                                                               Container(
                                                                 margin: EdgeInsets.all(5),
                                                              width: 90,
                                                              height: 90, 
                                                              //margin: EdgeInsets.only(left: 15),
                                                              decoration:
                                                                  new BoxDecoration(
                                                                      shape: BoxShape.circle,

                                                                      image:
                                                                          new DecorationImage(
                                                                fit:
                                                                    BoxFit.fill,
                                                                image:
                                                                //  addedItem[index]
                                                                //             .item
                                                                //             .img ==
                                                                //         null
                                                                //     ? new AssetImage(
                                                                //         "assets/img/medicine_icon.PNG")
                                                                    //: 
                                                                    NetworkImage("https://www.dynamyk.biz" +
                                                                        addedItem[index]
                                                                            .item
                                                                            .img),
                                                                // NetworkImage('http://10.0.2.2:3333'+addedItem[index].item.img)
                                                              ))),
                                                          Container(
                                                            // color: Colors.red,
                                                            // width: 100,
                                                            alignment: Alignment
                                                                .center,
                                                            // margin: EdgeInsets.only(top: 2, bottom: 2),
                                                            // padding: EdgeInsets.only(left: 8),
                                                            child: Text.rich(
                                                              TextSpan(
                                                                  children: <
                                                                      TextSpan>[
                                                                    TextSpan(
                                                                      text: //"4",
                                                                          "\$ ${(addedItem[index].item.price).toStringAsFixed(2)}", //"\$${store.state.cart.item.price}",
                                                                      style: TextStyle(
                                                                          color: Color(
                                                                              0xFF00bb5d),
                                                                          fontFamily:
                                                                              "sourcesanspro",
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    // TextSpan(
                                                                    //   text: ".55",
                                                                    //   style: TextStyle(
                                                                    // color: Color(0xFF01D56A),
                                                                    // fontFamily: "sourcesanspro",
                                                                    // fontSize: 12,
                                                                    // fontWeight: FontWeight.w400
                                                                    //       ),
                                                                    // ),
                                                                  ]),
                                                            ),
                                                          ),
                                                          Container(
                                                            // color: Colors.blue,
                                                            //   width: 100,
                                                            //  height: 15,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 3,
                                                                    bottom: 5),
                                                            child: Text(
                                                              //"sefraf",
                                                              addedItem[index]
                                                                  .item
                                                                  .name,
                                                              //widget.data.item.name,
                                                              //  widget.data['item']['name'],

                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFF202020),
                                                                  fontFamily:
                                                                      "sourcesanspro",
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                          // Container(
                                                          //   width: 100,
                                                          //   //  height: 10,
                                                          //   margin: EdgeInsets.only(top: 3),
                                                          //   child: Text(
                                                          //     "900v",
                                                          //     overflow: TextOverflow.ellipsis,
                                                          //     textAlign: TextAlign.center,
                                                          //     style: TextStyle(
                                                          //         color: Color(0xFF000000),
                                                          //         fontFamily: "sourcesanspro",
                                                          //         fontSize: 13,
                                                          //         fontWeight: FontWeight.w400),
                                                          //   ),
                                                          // ),
                                                          Container(
                                                            // color: Colors.red,
                                                            // margin: EdgeInsets.only(top: 1),
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 5,
                                                                    right: 5,
                                                                    top: 5),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: <
                                                                  Widget>[
                                                                ///////////// Dicrement Button////////
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    _changeItemQuantiy(
                                                                        addedItem[
                                                                            index],
                                                                        -1);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border:
                                                                          Border(
                                                                        top: BorderSide(
                                                                            width:
                                                                                1,
                                                                            color:
                                                                                Color(0xFF9b9b9b)),
                                                                        left:
                                                                            BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Color(0xFF9b9b9b),
                                                                        ),
                                                                        right:
                                                                            BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Color(0xFF9b9b9b),
                                                                        ),
                                                                        bottom:
                                                                            BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Color(0xFF9b9b9b),
                                                                        ),
                                                                      ),
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    child: Icon(
                                                                      Icons
                                                                          .remove,
                                                                      size: 18,
                                                                    ),
                                                                  ),
                                                                ),

                                                                //////////// Dicrement Button end////////

                                                                ///////////Quantity start /////////
                                                                Container(
                                                                  //width: 100,
                                                                  //  height: 10,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              3),
                                                                  child: Text(
                                                                    "${addedItem[index].quantity}",
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0xFF000000),
                                                                        fontFamily:
                                                                            "sourcesanspro",
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                                ///////////Quantity end /////////

                                                                //////////// Increment Button////////
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    _changeItemQuantiy(
                                                                        addedItem[
                                                                            index],
                                                                        1);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border:
                                                                          Border(
                                                                        top: BorderSide(
                                                                            width:
                                                                                1,
                                                                            color:
                                                                                Color(0xFF9b9b9b)),
                                                                        left:
                                                                            BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Color(0xFF9b9b9b),
                                                                        ),
                                                                        right:
                                                                            BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Color(0xFF9b9b9b),
                                                                        ),
                                                                        bottom:
                                                                            BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Color(0xFF9b9b9b),
                                                                        ),
                                                                      ),
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    child: Icon(
                                                                      Icons.add,
                                                                      size: 18,
                                                                    ),
                                                                  ),
                                                                )

                                                                //////////// Increment Button end////////
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),

                                                    //////////////////Positioned //////////////////
                                                    Positioned(
                                                      right: 1,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          _deleteCart(
                                                              addedItem[index]
                                                                  .id);
                                                        },
                                                        child: Container(
                                                          // margin: EdgeInsets.only(left: 85),
                                                          child: Icon(
                                                              Icons.cancel),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                        }),
                                      )
                            // new FutureBuilder<List<CurtData>>(
                            //   future: fetchCountry(new http.Client()),
                            //   builder: (context, snapshot) {
                            //     if (snapshot.hasError) print(snapshot.error);
                            //     return snapshot.hasData
                            //         ?
                            //         : new Center(
                            //             child: new CircularProgressIndicator());
                            //   },
                            // ),
                            ),
                      ),
                    ),
                    /////////// Add Grid //////////

                    ////////////////  Recommended Items /////////
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 20, left: 20, bottom: 5),
                      child: Text(
                        "Recommended Items",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: "MyriadPro",
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 20,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFF00CE7C),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomRight: Radius.circular(50)),
                            ),
                            child: Icon(
                              Icons.keyboard_arrow_left,
                              size: 25,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: Color(0xFFFFFFFF),
                              height: 170,
                              padding: EdgeInsets.only(left: 8, right: 8),
                              child: ListView(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                children: _recomendedItems(),
                              ),
                            ),
                          ),
                          Container(
                            width: 20,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFF00CE7C),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(50),
                              ),
                            ),
                            child: Icon(
                              Icons.keyboard_arrow_right,
                              size: 25,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ],
                      ),
                    ),

                    ////////////////Butoon Start//////////////////////

                    Container(
                      //color: Colors.blue,
                      margin: EdgeInsets.only(top: 15, bottom: 20),
                      padding: EdgeInsets.only(left: 30, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          /////////////// "back" button start///////////////
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              //margin: EdgeInsets.only(left: 20,top: 10),
                              child: Text(
                                "Back",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontFamily: "standard-regular",
                                    // decoration: TextDecoration.underline,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),

                          /////////////// "back" button end///////////////

                          ///////////////// next Button start///////////////
                          Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: addedItem == null
                                    ? Colors.grey
                                    : addedItem.length < 1
                                        ? Colors.grey
                                        : Color(0xFF00CE7C),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                              //width: 180,
                              height: 42,
                              padding: EdgeInsets.only(left: 25, right: 25),
                              // margin: EdgeInsets.only(right: 20),
                              child: FlatButton(
                                onPressed: addedItem == null
                                    ? null
                                    : addedItem.length < 1 ? null : _cartNext,
                                child: Text(
                                  addedItem == null
                                      ? 'No item'
                                      : addedItem.length < 1
                                          ? 'No item'
                                          : 'Next',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "grapheinpro-black",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              )),

                          ///////////////// Next button end///////////////
                        ],
                      ),
                    )
                  ],
                ),
              ):

                                                   Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ///////// left arrow icon///////

                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        //color: Colors.blue,
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.keyboard_arrow_left,
                            size: 50, color: Color(0xFF01D56A)),
                      ),
                    ),

                    Container(
                      //color: Colors.yellow,
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ////////////////  cart text /////////
                          Container(
                            child: Text(
                              "Cart",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontFamily: "MyriadPro",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /////////// Add Grid //////////
                    Expanded(
                      child: Card(
                        elevation: 1,
                        child: Container(
                            // color: Colors.blue,
                            padding: EdgeInsets.only(
                                left: 10, bottom: 5, top: 5, right: 10),
                            //height: 320,
                            width: MediaQuery.of(context).size.width,
                            child: addedItem == null
                                ? Center(child: Text('Your cart is empty.'))
                                : addedItem.length < 1
                                    ? Center(child: Text('Your cart is empty.'))
                                    : GridView.count(
                                        crossAxisCount: 3,
                                         crossAxisSpacing: 8.0,
                           childAspectRatio:(MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2) /
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      1),/// (
                                        // childAspectRatio:
                                        //     (itemWidth / itemHeight),
                                        physics: BouncingScrollPhysics(),
                                        //controller: new ScrollController(keepScrollOffset: false),
                                        shrinkWrap: true,
                                        children: List.generate(
                                            addedItem.length, (index) {
                                          return //_isDeleted ? Container() :
                                              Container(
                                                padding: EdgeInsets.only(top: 10),
                                                child: Stack(
                                                  children: <Widget>[
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          top: 5),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xFFFFFFFF),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15),
                                                                      
                            boxShadow:[
                           BoxShadow(color:Colors.grey[300],
                           blurRadius: 17,
                            //offset: Offset(0.0,3.0)
                            )
                         
                         ], 
                                                                      ),
                                                                      
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                         addedItem[index]
                                                                            .item
                                                                            .img ==
                                                                        null
                                                                    ? Container(
                                                              width: 110,
                                                              height: 110, 
                                                              //margin: EdgeInsets.only(left: 15),
                                                              decoration:
                                                                  new BoxDecoration(
                                                                      shape: BoxShape.circle,

                                                                      image:
                                                                          new DecorationImage(
                                                                fit:
                                                                    BoxFit.fill,
                                                                image: 
                                                                // addedItem[index]
                                                                //             .item
                                                                //             .img ==
                                                                //         null
                                                                 //   ?
                                                                     new AssetImage(
                                                                        "assets/img/medicine_icon.PNG")
                                                                    // : NetworkImage("https://www.dynamyk.biz" +
                                                                    //     addedItem[index]
                                                                    //         .item
                                                                    //         .img),
                                                                // NetworkImage('http://10.0.2.2:3333'+addedItem[index].item.img)
                                                              ))):
                                                               Container(
                                                                 margin: EdgeInsets.all(5),
                                                              width: 90,
                                                              height: 90, 
                                                              //margin: EdgeInsets.only(left: 15),
                                                              decoration:
                                                                  new BoxDecoration(
                                                                      shape: BoxShape.circle,

                                                                      image:
                                                                          new DecorationImage(
                                                                fit:
                                                                    BoxFit.fill,
                                                                image:
                                                                //  addedItem[index]
                                                                //             .item
                                                                //             .img ==
                                                                //         null
                                                                //     ? new AssetImage(
                                                                //         "assets/img/medicine_icon.PNG")
                                                                    //: 
                                                                    NetworkImage("https://www.dynamyk.biz" +
                                                                        addedItem[index]
                                                                            .item
                                                                            .img),
                                                                // NetworkImage('http://10.0.2.2:3333'+addedItem[index].item.img)
                                                              ))),
                                                          Container(
                                                            // color: Colors.red,
                                                            // width: 100,
                                                            alignment: Alignment
                                                                .center,
                                                            // margin: EdgeInsets.only(top: 2, bottom: 2),
                                                            // padding: EdgeInsets.only(left: 8),
                                                            child: Text.rich(
                                                              TextSpan(
                                                                  children: <
                                                                      TextSpan>[
                                                                    TextSpan(
                                                                      text: //"4",
                                                                          "\$ ${(addedItem[index].item.price).toStringAsFixed(2)}", //"\$${store.state.cart.item.price}",
                                                                      style: TextStyle(
                                                                          color: Color(
                                                                              0xFF00bb5d),
                                                                          fontFamily:
                                                                              "sourcesanspro",
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    // TextSpan(
                                                                    //   text: ".55",
                                                                    //   style: TextStyle(
                                                                    // color: Color(0xFF01D56A),
                                                                    // fontFamily: "sourcesanspro",
                                                                    // fontSize: 12,
                                                                    // fontWeight: FontWeight.w400
                                                                    //       ),
                                                                    // ),
                                                                  ]),
                                                            ),
                                                          ),
                                                          Container(
                                                            // color: Colors.blue,
                                                            //   width: 100,
                                                            //  height: 15,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 3,
                                                                    bottom: 5),
                                                            child: Text(
                                                              //"sefraf",
                                                              addedItem[index]
                                                                  .item
                                                                  .name,
                                                              //widget.data.item.name,
                                                              //  widget.data['item']['name'],

                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFF202020),
                                                                  fontFamily:
                                                                      "sourcesanspro",
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                          // Container(
                                                          //   width: 100,
                                                          //   //  height: 10,
                                                          //   margin: EdgeInsets.only(top: 3),
                                                          //   child: Text(
                                                          //     "900v",
                                                          //     overflow: TextOverflow.ellipsis,
                                                          //     textAlign: TextAlign.center,
                                                          //     style: TextStyle(
                                                          //         color: Color(0xFF000000),
                                                          //         fontFamily: "sourcesanspro",
                                                          //         fontSize: 13,
                                                          //         fontWeight: FontWeight.w400),
                                                          //   ),
                                                          // ),
                                                          Container(
                                                            // color: Colors.red,
                                                            // margin: EdgeInsets.only(top: 1),
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 5,
                                                                    right: 5,
                                                                    top: 5),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: <
                                                                  Widget>[
                                                                ///////////// Dicrement Button////////
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    _changeItemQuantiy(
                                                                        addedItem[
                                                                            index],
                                                                        -1);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border:
                                                                          Border(
                                                                        top: BorderSide(
                                                                            width:
                                                                                1,
                                                                            color:
                                                                                Color(0xFF9b9b9b)),
                                                                        left:
                                                                            BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Color(0xFF9b9b9b),
                                                                        ),
                                                                        right:
                                                                            BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Color(0xFF9b9b9b),
                                                                        ),
                                                                        bottom:
                                                                            BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Color(0xFF9b9b9b),
                                                                        ),
                                                                      ),
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    child: Icon(
                                                                      Icons
                                                                          .remove,
                                                                      size: 18,
                                                                    ),
                                                                  ),
                                                                ),

                                                                //////////// Dicrement Button end////////

                                                                ///////////Quantity start /////////
                                                                Container(
                                                                  //width: 100,
                                                                  //  height: 10,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              3),
                                                                  child: Text(
                                                                    "${addedItem[index].quantity}",
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0xFF000000),
                                                                        fontFamily:
                                                                            "sourcesanspro",
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                                ///////////Quantity end /////////

                                                                //////////// Increment Button////////
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    _changeItemQuantiy(
                                                                        addedItem[
                                                                            index],
                                                                        1);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border:
                                                                          Border(
                                                                        top: BorderSide(
                                                                            width:
                                                                                1,
                                                                            color:
                                                                                Color(0xFF9b9b9b)),
                                                                        left:
                                                                            BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Color(0xFF9b9b9b),
                                                                        ),
                                                                        right:
                                                                            BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Color(0xFF9b9b9b),
                                                                        ),
                                                                        bottom:
                                                                            BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Color(0xFF9b9b9b),
                                                                        ),
                                                                      ),
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    child: Icon(
                                                                      Icons.add,
                                                                      size: 18,
                                                                    ),
                                                                  ),
                                                                )

                                                                //////////// Increment Button end////////
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),

                                                    //////////////////Positioned //////////////////
                                                    Positioned(
                                                      right: 1,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          _deleteCart(
                                                              addedItem[index]
                                                                  .id);
                                                        },
                                                        child: Container(
                                                          // margin: EdgeInsets.only(left: 85),
                                                          child: Icon(
                                                              Icons.cancel),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                        }),
                                      )
                            // new FutureBuilder<List<CurtData>>(
                            //   future: fetchCountry(new http.Client()),
                            //   builder: (context, snapshot) {
                            //     if (snapshot.hasError) print(snapshot.error);
                            //     return snapshot.hasData
                            //         ?
                            //         : new Center(
                            //             child: new CircularProgressIndicator());
                            //   },
                            // ),
                            ),
                      ),
                    ),
                    /////////// Add Grid //////////

                    // ////////////////  Recommended Items /////////
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   margin: EdgeInsets.only(top: 20, left: 20, bottom: 5),
                    //   child: Text(
                    //     "Recommended Items",
                    //     textAlign: TextAlign.left,
                    //     style: TextStyle(
                    //         color: Color(0xFF000000),
                    //         fontFamily: "MyriadPro",
                    //         fontSize: 20,
                    //         fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                    // Container(
                    //   child: Row(
                    //     children: <Widget>[
                    //       Container(
                    //         width: 20,
                    //         height: 70,
                    //         decoration: BoxDecoration(
                    //           color: Color(0xFF00CE7C),
                    //           borderRadius: BorderRadius.only(
                    //               topRight: Radius.circular(15),
                    //               bottomRight: Radius.circular(50)),
                    //         ),
                    //         child: Icon(
                    //           Icons.keyboard_arrow_left,
                    //           size: 25,
                    //           color: Color(0xFFFFFFFF),
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: Container(
                    //           color: Color(0xFFFFFFFF),
                    //           height: 170,
                    //           padding: EdgeInsets.only(left: 8, right: 8),
                    //           child: ListView(
                    //             physics: BouncingScrollPhysics(),
                    //             scrollDirection: Axis.horizontal,
                    //             children: _recomendedItems(),
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         width: 20,
                    //         height: 70,
                    //         decoration: BoxDecoration(
                    //           color: Color(0xFF00CE7C),
                    //           borderRadius: BorderRadius.only(
                    //             topLeft: Radius.circular(15),
                    //             bottomLeft: Radius.circular(50),
                    //           ),
                    //         ),
                    //         child: Icon(
                    //           Icons.keyboard_arrow_right,
                    //           size: 25,
                    //           color: Color(0xFFFFFFFF),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    ////////////////Butoon Start//////////////////////

                    Container(
                      //color: Colors.blue,
                      margin: EdgeInsets.only(top: 15, bottom: 20),
                      padding: EdgeInsets.only(left: 30, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          /////////////// "back" button start///////////////
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              //margin: EdgeInsets.only(left: 20,top: 10),
                              child: Text(
                                "Back",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontFamily: "standard-regular",
                                    // decoration: TextDecoration.underline,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),

                          /////////////// "back" button end///////////////

                          ///////////////// next Button start///////////////
                          Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: addedItem == null
                                    ? Colors.grey
                                    : addedItem.length < 1
                                        ? Colors.grey
                                        : Color(0xFF00CE7C),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                              //width: 180,
                              height: 42,
                              padding: EdgeInsets.only(left: 25, right: 25),
                              // margin: EdgeInsets.only(right: 20),
                              child: FlatButton(
                                onPressed: addedItem == null
                                    ? null
                                    : addedItem.length < 1 ? null : _cartNext,
                                child: Text(
                                  addedItem == null
                                      ? 'No item'
                                      : addedItem.length < 1
                                          ? 'No item'
                                          : 'Next',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "grapheinpro-black",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              )),

                          ///////////////// Next button end///////////////
                        ],
                      ),
                    )
                  ],
                ),
              )
              ;
              }
              )
            ),
    );
  }

  List<Widget> _recomendedItems() {
    List<Widget> list = [];
    // var index = 0;
    for (var d in recommendeditems) {
      list.add(RecomendedCard(d));
    }

    return list;
  }

  void _cartNext() async {
    bool _isSameShop = false;

    for (var d in store.state.cartList) {
      if (d.item.growId != store.state.cartList[0].item.growId) {
        _showDialog("Product should be ordered from same shop");
        setState(() {
          _isSameShop = true;
        });
        break;
      }
    }

    if (_isSameShop == false) {
      Navigator.push(context, SlideLeftRoute(page: CheckoutPage(addedItem)));
    }

    // print("delifee cart");
    //   print(delifee);
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
              },
            ),
          ],
        );
      },
    );
  }
///////////

  _changeItemQuantiy(d, qt) {
    //  FAKE UPDATE QUANTITY
    if (d.quantity == 1 && qt < 0) return;
    setState(() {
      d.quantity += qt;
    });

    // UPDATE QUANTITY
    var data = {'id': d.id, 'quantity': d.quantity};
    CallApi().postData(data, '/app/update-quanitity');
  }

  void _deleteCart(int id) {
    store.dispatch(UpdateCart(-1));
    // FAKE DELETE FROM THE DART OBJECT LIST...
    var i = 0;
    for (var d in addedItem) {
      if (d.id == id) {
        break;
      }
      i++;
    }
    addedItem.removeAt(i);
    setState(() {
      addedItem = addedItem;
    });
    // PROCESS THE ACTUAL DELETE...
    var data = {'id': '${id}'};
    CallApi().postData(data, '/app/curtsdelete');
    print('deleted');
  }
}
