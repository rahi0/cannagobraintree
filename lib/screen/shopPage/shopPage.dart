import 'package:canna_go_dev/screen/shopItemsPage/shopItemsPage.dart';
import 'package:canna_go_dev/widget/shopPageWidget/shopPageTobBar.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:canna_go_dev/api/api.dart';
import 'package:canna_go_dev/customPlugin/routeTransition/routeAnimation.dart';
import 'package:canna_go_dev/jsonModal/shopItemsModal/shopItemsModal.dart';
import 'package:canna_go_dev/main.dart';
import 'package:canna_go_dev/redux/action.dart';
import 'package:canna_go_dev/screen/itemPage/itemPage.dart';
import 'package:flutter/services.dart';

class ShopPage extends StatefulWidget {
  final shop;
  ShopPage(this.shop);
  @override
  _ShopPageState createState() => _ShopPageState();
}

const kExpandedHeight = 180.0;

class _ShopPageState extends State<ShopPage> {
  bool _isLoading = true;
  bool _isDataFound = false;
  var sellerProductItems;
  var shopId = 0;
  bool _text = false;
  TextEditingController searchController = TextEditingController();
  ScrollController _scrollController;
  bool _searchClick = false;
  bool _hideSearch = false;
  bool _itemListEmpty = false;

  @override
  void initState() {
    _searchClick = false;
    _hideSearch = false;

    //  _scrollController = ScrollController()
    // ..addListener(() => setState(() {}));
    delifee = widget.shop.deliveryFee;
    // });
    //   print(delifee);
    _showProducts();
    super.initState();
  }

