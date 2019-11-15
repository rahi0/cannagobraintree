
import 'dart:convert';

import 'package:canna_go_dev/api/api.dart';
import 'package:canna_go_dev/jsonModal/shopItemsModal/shopItemsModal.dart';
import 'package:canna_go_dev/redux/action.dart';
import 'package:flutter/material.dart';
import 'package:canna_go_dev/main.dart';

class ShopPageTopBar extends StatefulWidget {
  final shop;
  ShopPageTopBar(this.shop);
  @override
  _ShopPageTopBarState createState() => _ShopPageTopBarState();
}


const kExpandedHeight = 180.0;

class _ShopPageTopBarState extends State<ShopPageTopBar> {

    TextEditingController searchController  = TextEditingController();
  ScrollController _scrollController;
  bool _searchClick = false;
bool _hideSearch = false;
bool _itemListEmpty = false;

    @override
  void initState() {

    _searchClick = false;
    _hideSearch = false;
    super.initState();

    _scrollController = ScrollController()
      ..addListener(() => setState(() {}));
  }

  bool get _showTitle {
    return _scrollController.hasClients
        && _scrollController.offset > kExpandedHeight - kToolbarHeight;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: SliverAppBar(
        iconTheme: IconThemeData(
            color: Color(0xFF01D56A)
          ),
        automaticallyImplyLeading: false,
        leading:  Container(
               alignment: Alignment.topLeft,
                 margin: EdgeInsets.only(top: 15),
               child: IconButton(
               onPressed: (){
                Navigator.of(context).pop();
                   
               },
               icon: Icon(Icons.arrow_back),
                  ),
             ),
        backgroundColor: Colors.white,
        expandedHeight: 180.0,
        //floating: false,
        pinned: true,
          actions: <Widget>[

            


                   _searchClick?
            Expanded(
                   child: Container(
                     margin: EdgeInsets.only(left: 40, top: 15, right: 30),
                  //   height: 20.0,
                     //width: MediaQuery.of(context).size.width,

                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(50.0),
                         border: Border.all(
                           color: Colors.white
                         ),
                         color: Colors.transparent),
                     child: TextField(
                       controller: searchController,
                       cursorColor: Colors.white,
                       style:  TextStyle(color: Colors.white),
                       decoration: InputDecoration(
                          
                           hintText: 'Search',
                           hintStyle: TextStyle(color: Colors.white),
                           border: InputBorder.none,
                           contentPadding:
                               EdgeInsets.only(left: 15.0,top:10),
                           suffixIcon: IconButton(
                               onPressed: () {
                                   _searchItem();

                               },
                               icon: Icon(Icons.search),
                              color: Color(0xFF01D56A)
                               //onPressed: searchLocation,
                              // iconSize: 30.0
                              )
                               ),
                       onChanged: (val) {
                         setState(() {
                           //searchAddr = val;
                         });
                       },
                     ),
                   ),
                 ): Container(), 
              Container(
                 margin: EdgeInsets.only(top: 15),
                child: !_hideSearch?  IconButton(
             onPressed: (){
                 setState(() {
                     _searchClick = true;
                     _hideSearch = true;

                 });
                   
             },
             icon: Icon(Icons.search),
                  ):Container(),
              )
          ],
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
                    image: AssetImage('assets/img/shopbc.png'),
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.5), BlendMode.darken),
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
                                   widget.shop.name==null?"":"${widget.shop.name}",
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
                      //////// Shop Name end/////////
                      

                      ///////// Open Close start //////////
                      // Container(
                      //   margin: EdgeInsets.only(top: 5, bottom: 5),
                      //   padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(5),
                      //     border: Border.all(
                      //       color: Colors.white
                      //     )
                      //   ),
                      //   child: Text(
                      //                'Closed',
                      //                //overflow: TextOverflow.ellipsis,
                      //               textDirection: TextDirection.ltr,
                      //               style: TextStyle(
                      //                 color: Colors.white,
                      //                 fontSize: 17.0,
                      //                 decoration: TextDecoration.none,
                      //                 fontFamily: 'sourcesanspro',
                      //                 fontWeight: FontWeight.normal,
                      //               ),
                      //             ),
                      // ),
                      //////// Open Close  end/////////
                      

                      ///////// rating start //////////
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.star,size: 15, color:Color(0xFF01D56A),),

                            Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                        child: Text(
                                    widget.shop.avgRating !=null ? '${widget.shop.avgRating.averageRating}' : '0',
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
    );
  }

  void _searchItem() async {
 
            // store.dispatch(FilterItemsList([]));
            // store.dispatch(CheckFilter(true));
  store.dispatch(SearchItemsList([]));

  if(searchController.text.isEmpty){
    return _showErrorDialog("Search Field must not be empty");
  }

   store.dispatch(LoadingSearch(true));

   setState(() {
      // _isLoading = true;
       _itemListEmpty = false; 
    });
   
   var urlSearch = '/app/itemsAllSearch?itemName=${searchController.text}'; 
  // var urlSearch = '/app/cannagrowAllSearch';
    var res = await CallApi().getData(urlSearch);
    var collection = json.decode(res.body);

  var filteritem = ShopItems.fromJson(collection);


    store.dispatch(SearchItemsList(filteritem.allItems));
      store.dispatch(CheckSearch(true));
     



    if(filteritem.allItems == null || filteritem.allItems.length==0){
      setState(() {
       _itemListEmpty = true; 
      });
    }
 
    // print("top");
    //  print(filteritem.allItems);
    //   print(store.state.isSearch);
    // print(store.state.filterItemsList.length);

   // setState(() {
      // _isLoading = false;
   // });

   // searchController.text="";
    store.dispatch(LoadingSearch(false));
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