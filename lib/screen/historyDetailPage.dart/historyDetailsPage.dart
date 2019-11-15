
import 'dart:convert';

import 'package:canna_go_dev/api/api.dart';
import 'package:canna_go_dev/customPlugin/routeTransition/routeAnimation.dart';
import 'package:canna_go_dev/jsonModal/GetDriverReview/GetDriverReview.dart';
import 'package:canna_go_dev/jsonModal/GetItemReview/GetItemReview.dart';
import 'package:canna_go_dev/jsonModal/ordersModal/ordersModal.dart';
import 'package:canna_go_dev/screen/reviewDriverPage/reviewDriver.dart';
import 'package:canna_go_dev/screen/reviewPage/reviewPage.dart';
import 'package:canna_go_dev/screen/shopItemsPage/shopItemsPage.dart';
import 'package:canna_go_dev/widget/shopPageWidget/shopPageTobBar.dart';
import 'package:flutter/material.dart';


class HistoryDetailsPage extends StatefulWidget {
  final orderedItem;
  HistoryDetailsPage(this.orderedItem); 
  @override
  _HistoryDetailsPageState createState() => _HistoryDetailsPageState();
}

class _HistoryDetailsPageState extends State<HistoryDetailsPage> {

var driverReview;
bool _isLoading=true;
@override
  void initState() {
    
    _checkDriverReview();
   
    super.initState();
   
  }

void _checkDriverReview() async{


   var res = await CallApi().getData('/app/order/getDriverReview/${widget.orderedItem.id}?driverId=${widget.orderedItem.driverId}');
    var collection = json.decode(res.body);
    // print("driver");
    // print(collection);
    var orderItems = GetDriverReview.fromJson(collection);

   

    setState(() {
       driverReview  = orderItems.isDriverReviewGiven;
      _isLoading = false;
    });

   // print(orderItems.isReviewCreated);
}





