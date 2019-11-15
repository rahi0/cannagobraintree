import 'dart:convert';

import 'package:canna_go_dev/api/api.dart';
import 'package:canna_go_dev/customPlugin/routeTransition/routeAnimation.dart';
import 'package:canna_go_dev/jsonModal/shopItemsModal/shopItemsModal.dart';
import 'package:canna_go_dev/main.dart';
import 'package:canna_go_dev/redux/action.dart';
import 'package:canna_go_dev/screen/itemPage/itemPage.dart';
// import 'package:canna_grow_final/JsonModel/ShowProduct/ShowProductJson.dart';
// import 'package:canna_grow_final/api/api.dart';
// import 'package:canna_grow_final/screen/ItemPage/ItemPage.dart';
// import 'package:canna_grow_final/screen/ProductsGrid/ProductGrid.dart';
import 'package:flutter/material.dart';




class ShopItemsPage extends StatefulWidget {
  final shop;
  ShopItemsPage(this.shop);
  @override
  _ShopItemsPageState createState() => _ShopItemsPageState();
}

class _ShopItemsPageState extends State<ShopItemsPage> {
  bool _isLoading = true;
  bool _isDataFound = false;
  var sellerProductItems;
  var shopId=0;
  @override
  void initState() {
    //  print("delifeeshopItems");
  // setState(() {
    //  store.state.isFilter? delifee = widget.shop.store.deliveryFee:
      delifee = widget.shop.deliveryFee; 
  // });
   //   print(delifee);
    _showProducts();
    super.initState();
  }

  void _showProducts() async {
    store.dispatch(AllProductItems([]));
   // print(widget.shop.id);
    var res = await CallApi().getData('/app/allShopItems/${widget.shop.id}');
   // var res = store.state.isFilter?await CallApi().getData('/app/allShopItems/${widget.shop.store.id}'):await CallApi().getData('/app/allShopItems/${widget.shop.id}');
    var collection = json.decode(res.body);
    var productItems = ShopItems.fromJson(collection);
   // print(productItems.allItems); 
    store.dispatch(AllProductItems(productItems.allItems));

    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });

     //print("delifee");
  
  // 
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    //24 is for notification bar on Android/
    final double itemHeight = (size.height - kToolbarHeight - 6) / 2.4;
    final double itemWidth = size.width / 2;

    return store.state.items.length < 1 ? 
                       Container(
                            //color: Colors.black,
                            child: Center(
                              child: Text('There is no products availble for this store',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                              ),
                            ), 
                          )
                       :Center(
          child: store.state.isLoadingSearch || _isLoading 
              ? CircularProgressIndicator()
              : CustomScrollView( 
                  primary: true,
                  slivers: <Widget>[
                    SliverPadding(
                      padding: const EdgeInsets.all(20.0),
                      sliver: SliverGrid.count(
                          crossAxisSpacing: 10.0,
                          childAspectRatio: (itemWidth / itemHeight),
                          crossAxisCount: 2,
                          children: _showLists()),
                    ),
                  ],
                ),
        

        //       child: Column(
        //   children: _showLists()

        // ),

        );
  }

  List<Widget> _showLists() {
    List<Widget> list = [];
     

     for(var sp in store.state.cartList){

      
       setState(() {
          shopId = sp.item.growId;
       });
      
     }
//store.state.isSearch?  store.dispatch(LoadingSearch(false)):  store.dispatch(LoadingSearch(false));
    // var index = 0;
    for (var d in store.state.isSearch?store.state.searchItemList:store.state.items) { 
     

    //  print(store.state.isSearch);
    //  print(store.state.searchItemList);
      list.add(GestureDetector(
        onTap: () {

        
        if(shopId==0 || widget.shop.id == shopId){
                Navigator.push(context, SlideLeftRoute(page: ItemPage(d)));
        }
        else{

          print(shopId);
          print(widget.shop.id);
              _showErrorDialog("Product should be ordered from same shop");
        }
         
        },
        child: Container(
          //height: 145,
          //width: 45,
          margin: EdgeInsets.only(bottom: 10),
          child: Card(
            //color: Colors.red,
            elevation: 3,
            // margin: EdgeInsets.only( top: 8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ///////Price//////
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                  //color: Colors.blue,
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          '\$${(d.price).toStringAsFixed(2)}',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            color: Color(0xFF01D56A),
                            fontSize: 19.0,
                            decoration: TextDecoration.none,
                            fontFamily: 'MyriadPro',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ///////Price end//////

                ///////Pic And Name//////

                Container(
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.yellow,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 3),
                        child: Image.asset(
                          'assets/img/med.jpg',
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(
                            top: 2, bottom: 1, left: 5, right: 5),
                        alignment: Alignment.center,
                        child: Text(
                          d.name,
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 19.0,
                            decoration: TextDecoration.none,
                            fontFamily: 'MyriadPro',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        //color: Colors.red,
                        child: Text(
                          d.description,
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            decoration: TextDecoration.none,
                            fontFamily: 'MyriadPro',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                ///////Pic And Name end//////

                ///////Review//////
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.only(top: 3, bottom: 3, right: 0, left: 0),
                  child: ///////// rating start //////////
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.star,size: 15, color:Colors.yellowAccent[700],),

                          Container(
                            margin: EdgeInsets.only(left: 3, right: 3),
                      child: Text(
                                   d.avgRating !=null ? '${d.avgRating.averageRating}' : '0',
                                   //overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'sourcesanspro',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                      ),



                      Container(
                      child: Text(
                                   '(${d.totalrev.total})',
                                   //overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'sourcesanspro',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                      ),
                        ],
                      ),
                      //////// rating end/////////////
                ),
                ///////Review end//////
              ],
            ),
          ),
        ),
      ));
    }

    return list;
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
