import 'dart:convert';

import 'package:canna_go_dev/api/api.dart';
import 'package:canna_go_dev/customPlugin/routeTransition/routeAnimation.dart';
import 'package:canna_go_dev/form/logInForm/logInForm.dart';
import 'package:canna_go_dev/jsonModal/ShopFilterModel/ShopFilterModel.dart';
import 'package:canna_go_dev/jsonModal/shopItemsModal/shopItemsModal.dart';
import 'package:canna_go_dev/main.dart';
import 'package:canna_go_dev/redux/action.dart';
import 'package:canna_go_dev/widget/bottomAppBar/bottomAppBar.dart';
import 'package:flutter/material.dart';

class SearchFilter extends StatefulWidget {
  
  @override
  _SearchFilterState createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {

  TextEditingController keywordController = TextEditingController();

  bool _isLoading = false;
 // bool _isClick = false;
  String fee="Free";
  bool _isSending = false;
  double _itemsliderValue1= 0.0;
  double _itemsliderValue2= 1000.0;

  bool box1Open = false;
  bool box2Open = false;
  bool box3Open = false;

  Color borderColor1 = Colors.transparent;
  Color borderColor2 = Colors.transparent;
  Color borderColor3 = Colors.transparent;

  var filtersOptions = [
        {'name': 'Best Rated', 'selected': false, 'id': 1},
        {'name': 'Alphabatic', 'selected': false, 'id': 2},
        {'name': 'Most Popular', 'selected': false, 'id': 3},
        {'name': 'Recomended', 'selected': false, 'id': 4},
    ];

   var feeOptions = [
        {'name': 'Free', 'selected': false, 'id': 1},
        {'name': 'Paid', 'selected': false, 'id': 2},
       
    ];

  @override
  void initState() {
    super.initState();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: AppBar(
        //elevation: 0,
        automaticallyImplyLeading: false,
              leading: Builder(
    builder: (BuildContext context) {
      return IconButton(
        icon: const Icon(Icons.arrow_back_ios,color:Color(0xFF01d56a),),
        onPressed: () { 
            store.dispatch(ClickFilterCheck(false));
          Navigator.of(context).pop();

        },
       
      );
    },
  ), 
        title: Text(
          'Search Filter',
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
        body:
         _isLoading || _isSending ?
         Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.green,
                      ),
                    )
                  : 
        SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                      //width: 320,
                     // color: Colors.red,
              margin: EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
              child: Column(
                children: <Widget>[

                  /////////////////Item Options/////////////
                  Container(
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                            boxShadow:[
                           BoxShadow(color:Colors.grey[300],
                           blurRadius: 17,
                            //offset: Offset(0.0,3.0)
                            )
                         
                         ], 
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                          


                          ////////////item dropDwon BUtton //////////
                           GestureDetector(
                      onTap: (){
                        setState(() {
                         if(box1Open != false){
                           box1Open = false;
                           borderColor1 = Colors.transparent;
                         }
                         else{
                           box1Open = true;
                           borderColor1 = Colors.grey;
                         }
                        });
                      },
                       child: Container(
                                  padding: EdgeInsets.only(left: 20, right: 20, ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                   color: Color(0xFFFFFFFF),
                                  // color: Colors.blue,
                                      boxShadow:[
                           BoxShadow(color:Colors.grey[300],
                           blurRadius: 17,
                            //offset: Offset(0.0,3.0)
                            )
                         
                         ], 
                          //           border: Border(
                          //             bottom: BorderSide( 
                          // color: borderColor1,
                          // width: 5.5,
                          //  ),
                          //           )
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                  Container(
                    child: Row(
                    children: <Widget>[
                      Text(
                                  "Item",
                                   textAlign: TextAlign.center,
                                   style: TextStyle(
                  color: Colors.black,
                  fontFamily:"sourcesanspro",
                  fontSize: 13,
                  fontWeight: FontWeight.bold       
                          ),
                   ),

                   Container(
                     margin: EdgeInsets.only(left: 10),
                     child: Text(
                                  "Click to see options",
                                   textAlign: TextAlign.center,
                                   style: TextStyle(
                  color: Colors.black54,
                  fontFamily:"sourcesanspro",
                  fontSize: 13,
                  fontWeight: FontWeight.normal       
                          ),
                   ),
                   )
                    ],
                    ),
                  ),

                  Container(
                    //check_circle_outline
                    child: IconButton(icon: Icon(Icons.arrow_drop_down_circle, color: Colors.greenAccent[400],), onPressed: null, iconSize: 30,),
                  )
                                    ],
                                  ),
                                ),
                            ),


                             ////////////item dropDwon BUtton end//////////


                            ///////Hidden Section start///////

                            box1Open ?
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 15, 20, 5),
                              //color: Colors.red,
                              //height: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _showItemsFilterOptions()
                              ),
                            ) : Container()


                            ///////Hidden Section end///////
                          ],
                        ),
                      ),
                  /////////////////Item Options end/////////////
                  