  Widget build(BuildContext context) {
    
    return SafeArea(
      top: false,
          child:  Scaffold(
        backgroundColor: Colors.white,
        body: _isLoading?Center(child: CircularProgressIndicator(
          backgroundColor: Colors.green,
        ),):
        Stack(
          children: <Widget>[
            Container(
              child: NestedScrollView( 
                                headerSliverBuilder:
                                    (BuildContext context, bool innerBoxIsScrolled) {
                                  return <Widget>[
                                      
                                       Container(
            child: SliverAppBar(
              iconTheme: IconThemeData(
                  color: Colors.white//Color(0xFF01D56A)
                ),
                automaticallyImplyLeading: false,
                leading:  GestureDetector(
                onTap:(){
            //   print("object");
              Navigator.of(context).pop();
                 
             },
                                      child: Container(
                                         margin: EdgeInsets.only(left: 8, bottom: 8,top: 8),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(6),
                      color: Colors.white.withOpacity(0.2),
                 ),
        
             child: 
                
           
            Icon(Icons.arrow_back_ios, color:Color(0xFF01d56a)),
                
           ),
                  ),
              backgroundColor: Colors.white,
              expandedHeight: 200.0,
              //floating: false,
              pinned: true,
              flexibleSpace: new FlexibleSpaceBar(
                centerTitle: false,
                title: Text(
                                           '${widget.orderedItem.seller.name}',
                                           //overflow: TextOverflow.ellipsis,
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                            color:Color(0xFF01d56a),
                                            fontSize: 19.0,
                                            decoration: TextDecoration.none,
                                            fontFamily: 'sourcesanspro',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                  ////////////////////Collapsed Bar/////////////////
                  background: Container(
                    //constraints: new BoxConstraints.expand(height: 256.0, ),
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                         image:AssetImage('assets/img/shopBanner.jpg'),
                     //   image:widget.orderedItem.seller.user.img!=null? AssetImage('assets/img/shopBanner.jpg')
                      //  :NetworkImage("https://dynamyk.co"+widget.orderedItem.seller.user.img),
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.5), BlendMode.darken),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )

                  ////////////////////Collapsed Bar  End/////////////////

                  ),
            ),
      )

                                  ];
                                },
                                body: SingleChildScrollView(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    //color: Colors.red,
                                    child: Column(
                                      children: <Widget>[
                                        ////////// Address /////////
                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                        padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                           decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:  BorderRadius.circular(8),
                                                      boxShadow:[
                           BoxShadow(color:Colors.grey[300],
                           blurRadius: 17,
                            //offset: Offset(0.0,3.0)
                            )
                         
                         ], 
                                                  ),

                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[

                                                      ///////// Status start //////////
                                          Row(
                                            children: <Widget>[
                                                  Container(
                                            margin: EdgeInsets.only(top: 5, bottom: 5),
                                            padding: EdgeInsets.fromLTRB(0, 3, 5, 3),
                                          
                                            child: Text(
                                             "Order Status: ",
                                                        // '${widget.orderedItem.status}',
                                                         //overflow: TextOverflow.ellipsis,
                                                        textDirection: TextDirection.ltr,
                                                        style: TextStyle(
                                                          color:Colors.grey[900],
                                                          fontSize: 17.0,
                                                          decoration: TextDecoration.none,
                                                          fontFamily: 'sourcesanspro',
                                                          fontWeight: FontWeight.normal,
                                                        ),
                                                      ),
                                          ),
                                              Container(
                                                 width: MediaQuery.of(context).size.width/2,
                                                margin: EdgeInsets.only(top: 5, bottom: 5),
                                                padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                                              
                                                child: Text(
                                                  widget.orderedItem.status=="driver map visible"?"Order is on the way":'${widget.orderedItem.status}',
                                                            // '${widget.orderedItem.status}',
                                                             //overflow: TextOverflow.ellipsis,
                                                            textDirection: TextDirection.ltr,
                                                            style: TextStyle(
                                                              color: widget.orderedItem.status=="Completed"?Colors.green[300]:
                                                    widget.orderedItem.status=="Cancelled"?Colors.red[300]:Color(0xFFffa900),
                                                              fontSize: 17.0,
                                                              decoration: TextDecoration.none,
                                                              fontFamily: 'sourcesanspro',
                                                              fontWeight: FontWeight.normal,
                                                            ),
                                                          ),
                                              ),
                                            ],
                                          ),
                                          //////// Status  end/////////
                                          


                                          //////// Oredr Number/////////

                                                      Row(
                                                        children: <Widget>[
                                                          Container(
                                                            child: Text(
                                                                      "Order Number: ",
                                                                      textAlign: TextAlign.left,
                                                                      style: TextStyle(
                                                                          color: Colors.grey[900],
                                                                          fontFamily:"DINPro",
                                                                          fontSize: 15,
                                                                          fontWeight: FontWeight.w500       
                                                                              ),
                                                                          ),
                                                          ),
                                                            Container(
                                                        child: Text(
                                                                  "#${widget.orderedItem.id}",
                                                                  textAlign: TextAlign.left,
                                                                  style: TextStyle(
                                                                   color:  Color(0xFF01D56A).withOpacity(0.8),
                                                                      fontFamily:"DINPro",
                                                                      fontSize: 15,
                                                                      fontWeight: FontWeight.w500       
                                                                          ),
                                                                      ),
                                                      ),
                                                        ],
                                                      ),
                                                //////// Oredr Number end /////////
                                              

                                              //////// Delivery Address/////////

                                                      // Container(
                                                      //   child: Text(
                                                      //             "Delivery Address: 215 Walnut St, Mound City, MO, 64470",
                                                      //             textAlign: TextAlign.left,
                                                      //             style: TextStyle(
                                                      //                 color: Colors.grey[600],
                                                      //                 fontFamily:"DINPro",
                                                      //                 fontSize: 15,
                                                      //                 fontWeight: FontWeight.bold       
                                                      //                     ),
                                                      //                 ),
                                                      // )
                                                ////////Delivery Address end /////////
                                                

                                                    ],
                                                  ),
                                        ),

                        ////////// Address end/////////
                        



                        ////////// Item Details /////////
                         Container(
                            margin: EdgeInsets.only(bottom: 15, left: 15, right: 15, top: 5),
                           width: MediaQuery.of(context).size.width,
                         padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                            decoration: BoxDecoration(
                                     color: Colors.white,
                                                         boxShadow:[
                           BoxShadow(color:Colors.grey[300],
                           blurRadius: 17,
                            //offset: Offset(0.0,3.0)
                            )
                         
                         ],
                                     borderRadius:  BorderRadius.circular(8),
                                     
                                   ),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: <Widget>[

                                        ////// Fee start///////
                                       
                                       Container(
                                         child: Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: <Widget>[


                                             /////Subtotal////////
                                             Container(
                                               margin: EdgeInsets.only(bottom: 5),
                                               width: MediaQuery.of(context).size.width,
                                               child: Row(
                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                 children: <Widget>[
                                                   Expanded(
                                                     child: Text(
                                                   "Subtotal",
                                                   textAlign: TextAlign.left,
                                                   style: TextStyle(
                                                       color: Colors.black,
                                                       fontFamily:"DINPro",
                                                       fontSize: 15,
                                                       fontWeight: FontWeight.normal       
                                                           ),
                                                       ),
                                                   ),


                                                    Container(
                                                      //color: Colors.red,
                                                      width: 90,
                                                      alignment: Alignment.centerRight,
                                                           margin: EdgeInsets.only(right: 10),
                                                           child: Text(
                                                         "\$${(widget.orderedItem.price).toStringAsFixed(2)}",
                                                         textAlign: TextAlign.left,
                                                         style: TextStyle(
                                                             color: Colors.black,
                                                             fontFamily:"DINPro",
                                                             fontSize: 16,
                                                             fontWeight: FontWeight.normal       
                                                                 ),
                                                             ),
                                                         ),
                                                 ],
                                               ),
                                             ),

                                             //////Subtotal end//////
                                             



                                             /////Delivery fee////////
                                             Container(
                                               margin: EdgeInsets.only(bottom: 5),
                                               width: MediaQuery.of(context).size.width,
                                               child: Row(
                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                 children: <Widget>[
                                                   Expanded(
                                                     child: Text(
                                                   "Delivery fee",
                                                   textAlign: TextAlign.left,
                                                   style: TextStyle(
                                                       color: Colors.black,
                                                       fontFamily:"DINPro",
                                                       fontSize: 15,
                                                       fontWeight: FontWeight.normal       
                                                           ),
                                                       ),
                                                   ),


                                                    Container(
                                                      //color: Colors.red,
                                                      width: 90,
                                                      alignment: Alignment.centerRight,
                                                           margin: EdgeInsets.only(right: 10),
                                                           child: Text(
                                                         "\$${(widget.orderedItem.seller.deliveryFee).toStringAsFixed(2)}",
                                                         textAlign: TextAlign.left,
                                                         style: TextStyle(
                                                             color: Colors.black,
                                                             fontFamily:"DINPro",
                                                             fontSize: 16,
                                                             fontWeight: FontWeight.normal       
                                                                 ),
                                                             ),
                                                         ),
                                                 ],
                                               ),
                                             ), 

                                             //////Delivery fee end//////
                                             
                                           ],
                                         ),
                                       ),

                                        ////// fee end//////
                                        


                                        
                                        Container(
                                          margin: EdgeInsets.only(top: 10, bottom: 10),
                                          height: 0.5,
                                          width: MediaQuery.of(context).size.width,
                                          color: Colors.grey,
                                          ),


                                       //////// total start///////
                                       
                                       Container(
                                               margin: EdgeInsets.only(bottom: 5),
                                               width: MediaQuery.of(context).size.width,
                                               child: Row(
                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                 children: <Widget>[
                                                   Expanded(
                                                     child: Text(
                                                   "Total",
                                                   textAlign: TextAlign.left,
                                                   style: TextStyle(
                                                       color: Colors.black,
                                                       fontFamily:"DINPro",
                                                       fontSize: 15,
                                                       fontWeight: FontWeight.bold       
                                                           ),
                                                       ),
                                                   ),


                                                    Container(
                                                      //color: Colors.red,
                                                      width: 90,
                                                      alignment: Alignment.centerRight,
                                                           margin: EdgeInsets.only(right: 10),
                                                           child: Text(
                                                         "\$${(widget.orderedItem.price+widget.orderedItem.seller.deliveryFee).toStringAsFixed(2)}",
                                                         textAlign: TextAlign.left,
                                                         style: TextStyle(
                                                             color: Colors.black,
                                                             fontFamily:"DINPro",
                                                             fontSize: 16,
                                                             fontWeight: FontWeight.bold       
                                                                 ),
                                                             ),
                                                         ),
                                                 ],
                                               ),
                                             ),

                                        //////// total end///////
                                       Container(
                                          margin: EdgeInsets.only(top: 10, bottom: 10),
                                          height: 0.5,
                                          width: MediaQuery.of(context).size.width,
                                          color: Colors.grey,
                                          ),
                                        


                                        //////// Title start///////
                                       
                                       Container(
                                               margin: EdgeInsets.only(bottom: 5, top: 10),
                                               width: MediaQuery.of(context).size.width,
                                               //color: Colors.red,
                                               child: Text(
                                               "Items",
                                               textAlign: TextAlign.left,
                                               style: TextStyle(
                                                 color: Colors.black,
                                                 fontFamily:"DINPro",
                                                 fontSize: 18,
                                                 fontWeight: FontWeight.bold       
                                                     ),
                                                 ),
                                             ),

                                        //////// Title end///////
                                          

                                          //////// Items start///////
                                       
                                    widget.orderedItem.orderdetails.length>0 || widget.orderedItem==null ?   Container(
                                         width: MediaQuery.of(context).size.width,
                                         child: Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: _showItems(),
                                         ),
                                       ):
                                        Container( 
                                               margin: EdgeInsets.only(bottom: 10, top: 10),
                                               width: MediaQuery.of(context).size.width,
                                               //color: Colors.red,
                                               child: Text(
                                               "Item is not available",
                                               textAlign: TextAlign.left,
                                               style: TextStyle(
                                                 color: Colors.black,
                                                 fontFamily:"DINPro", 
                                                 fontSize: 18,
                                                 fontWeight: FontWeight.normal       
                                                     ),
                                                 ),
                                             ),

                                        //////// Items end///////

                                       
                                     ],
                                   ),
                         ),

                        ////////// Item Details end/////////
                                      ],
                                    ),

                                  ),
                                ),
            ),
            ),



            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              //color: Colors.yellow,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: widget.orderedItem.status == "Completed" &&  driverReview==0? _driverReview : null,
                     child: Container(
                      color: widget.orderedItem.status == "Completed" &&  driverReview==0? Color(0xFF01D56A).withOpacity(0.8) : Colors.grey,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                                         driverReview==0? 'Review Driver':'Review has been given',
                                          
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          
                                          fontFamily: 'MyriadPro',
                                          fontWeight: FontWeight.bold,
                                          ),
                                          ),
                    ),
                  )
                ],
              ),
            )
          ],
        )
      ),
    );
  }


  _driverReview(){

    
    Navigator.push(context, SlideLeftRoute(page: ReviewDriverPage(widget.orderedItem)));
  }


  List<Widget> _showItems(){
     List<Widget> lists = []; 
     for(var d in widget.orderedItem.orderdetails){
        lists.add(
          ItemPrice(d, widget.orderedItem)
        );
     }
     return lists;
  }
}





