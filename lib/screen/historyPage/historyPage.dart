import 'dart:convert';
import 'package:canna_go_dev/main.dart';
import 'package:canna_go_dev/api/api.dart';
import 'package:canna_go_dev/jsonModal/ordersModal/ordersModal.dart';
import 'package:canna_go_dev/widget/historyWidget/historyCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:canna_go_dev/widget/bottomAppBar/bottomAppBar.dart';
import 'package:canna_go_dev/redux/action.dart';
class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool _isLoading = false;
  var orderedItem = [];

  @override
  void initState() {
     bottomNavIndex = 2;
      store.dispatch(ConnectionCheck(true));
        store.dispatch(CheckFilter(false));
  //  store.state.historyOrderList.length>0 ?null: _showHistory();
  store.state.isHistory==true ?null: _showHistory();
   
   if(store.state.historyOrderList.length>0){
     if( store.state.historyOrderList.length== store.state.notiToOrder.length){
       _showOrderHistory();
     }
   }
    super.initState();
  }



 Future<void> _showHistory() async { 
     setState(() {
      _isLoading = true;
    });

    var res = await CallApi().getData('/app/buyerOrder');
    var collection = json.decode(res.body);
    //print(collection);
    var orderItems = OrderData.fromJson(collection);

   
if (!mounted) return;

    setState(() {
       orderedItem  = orderItems.order;
      _isLoading = false;
    });

    store.dispatch(HistoryOrderList(orderedItem));
      store.dispatch(HistoryCheck(true));

    // setState(() {
    //   _isLoading = false;
    //   if (productItems.allItems.length > 0) {
    //     _isDataFound = true;
    //   }
    //   sellerProductItems = productItems;
    // });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        backgroundColor: Colors.white,
        body: _isLoading ? Center(
              child: CircularProgressIndicator(
               backgroundColor: Colors.green,
              ),
            ) : RefreshIndicator(
                  onRefresh: _showHistory,
                 
              child:SafeArea(
          child: 
          store.state.historyOrderList.length <1 ? Stack(
            children: <Widget>[
              Center(
                child: Text(
                  'You have not placed any order yet.',
                  style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold
                ),),
              ),
              ListView(
                 physics: const AlwaysScrollableScrollPhysics(),
              )
            ],
          )
            
            :
             SingleChildScrollView( 
              physics: const AlwaysScrollableScrollPhysics(),
            child:  Container(
                 
                 //margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
                 padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                child: Column(
        children: <Widget>[

            Column(
              children: _showOrderHistory(),
            )
             ],
                ),
              ),
            ),
          )
            ),
      );
  }


  List<Widget> _showOrderHistory() {

    List<Widget> list = [];
    // var index = 0;
    for (var d in store.state.historyOrderList) {
      list.add(
       HistoryCard(d) 
      );
    }

    return list;
  }
}