/////////////////fee Options/////////////
                  Container(
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                            boxShadow:[
                           BoxShadow(color:Colors.grey[300],
                           blurRadius: 17,
                            //offset: Offset(0.0,3.0)
                            )
                         
                         ], 
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                          


                          ////////////fee dropDwon BUtton //////////
                           GestureDetector(
                      onTap: (){
                        setState(() {
                         if(box2Open != false){
                           box2Open = false;
                           borderColor2 = Colors.transparent;
                         }
                         else{
                           box2Open = true;
                           borderColor2 = Colors.grey;
                         }
                        });
                      },
                       child: Container(
                                  padding: EdgeInsets.only(left: 20, right: 20,),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                     color: Color(0xFFFFFFFF),
                                       boxShadow:[
                           BoxShadow(color:Colors.grey[300],
                           blurRadius: 17,
                            //offset: Offset(0.0,3.0)
                            )
                         
                         ], 
                          //           border: Border(
                          //             bottom: BorderSide( 
                          // color: borderColor2,
                          // width: 1.5,
                          //  ),
                          //           )
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                  Container(
                    child: Row(
                    children: <Widget>[
                      Text(
                                  "Delivery Fee",
                                   textAlign: TextAlign.center,
                                   style: TextStyle(
                  color: Colors.black,
                  fontFamily:"sourcesanspro",
                  fontSize: 13,
                  fontWeight: FontWeight.bold       
                          ),
                   ),

                   Container(
                     margin: EdgeInsets.only(left: 10),
                     child: Text(
                                  "Click to see options",
                                   textAlign: TextAlign.center,
                                   style: TextStyle(
                  color: Colors.black54,
                  fontFamily:"sourcesanspro",
                  fontSize: 13,
                  fontWeight: FontWeight.normal       
                          ),
                   ),
                   )
                    ],
                    ),
                  ),

                  Container(
                    //check_circle_outline
                    child: IconButton(icon: Icon(Icons.arrow_drop_down_circle, color: Colors.greenAccent[400],), onPressed: null, iconSize: 30,),
                  )
                                    ],
                                  ),
                                ),
                            ),


                             ////////////item dropDwon BUtton end//////////


                            ///////Hidden Section start///////

                            box2Open ?
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 15, 20, 5),
                              //color: Colors.red,
                              //height: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _showFeeOptions()
                              ),
                            ) : Container()


                            ///////Hidden Section end///////
                          ],
                        ),
                      ),
                  /////////////////Item Options end/////////////



                  //////////////Item Slider //////////

                       fee=="Free"? Container() :Container(
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Container(
                          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 0),
                          //color: Colors.red,
                          child: Text(
                          "Delivery Fee",
                           textAlign: TextAlign.center,
                           style: TextStyle(
                          color: Colors.black,
                          fontFamily:"sourcesanspro",
                          fontSize: 13,
                          fontWeight: FontWeight.bold       
                            ),
                           ),
                        ),

                        Container(
                          margin: EdgeInsets.fromLTRB(20, 15, 20, 5),
                          //color: Colors.red,
                          //height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              
//////////////
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                //color: Colors.red,
                                child: Column(
      children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Container(
                  //color: Colors.red,
                  child: Text(
                          "From",
                           textAlign: TextAlign.center,
                           style: TextStyle(
                          color: Colors.black54,
                          fontFamily:"sourcesanspro",
                          fontSize: 15,
                          fontWeight: FontWeight.normal       
                            ),
                           ),
                ),
                Expanded(
                                child: Stack(
                      children: <Widget>[
                        Container(
                          //width: 120,
                          padding: EdgeInsets.only(top: 10),
                          //color: Colors.yellow,
                      child: Slider(
                        activeColor: Colors.grey[600],
                        min: 0.0,
                        max: 500.0,
                        onChanged: (newRating) {
                          setState(() => _itemsliderValue1 = newRating);
                        },
                        value: _itemsliderValue1,
                      ),
                    ),

                    Positioned(
                      right: 10,
                      child: Text(
                            "\$500",
                             textAlign: TextAlign.center,
                             style: TextStyle(
                            color: Colors.black54,
                            fontFamily:"sourcesanspro",
                            fontSize: 13,
                            fontWeight: FontWeight.normal       
                              ),
                             ),
                    )
                      ],
                  ),
                ),

                // This is the part that displays the value of the slider.
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    width: 50.0,
                    height: 25,
                    alignment: Alignment.center,
                    child: Text('${_itemsliderValue1.toInt()}',
                        style: TextStyle(
                            color: Colors.greenAccent[400],
                            fontFamily:"sourcesanspro",
                            fontSize: 15,
                            fontWeight: FontWeight.normal       
                              )),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
                              ),






 /////////////
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                               // color: Colors.red,
                                child: Column(
      children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Container(
                  //color: Colors.red,
                  child: Text(
                          "To",
                           textAlign: TextAlign.center,
                           style: TextStyle(
                          color: Colors.black54,
                          fontFamily:"sourcesanspro",
                          fontSize: 15,
                          fontWeight: FontWeight.normal       
                            ),
                           ),
                ),
                Expanded(
                                child: Stack(
                      children: <Widget>[
                        Container(
                          //width: 150,
                          padding: EdgeInsets.only(top: 10),
                          //color: Colors.yellow,
                      child: Slider(
                        activeColor: Colors.grey[600],
                        min: 0.0,
                        max: 1000.0,
                        onChanged: (newRating) {
                          setState(() => _itemsliderValue2 = newRating);
                        },
                        value: _itemsliderValue2,
                      ),
                    ),

                    Positioned(
                      right: 10,
                      child: Text(
                            "\$1000",
                             textAlign: TextAlign.center,
                             style: TextStyle(
                            color: Colors.black54,
                            fontFamily:"sourcesanspro",
                            fontSize: 13,
                            fontWeight: FontWeight.normal       
                              ),
                             ),
                    )
                      ],
                  ),
                ),

                // This is the part that displays the value of the slider.
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    width: 50.0,
                    height: 25,
                    alignment: Alignment.center,
                    child: Text('${_itemsliderValue2.toInt()}',
                        style: TextStyle(
                            color: Colors.greenAccent[400],
                            fontFamily:"sourcesanspro",
                            fontSize: 15,
                            fontWeight: FontWeight.normal       
                              )),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
                              )
                              

                        
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                   //////////////Item Slider End //////////
                          


                 
                  /////////////////KeyWord //////////

                 Container(
                   
                      //color: Colors.red,
                      margin: EdgeInsets.only(bottom: 30, top: 10),
                    //  padding: EdgeInsets.only(bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            //width: 300,
                            margin: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                            child: Text(
                              "Keyword (Address)",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontFamily: "sourcesanspro",
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            //width: 350,
                              decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                            boxShadow:[
                           BoxShadow(color:Colors.grey[300],
                           blurRadius: 17,
                            //offset: Offset(0.0,3.0)
                            )
                         
                         ], 
                        ),
                            height: 40,
                            child: TextField(
                              controller: keywordController,
                              style: TextStyle(color: Color(0xFF000000)),
                              cursorColor: Color(0xFF9b9b9b),
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(20),
                 borderSide:
                     BorderSide(color: Color(0xFFFFFFFF))),
                                enabledBorder: UnderlineInputBorder(
                 borderRadius: BorderRadius.circular(20),
                 borderSide:
                     BorderSide(color: Color(0xFFFFFFFF))),
                                hintText: "Type here",
                                hintStyle: TextStyle(
                 color: Color(0xFF9b9b9b),
                 fontSize: 15,
                 fontFamily: "sourcesanspro",
                 fontWeight: FontWeight.w300),
                                contentPadding:
                 EdgeInsets.only(left: 20, bottom: 12, top: 12),
                                fillColor: Color(0xFFFFFFFF),
                                filled: true,
                              ),
                               onChanged: (val) { 
                                  setState(() {
                                  store.dispatch(ClickFilterCheck(true));
                                    //searchAddr = val;
                                  });
                                },
                            ),
                          ),
                        ],
                      ),
                    ),

                   /////////////////KeyWord end//////////




                  /////////////////  Button Section Start///////////////
                          ///
                          ///
                      Container(
                        //color: Colors.yellow,
                            margin: EdgeInsets.only(top: 20, bottom: 25),
                    child:!store.state.isClickFilter? Container(
                                      decoration: BoxDecoration(
                                        color: _isSending ? Colors.black : Colors.greenAccent[400], 
                                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                                      ),
                                      //width: 100,
                                      height: 35,
                                      padding: EdgeInsets.only(left: 5, right: 5),
                                      child: FlatButton(
                                        child: Text(
                                          _isSending ? 'Please wait...' : 'Apply',
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                              color:  Color(0xFFFFFFFF),
                                              fontSize: 17.0,
                                              decoration: TextDecoration.none,
                                              fontFamily: 'MyriadPro',
                                              fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        color: Colors.transparent,
                                        //elevation: 4.0,
                                        //splashColor: Colors.blueGrey,
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(20.0)),
                                        onPressed: _isSending ? null : _fetchFilteredData
                                      )):  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                         

                       Container(
                                      decoration: BoxDecoration( color: Color(0xFFFFFFFF), borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                      border: Border.all(color: Colors.grey),
                                    
                         
                        //  color: Colors.white,
                            boxShadow:[
                           BoxShadow(color:Colors.grey[300],
                           blurRadius: 17,
                            //offset: Offset(0.0,3.0)
                            )
                         
                         ], 
                        ),
                                                      
                                     // width: 100,
                                      height: 35,
                                      child: OutlineButton(
                                        highlightedBorderColor: Colors.black,
                                       focusColor: Colors.black,
                                        onPressed: () {
                                         

                                        store.dispatch(CheckFilter(false));
                                       // Navigator.of(context).pop();
                                       
                                        setState(() {
                                          _isLoading = true;
                                          
                                          });
                                           store.dispatch(ClickFilterCheck(false));
                                          //  store.dispatch(CheckFilter(false));
                                         Navigator.push(context, SlideLeftRoute(page: Navigation()));
                                                     


                                        },
                                        child: Text(
                                          _isLoading?"Please wait...":'Clear',
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.0,
                                              decoration: TextDecoration.none,
                                              fontFamily: 'MyriadPro',
                                              fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        color: Colors.transparent,
                                        //elevation: 4.0,
                                        //splashColor: Colors.blueGrey,
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(25.0)),
                                        
                                      )),


                                      ///////////////// Next In Button  Start///////////////
                        



                        Container(
                                      decoration: BoxDecoration(
                                        color: _isSending ? Colors.black : Colors.greenAccent[400], 
                                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                                      ),
                                      //width: 100,
                                      height: 35,
                                      padding: EdgeInsets.only(left: 5, right: 5),
                                      child: FlatButton(
                                        child: Text(
                                          _isSending ? 'Please wait...' : 'Apply',
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                              color:  Color(0xFFFFFFFF),
                                              fontSize: 17.0,
                                              decoration: TextDecoration.none,
                                              fontFamily: 'MyriadPro',
                                              fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        color: Colors.transparent,
                                        //elevation: 4.0,
                                        //splashColor: Colors.blueGrey,
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(20.0)),
                                        onPressed: _isSending ? null : _fetchFilteredData
                                      )),

                                      ///////////////// Next In Button  End///////////////



                                     

                      ],
                    ),
                  )

                  /////////////////  Button Section end///////////////
                ],
              ),
            ),
          ),
        ),

          
      );
  }

  List<Widget> _showItemsFilterOptions(){
      List<Widget> items= [];
      var index = 0;
      for(var d in filtersOptions){
        items.add(
           GestureDetector(
                    onTap: (){
                       _changeOption(d['id']);
                                             
                                           },
                                           child: Container(
                                             padding: EdgeInsets.only(top: 10,bottom: 10),
                                           decoration: BoxDecoration(
                                       //color: Colors.red,
                                       border: Border(
                                                         bottom: BorderSide( 
                                             color: Colors.grey,
                                             width: 0.5,
                                              ),
                                                     )
                                                   ),
                                                   child: Row(
                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                     children: <Widget>[
                                                         Container(
                                                           child: Text(
                                                   "${d['name']}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                         color: Colors.black,
                                                         fontFamily:"sourcesanspro",
                                                         fontSize: 16,
                                                         fontWeight: FontWeight.normal       
                                         ),
                                                          ),
                                                         ),
                       
                                                         Container(
                                                           child: Row(
                                         children: <Widget>[
                       
                                           d['selected'] ? Container(
                                             child: Icon(Icons.check_circle, color: Colors.greenAccent[400],),
                                           ) : Container(),
                                         ],
                                                           ),
                                                         )
                                                     ],
                                                   ),
                                                 ),
                                                       ),
                       
                                );
                                index++;
                             }
                            
                             return items;
                         }



 List<Widget> _showFeeOptions(){
      List<Widget> items= [];
      var index = 0;
      for(var d in feeOptions){
        items.add(
           GestureDetector(
                    onTap: (){
                       _changeFeeOption(d['id']);
                                             
                                           },
                                           child: Container(
                                             padding: EdgeInsets.only(top: 10,bottom: 10),
                                           decoration: BoxDecoration(
                                       //color: Colors.red,
                                       border: Border(
                                                         bottom: BorderSide( 
                                             color: Colors.grey,
                                             width: 0.5,
                                              ),
                                                     )
                                                   ),
                                                   child: Row(
                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                     children: <Widget>[
                                                         Container(
                                                           child: Text(
                                                   "${d['name']}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                         color: Colors.black,
                                                         fontFamily:"sourcesanspro",
                                                         fontSize: 16,
                                                         fontWeight: FontWeight.normal       
                                         ),
                                                          ),
                                                         ),
                       
                                                         Container(
                                                           child: Row(
                                         children: <Widget>[
                       
                                           d['selected'] ? Container(
                                             child: Icon(Icons.check_circle, color: Colors.greenAccent[400],),
                                           ) : Container(),
                                         ],
                                                           ),
                                                         )
                                                     ],
                                                   ),
                                                 ),
                                                       ),
                       
                                );
                                index++;
                             }
                            
                             return items;
                         }
 
                       