  Future <void> _showProducts() async {
    store.dispatch(AllProductItems([]));
    // print(widget.shop.name);
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
      // SystemChrome.setPreferredOrientations([
      //   DeviceOrientation.portraitUp,
      //   DeviceOrientation.portraitDown,
      // ]);
    var size = MediaQuery.of(context).size;

    //24 is for notification bar on Android/
    final double itemHeight = (size.height - kToolbarHeight - 6) / 1.8;
    final double itemWidth = size.width / 2;

    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: RefreshIndicator(
          onRefresh: _showProducts,
                  child: Container(
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    iconTheme: IconThemeData(color: Color(0xFF01D56A)),
                    automaticallyImplyLeading: false,
                    // leading:
                    backgroundColor: Color(0xFFFFFFFF),
                    expandedHeight: 180.0,
                    //floating: false,
                    pinned: true,

                    title: Container(
                      //color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: 0, bottom: 8, top: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white.withOpacity(0.2),
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(Icons.arrow_back_ios),
                            ),
                          ),
                          _searchClick
                              ? Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 7, right: 0, top: 8,bottom: 10),
                                    padding: EdgeInsets.only(bottom: 5),
                                    //width: MediaQuery.of(context).size.width,

                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        border: Border.all(
                                          color: Color(0xFF01D56A),
                                        ),
                                        color: Colors.white.withOpacity(0.7)),
                                    child: TextField(
                                      autofocus: true,
                                      controller: searchController,
                                      textInputAction: TextInputAction.search,
                                      cursorColor: Colors.black,
                                      style: TextStyle(color: Colors.black),
                                      decoration: InputDecoration(
                                        
                                        hintText: 'Search',
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: 15.0, top: 8,),
                                            suffixIcon: _text?IconButton(
                                       onPressed: () {
                                         searchController.text="";
                                         
                                           setState(() {

                                            _text = false; 

                                           }); 
                                          //  store.dispatch(CheckFilter(false));
                                            //  _displayShops();
                                             store.dispatch(CheckSearch(false));
                                             _showLists();

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
                                   _searchItem();
                                  _text = true;
                                  //searchAddr = val;
                                    });
                                       },
                                      // onSubmitted: (term) {
                                      //   _searchItem();
                                      //   searchController.text = "";
                                      // },
                                    ),
                                  ),
                                )
                              : Container(),
                          Container(
                            // alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(right: 0, bottom: 8, top: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white.withOpacity(0.2),
                            ),
                            //   margin: EdgeInsets.only(top: 6),
                            child: !_hideSearch
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _searchClick = true;
                                        _hideSearch = true;
                                      });
                                    },
                                    icon: Icon(Icons.search),
                                  )
                                : Container(),
                          )
                        ],
                      ),
                    ),

                    // actions: <Widget>[

                    // ],
                    flexibleSpace: new FlexibleSpaceBar(

                        ////////////////////Collapsed Bar/////////////////
                        background: Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            //constraints: new BoxConstraints.expand(height: 256.0, ),
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                // image: widget.shop.user.img==null?  new AssetImage('assets/img/ph.jpg'): NetworkImage("https://dynamyk.co"+widget.shop.user.img),
                                image: new AssetImage('assets/img/shopItem.jpg'),
                                colorFilter: new ColorFilter.mode(
                                    Colors.black.withOpacity(0.5),
                                    BlendMode.darken),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            child: Container(
                              //color: Colors.red,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  ///////// Shop Name //////////
                                  Container(
                                    //color: Colors.red,
                                    padding: EdgeInsets.only(top: 40),
                                    width: 200,
                                    alignment: Alignment.center,
                                    child: Text(
                                      widget.shop.name == null
                                          ? ""
                                          : "${widget.shop.name}",
                                      //  store.state.isFilter?widget.shop.store.name==null?"":"${widget.shop.store.name}"
                                      //  :widget.shop.name==null?"":"${widget.shop.name}",
                                      //overflow: TextOverflow.ellipsis,

                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25.0,
                                        decoration: TextDecoration.none,
                                        fontFamily: 'sourcesanspro',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                

                                  ///////// rating start //////////
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.star,
                                          size: 15,
                                          color: Color(0xFFffa900),
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.only(left: 3, right: 3),
                                          child: Text(
                                            widget.shop.avgRating != null
                                                ? '${widget.shop.avgRating.averageRating}'
                                                : '0',
                                            //overflow: TextOverflow.ellipsis,
                                            textDirection: TextDirection.ltr,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              decoration: TextDecoration.none,
                                              fontFamily: 'sourcesanspro',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            '(${widget.shop.totalrev.total})',
                                            //overflow: TextOverflow.ellipsis,
                                            textDirection: TextDirection.ltr,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0,
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
                          )
                        ],
                      ),
                    )

                        ////////////////////Collapsed Bar  End/////////////////

                        ),
                  ),
                  // ShopPageTopBar(widget.shop)
                ];
              },
              body: //ShopItemsPage(widget.shop),

                  Center(
                child: _isLoading
                    ? CircularProgressIndicator(
                        backgroundColor: Colors.green,
                      )
                    : store.state.isSearch &&
                            store.state.searchItemList.length < 1
                        ? Container(
                            color: Color(0xFFFFFFFF),
                            //color: Colors.black,
                            child: Center(
                              child: Text(
                                'No item matches',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        : store.state.items.length < 1
                            ? Container(
                                color: Color(0xFFFFFFFF),
                                child: Center(
                                  child: Text(
                                    'There is no product availble for this store',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            : 
                                 CustomScrollView(
                                    primary: true,
                                    slivers: <Widget>[
                                      SliverPadding(
                                        padding: const EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            top: 10,
                                            bottom: 10),
                                        sliver: SliverGrid.count(
                                            crossAxisSpacing: 8.0,
                                            mainAxisSpacing: 8,
                                            childAspectRatio:
                                                (MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        2) /
                                                    (MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        2.3),

                                            /// (itemWidth / itemHeight),
                                            crossAxisCount: 2,
                                            children:
                                            MediaQuery.of(context).orientation== 
                                                    Orientation.portrait
                                                ?
                                             _showLists()
                                                :
                                               _showLandScapeList()),
                                      ),
                                    ]),
                             // }
                           //  ),

                //       child: Column(
                //   children: _showLists()

                // ),
              ),
            ),
          ),
        ));
  }

  List<Widget> _showLists() {
    List<Widget> list = [];

    for (var sp in store.state.cartList) {
      shopId = sp.item.growId;
    }
    for (var d in store.state.isSearch
        ? store.state.searchItemList
        : store.state.items) {
      list.add(GestureDetector(
        onTap: () {
          if (shopId == 0 || widget.shop.id == shopId) {
            Navigator.push(context, SlideLeftRoute(page: ItemPage(d)));
          } else {
            print(shopId);
            print(widget.shop.id);
            _showErrorDialog("Product should be ordered from same shop");
          }
        },
        child: Container(
          //height: 145,
          //width: 45,
          //  margin: EdgeInsets.only(bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              // color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              // color: Colors.red,

              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300],
                  blurRadius: 17,
                  //offset: Offset(0.0,3.0)
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ///////Pic And Name//////

                Container(
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.yellow,
                  child: Column(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(bottom: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5)),
                          child: d.img == null
                              ? ClipOval(
                                  child: Image.asset(
                                  'assets/img/medicine_icon.PNG',
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ))
                              : Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: ClipOval(
                                    child: Image.network(
                                      "https://www.dynamyk.biz" + d.img,
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )),

                      ///////Price//////
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        // padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        //color: Colors.blue,
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            '\$${(d.price).toStringAsFixed(2)}',
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              color: Color(0xFF00bb5d),
                              fontSize: 20.0,
                              decoration: TextDecoration.none,
                              fontFamily: 'MyriadPro',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      ///////Price end//////
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(
                            left: 10, top: 2, bottom: 1, right: 10),
                        alignment: Alignment.center,
                        child: Text(
                          d.name,
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            color: Color(0xFF202020),
                            fontSize: 18.0,
                            decoration: TextDecoration.none,
                            fontFamily: 'MyriadPro',
                            fontWeight: FontWeight.bold,
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
                            color: Color(0xFF707070),
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
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.only(top: 0, bottom: 10, right: 0, left: 0),
                  child: ///////// rating start //////////
                      Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        size: 15,
                        color: Color(0xFFffa900),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 3, right: 3),
                        child: Text(
                          d.avgRating != null
                              ? '${d.avgRating.averageRating}'
                              : '0',
                          //overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            color: Color(0xFF343434),
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
                            color: Color(0xFF343434),
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

  List<Widget> _showLandScapeList() {
    List<Widget> list = [];

    for (var sp in store.state.cartList) {
      shopId = sp.item.growId;
    }

    for (var d in  store.state.items) {
      list.add(GestureDetector(
        onTap: () {
          if (shopId == 0 || widget.shop.id == shopId) {
            Navigator.push(context, SlideLeftRoute(page: ItemPage(d)));
          } else {
            print(shopId);
            print(widget.shop.id);
            _showErrorDialog("Product should be ordered from same shop");
          }
        },
        child: Container(
          decoration: BoxDecoration(
            // color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            // color: Colors.red,

            boxShadow: [
              BoxShadow(
                color: Colors.grey[300],
                blurRadius: 17,
                //offset: Offset(0.0,3.0)
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ///////Pic And Name//////

              Container(
                width: MediaQuery.of(context).size.width / 2,
                // color: Colors.yellow,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        // margin: EdgeInsets.only(bottom: 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)),
                        child: d.img == null
                            ? ClipOval(
                                child: Image.asset(
                                'assets/img/medicine_icon.PNG',
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              ))
                            : Container(
                                margin: EdgeInsets.only(top: 20),
                                child: ClipOval(
                                  child: Image.network(
                                    "https://www.dynamyk.biz" + d.img,
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )),

                    ///////Price//////
                    Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            '\$${(d.price).toStringAsFixed(2)}',
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              color: Color(0xFF00bb5d),
                              fontSize: 20.0,
                              decoration: TextDecoration.none,
                              fontFamily: 'MyriadPro',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          
                           width: MediaQuery.of(context).size.width/5,
                          padding: EdgeInsets.only(top: 2, bottom: 1,left: 10),
                          alignment: Alignment.center,
                          child: Text(
                          d.name,
                            overflow: TextOverflow.ellipsis,
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              color: Color(0xFF202020),
                              fontSize: 18.0,
                              decoration: TextDecoration.none,
                              fontFamily: 'MyriadPro',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                
                        Container(
                           alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15))),
                          // width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(
                              top: 0, bottom: 0, right: 0, left: 0),
                          child: ///////// rating start //////////
                              Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                size: 15,
                                color: Color(0xFFffa900),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 3, right: 3),
                                child: Text(
                                  d.avgRating != null
                                      ? '${d.avgRating.averageRating}'
                                      : '0',
                                  //overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    color: Color(0xFF343434),
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
                                    color: Color(0xFF343434),
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
                      ],
                    ),
                    ///////Price end//////
                  ],
                ),
              ),

              ///////Pic And Name end//////

              ///////Review//////

              ///////Review end//////
            ],
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

  void _searchItem() async {
    //  print(widget.shop.growId);

    // store.dispatch(FilterItemsList([]));
    // store.dispatch(CheckFilter(true));

    // if (searchController.text.isEmpty) {
    //   return _showErrorDialog("Search field is empty");
    // } 
   // else {
      store.dispatch(SearchItemsList([]));
   // }

    // store.dispatch(LoadingSearch(true));

    setState(() {
      _isLoading = true;
      _itemListEmpty = false;
    });

    var urlSearch =
        '/app/itemSearchByStore/${widget.shop.id}?keyword=${searchController.text}';
    // var urlSearch = '/app/cannagrowAllSearch';
    var res = await CallApi().getData(urlSearch);
    var collection = json.decode(res.body);

    var filteritem = ShopItems.fromJson(collection);

    store.dispatch(SearchItemsList(filteritem.allItems));
    store.dispatch(CheckSearch(true));

    if (filteritem.allItems == null || filteritem.allItems.length == 0) {
      if (!mounted) return;
      setState(() {
        _itemListEmpty = true;
      });
    }
if (!mounted) return;
    setState(() {
      _isLoading = false;
    });

   // searchController.text = "";
    store.dispatch(LoadingSearch(false));
  }
}