//////



class ItemPrice extends StatefulWidget {
  final d;
  final orderedItem;
  ItemPrice(this.d, this.orderedItem);
  @override
  _ItemPriceState createState() => _ItemPriceState();
}

class _ItemPriceState extends State<ItemPrice> {

  bool  _isLoading = true;
  var itemReview;

  @override
  void initState() {
   _checkItemReview();
    super.initState();
  }

  void _checkItemReview() async{


   var res = await CallApi().getData('/app/order/getItemReview/${widget.orderedItem.id}?itemId=${widget.d.itemId}');
    var collection = json.decode(res.body);
    // print("driver");
    // print(collection);
    var orderItems = GetItemReview.fromJson(collection);

   
 if (!mounted) return;
    setState(() {
       itemReview  = orderItems.isItemReviewGiven;
      _isLoading = false;
    });

   // print(orderItems.isReviewCreated);
}
  @override
  Widget build(BuildContext context) {
    return Container(
                 decoration: BoxDecoration(
                      //color: Colors.red,
                      borderRadius:  BorderRadius.circular(15),
                        // boxShadow:[
                        //    BoxShadow(color:Colors.grey[300],
                        //    blurRadius: 6,
                        //     //offset: Offset(0.0,3.0)
                        //     )
                         
                        //  ], 
                      
                    ),
         // margin: EdgeInsets.only(bottom: 5),
            padding: EdgeInsets.only( left: 5, top: 6, ) ,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            //color: Colors.blue,
            child: Column(
              children: <Widget>[
                 Container( 
              
              margin: EdgeInsets.only(bottom: 5, left: 60),
              child: Divider(
                color: Colors.grey,
              ),
            ),
                Container(
                  //color: Colors.red,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
    Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 10.0),
      child: ClipOval(
        child:
     
        widget.d.item==null|| widget.d.item.img==null?
         Image.asset(
          'assets/img/medicine_icon.PNG',
          height: 60,
          width: 60,
          fit: BoxFit.cover,
        )
        :Image.network(
          "https://www.dynamyk.biz"+widget.d.item.img,
          height: 45,
          width: 45,
          fit: BoxFit.cover,
        ),
      ),
    ),
    Expanded(
      child: Container(
       // color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

             Container(
               margin: EdgeInsets.only(bottom: 5),
          child: Text(
                widget.d.item==null?"" :"\$${(widget.d.item.price*widget.d.quantity).toStringAsFixed(2)}",
                 textAlign: TextAlign.left,
                 style: TextStyle(
                 color: Color(0xFF00aa54).withOpacity(0.8),
                 fontFamily:"DINPro",
                 fontSize: 15,
                 fontWeight: FontWeight.bold       
                 ),
               ),
        ),
            Container(
              child: Text(
                 widget.d.item==null?"Item is not availble now":'${widget.d.item.name}',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily:"DINPro",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold       
                                        ),
              ),
            ),


            Container(
              margin: EdgeInsets.only(top: 4),
              child: 
              Text(
                  widget.d.item==null?"":  "Quantity: ${widget.d.quantity}x",
                   textAlign: TextAlign.left,
                   style: TextStyle(
                   color: Colors.teal,
                   fontFamily:"DINPro",
                   fontSize: 15,
                   fontWeight: FontWeight.normal
                   )
              )
            ),
           
          ],
        ),
      ),
    ),