void _changeOption(id) {
  for(var d in filtersOptions){
     if(id==d['id']){
        d['selected'] = true;
     }else{
       d['selected'] = false;
     }
  }
  setState(() {
      filtersOptions = filtersOptions;
      store.dispatch(ClickFilterCheck(true));
  });
}


                       
void _changeFeeOption(id) {
  for(var d in feeOptions){
     if(id==d['id']){
        d['selected'] = true;
        fee = d['name'];

     }
     else{
       d['selected'] = false;
     }
  }
  setState(() {
      feeOptions = feeOptions;
      store.dispatch(ClickFilterCheck(true));
      print(feeOptions);
  });
}

void _fetchFilteredData() async {
 

 store.dispatch(FilterItemsList([]));

  // if(keywordController.text.isEmpty){
  //   return _showErrorDialog("Keyword must not be empty") ;
  // }
    setState(() {
       _isSending = true;
       bottomNavIndex = 0;
     
    });
   

    var sortType=''; 
    for(var d in filtersOptions){
      if(d['selected']){                                                                              
        sortType = d['name'];
        break;
      }
    }

    String _isFree = "";
   
     for(var d in feeOptions){
      if(d['selected']){   
        if(d['name']=='Free')   {
        _isFree = "free";
        _itemsliderValue1 = 0;
        _itemsliderValue2 = 0;
        }           

        else{
           _isFree = "paid";
        }                                                             
     
        break;
      }
    }
    

    var urlStr = '/app/shopAllSearch?price1=$_itemsliderValue1&price2=$_itemsliderValue2&key=&sortType=$sortType&isDeliveryFree=$_isFree&address=${keywordController.text}'; 
    print(urlStr);

if(urlStr=='/app/shopAllSearch?price1=0.0&price2=1000.0&key=&sortType=&isDeliveryFree=&address='){
   store.dispatch(CheckFilter(false));
 setState(() {
       _isSending = false; 
    });
_showErrorDialog("You have not applied any filters");
}
else{

   setState(() {
       _isSending = true;
     
    });

    store.dispatch(CheckFilter(true));
 var res = await CallApi().getData(urlStr);
    var collection = json.decode(res.body);
   
    var filterShop = ShopFilterModel.fromJson(collection);
 
    store.dispatch(FilterItemsList(filterShop.allShops));

    // print(filterShop.allShops);
     print(store.state.filterItemsList.length);
  // setState(() {
  //      _isSending = false;
  //   });

     Navigator.push(context, SlideLeftRoute(page: Navigation()));
   // Navigator.pop(context);
  
}

   
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