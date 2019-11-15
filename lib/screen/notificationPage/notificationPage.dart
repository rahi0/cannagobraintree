import 'dart:convert';

import 'package:canna_go_dev/api/api.dart';
import 'package:canna_go_dev/jsonModal/ordersModal/ordersModal.dart';
import 'package:canna_go_dev/main.dart';
import 'package:canna_go_dev/redux/action.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:canna_go_dev/widget/bottomAppBar/bottomAppBar.dart';
import 'package:canna_go_dev/jsonModal/NotificationDetailsModel/NotificationDetailsModel.dart';





class NotificationPage extends StatefulWidget {

  
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  

  var notificationData;
  bool _isLoading = false;

  @override
  void initState() {
  //  _updateNotification();
  //  print(store.state.notifiCheck);
   store.state.notifiCheck==true? _showNotification():null;
  //_showNotification();
    super.initState(); 
  }
void _updateNotification() async {
    var data = {};

    var res = await CallApi().postData(data, '/app/updateNoti');
    var body = json.decode(res.body);

    print(body);
   
  }
    Future <void> _showNotification() async {
   

  // print("aiche");
   setState(() {
    _isLoading = true; 
   });

  var res = await CallApi().getData('/app/getUnseenNotiDetails');
    var collection = json.decode(res.body);
    var notification = NotificationDetailsModel.fromJson(collection);
if (!mounted) return;
    setState(() {
       notificationData = notification.notification;
      
    });
     store.dispatch(NotificationCheck(false));
     store.dispatch(NotificationList(notificationData));
     
     print(notificationData);
  
setState(() {
      _isLoading = false;
    });
 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),  
            automaticallyImplyLeading: false,
         leading: Builder(
    builder: (BuildContext context) {
      return IconButton(
        icon: const Icon(Icons.arrow_back_ios,color:Color(0xFF01d56a),),
        onPressed: () { 
         // print("nj");
         
          Navigator.of(context).pop();
         
        },
       
      );
    },
  ), 
        backgroundColor:Colors.white,
     //   elevation: 0,
        title: Text("Notification",
        style: TextStyle( color:Color(0xFF01d56a),),)
        ),
      body:_isLoading?Center(child:  CircularProgressIndicator(
          backgroundColor: Colors.green,
                  ),): RefreshIndicator(
          onRefresh: _showNotification,
              child: SafeArea(
          top: false,
          child: Container(
              padding: EdgeInsets.only(right: 10, left: 10),
              child: 
                   store.state.notiList.length <1 || store.state.notiList==null
            ? Stack(
              children: <Widget>[
                Center(
                  child: Container(
             
                    child: Text("You have no new notification"), 
                    // decoration: new BoxDecoration(
                    //     shape: BoxShape.rectangle,
                    //     image: new DecorationImage(
                    //       fit: BoxFit.fill,
                    //       image:
                    //           new AssetImage('assets/images/noproduct.png'),
                    //     ))
                    ),
                ),
                 ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                 )
              ],
            )
            :  SingleChildScrollView(
               physics: const AlwaysScrollableScrollPhysics(),
              child:Padding(
                               padding: EdgeInsets.only( top: 5 , bottom: 12),
                              child:// _isLoading?CircularProgressIndicator():
                                
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: 
                                  _showOrder()
                                ),
                            ),
            ),
   
            ),
        ),
      ),
    );
  }

    List<Widget> _showOrder() {
    

    List<Widget> list = [];
   // int checkIndex=0;
    for (var d in store.state.notiList) {
       // checkIndex = checkIndex+1;
    
      //print("seeen") ;  
      //print(d.seen);
     //   print(d.status);

      list.add(
      NotificationCard(d)
      );
    }

    return list;
  }
}

// RaisedButton(
//               onPressed: (){
//                 Navigator.push( context, SlideLeftRoute(page: ShopItemsPage()));
//               },
//               child: Text('Items'),
//             ),



class NotificationCard extends StatefulWidget {

  var data;
  NotificationCard(this.data);

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  bool open = true;
  var orderedItem;

  void _showHistory() async { 
   

    var res = await CallApi().getData('/app/buyerOrder');
    var collection = json.decode(res.body);
    //print(collection);
    var orderItems = OrderData.fromJson(collection);

   
if (!mounted) return;

    setState(() {
     orderedItem  = orderItems.order;    
    });

    store.dispatch(NotiToOrderList(orderedItem));

  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

          bottomNavIndex = 2;

          _showHistory();
           Navigator.push(context,
          new MaterialPageRoute(builder: (context) => Navigation()));

      },
          child: Card(
                      elevation: 1,
                     // margin: EdgeInsets.only(bottom: 5, top: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                          color:Colors.white,
                           boxShadow:[
                             BoxShadow(color:Colors.grey[200],
                             blurRadius: 16.0,
                             // offset: Offset(0.0,3.0)
                              )
                           
                           ],
                          // border: Border.all(
                          //   color: Color(0xFF08be86)
                          // )
                        ),
            padding: EdgeInsets.only(right: 12, left: 12,top: 10,bottom: 10),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            //color: Colors.blue,
            child: Column(
              children: <Widget>[
                Container(
                  //color: Colors.red,
                  child: Row(
                   // crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                       // alignment: Alignment.center,
                        margin: EdgeInsets.only(right: 10.0),
                        child: ClipOval(
                          child: Image.asset(
                          widget.data.title=="Order Completed"?'assets/img/completed.jpg' :
                           widget.data.title=="Order has been cancelled"?'assets/img/cancel.jpg' :
                            widget.data.title=="Status Changed"?'assets/img/status.jpg' :
                          widget.data.title=="Driver found"? 'assets/img/driver_found.jpg':'assets/img/g2.png',
                            height: 42,
                            width: 42,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          //color: Colors.red,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                             widget.data.title == null
                                        ? ""
                                        : widget.data.title,

                                  //'Your Order Has been recived',
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily:"sourcesanspro",
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold       
                                                          ),
                                ),
                              ),


                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                  widget.data.msg == null
                                        ? ""
                                        : widget.data.msg,

                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                                      color: Color(0xFF343434),
                                                      fontFamily:"sourcesanspro",
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.normal       
                                                          ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),

              ],
            ),
          ),
                    ),
    );
  }
}