    Column(
      crossAxisAlignment: CrossAxisAlignment.end,
     
      children: <Widget>[
       



        Container(
          margin: EdgeInsets.only(left: 10),
          child: FlatButton( 
            disabledColor: Colors.transparent,
            
      child: Text(
      itemReview==0?  
      'Review':"",
          textDirection: TextDirection.ltr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            decoration: TextDecoration.none,
            fontFamily: 'MyriadPro',
            fontWeight: FontWeight.w500,
          ),
      ),
      color: Color(0xFF01D56A).withOpacity(0.8), 
      //elevation: 4.0,
      //splashColor: Colors.blueGrey,
      shape: new RoundedRectangleBorder(
            borderRadius:
                new BorderRadius.circular(5.0)),
      onPressed: itemReview==0 && widget.orderedItem.status != "Completed"?_showDialog:
      itemReview==0 && widget.orderedItem.status == "Completed" ? _reviewPrduct : null
      //_showDialog,
    ),
        ),
      ],
    )
                    ],
                  ),
                ),

                
              ],
              
            ),
          );
  }
  _reviewPrduct(){
    Navigator.push(context, SlideLeftRoute(page: ReviewPage(widget.d)));
  }


  void _showDialog() {
    // flutter defined function
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              backgroundColor: Colors.white,
              content: new Text(
                "You can only review when the order is completed",
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


