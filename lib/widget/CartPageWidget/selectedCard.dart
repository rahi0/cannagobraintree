import 'dart:convert';

import 'package:canna_go_dev/api/api.dart';
import 'package:flutter/material.dart';



class SelectedCard extends StatefulWidget {
  final data;
  SelectedCard(this.data); 
  @override
  _SelectedCardState createState() => _SelectedCardState();
}

class _SelectedCardState extends State<SelectedCard> {

  bool _isLoading = false;
  bool _isDeleted = false;
  var itemData;

 

 @override
  void initState() {
    print(widget.data);
    super.initState();
  }

//   void _showCartItems() async{

//     setState(() {
//       _isLoading = true;
//     });

//  //   store.dispatch(cartData(widget.data));
   
//     setState(() {
        
//         _isLoading = false;
       
//       });
//   }
  @override
  Widget build(BuildContext context) {
    return //_isDeleted ? Container() : 
    Container(
      
         //color: Colors.blue,
       child: Card(
         elevation: 4,
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(15)
         ),
              child: Container(
                //color: Colors.red,
                          child: Stack(
                            children: <Widget>[
                                   Container(
                                padding: EdgeInsets.only(bottom: 15, top: 15),
                               
                                      decoration: BoxDecoration(
                                         color: Color(0xFFFFFFFF),
                                        borderRadius: BorderRadius.circular(15)
                                       
                                      ),

                                     
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                            
                                            Container(
                                             // color: Colors.red,
                                              width: 100,
                                              margin: EdgeInsets.only(top: 2, bottom: 3),
                                              padding: EdgeInsets.only(left: 8),
                                              child: Text.rich(
                                TextSpan(children: <TextSpan>[
                                  TextSpan(
                                    text: "${widget.data.item.price}",//"\$${store.state.cart.item.price}",
                                    style: TextStyle(
                                  color: Color(0xFF01D56A),
                                  fontFamily: "sourcesanspro",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400       
                                        ),
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
                                ] ),
                              ),
                                            ),
                                            Container(
                                              width: 65,
                                              height: 65,
                                              //margin: EdgeInsets.only(left: 15),
                                              decoration: new BoxDecoration(
                                              //shape: BoxShape.circle,
                          
                                           image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            
                                            image: new AssetImage("assets/img/med.jpg"),
                                            
                                        )
                                  )
                               ),

                                          Container(   
                                           // color: Colors.blue, 
                      width: 100,
                    //  height: 15,
                      margin: EdgeInsets.only(top: 5),
                      child: Text( 
                        widget.data.item.name,
                        //widget.data.item.name,
                      //  widget.data['item']['name'],
                      
                              overflow: TextOverflow.ellipsis,
                               textAlign: TextAlign.center,
                               style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontFamily:"sourcesanspro",
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400       
                                        ),
                                   ),
                                ),

                    //       Container(    
                    //   width: 100,
                    // //  height: 10,
                    //   margin: EdgeInsets.only(top: 3),
                    //   child: Text(
                    //           "900v",
                    //           overflow: TextOverflow.ellipsis,
                    //            textAlign: TextAlign.center,
                    //            style: TextStyle(
                    //               color: Color(0xFF000000),
                    //               fontFamily:"sourcesanspro",
                    //               fontSize: 13,
                    //               fontWeight: FontWeight.w400       
                    //                     ),
                    //                ),
                    //             ),
                                

                                Container(
                                 // color: Colors.red,
                                 margin: EdgeInsets.only(top: 5),
                                 padding: EdgeInsets.only(left: 5, right: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[

                                      ///////////// Dicrement Button////////
                                      GestureDetector(
                                        onTap: (){

                                          decrement();
                                        },
                                       child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(width: 1,  color: Color(0xFF9b9b9b)),
                                            left: BorderSide(width: 1, color: Color(0xFF9b9b9b),),
                                            right: BorderSide(width: 1, color: Color(0xFF9b9b9b),),
                                            bottom: BorderSide(width: 1, color: Color(0xFF9b9b9b),),
                                        ),
                                            shape: BoxShape.circle,
                                    ),      
                                    child: Icon(
                                        Icons.remove
                                     // size: 20,
                                    ),
                                  ),
                                      ),

                                      //////////// Dicrement Button end////////
                                  
                                  ///////////Quantity start /////////
                                  Container(    
                                    //width: 100,
                                  //  height: 10,
                                margin: EdgeInsets.only(top: 3),
                                child: Text(
                                  "${widget.data.quantity}",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontFamily:"sourcesanspro",
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold       
                                                  ),
                                            ),
                                          ),
                                  ///////////Quantity end /////////
                                  

                                  //////////// Increment Button////////
                                  GestureDetector(
                                    onTap: (){

                                      increment();

                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                             top: BorderSide(width: 1,  color: Color(0xFF9b9b9b)),
                                            left: BorderSide(width: 1, color: Color(0xFF9b9b9b),),
                                            right: BorderSide(width: 1, color: Color(0xFF9b9b9b),),
                                            bottom: BorderSide(width: 1, color: Color(0xFF9b9b9b),),
                                        ),
                                            shape: BoxShape.circle,
                                      ),
                                      
                                              
                                      child: Icon(
                                        Icons.add,
                                       // size: 20,
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
                                    onTap: (){
                                      _deleteCart();
                                    },
                                     child: Container(
                                     // margin: EdgeInsets.only(left: 85),
                                            child: Icon(
                                              Icons.cancel
                                            ),
                                          ),
                                  ),
                                )
                               ],
                            ),
                        ),
       ),
     );
  }


  decrement(){

        if(widget.data.quantity == 1){

        }
        else{
      setState(() {
            widget.data.quantity--;
        });
      
    }
  }

  increment(){

        setState(() {

         widget.data.quantity++;
        });
  }


  void _deleteCart() async{

    var data = {
      'id': '${widget.data.id}'//'${store.state.cart.id}',
      };      
      var res = await CallApi().postData(data, '/app/curtsdelete');     
      var body = json.decode(res.body);      
      print(body);    

     //  store.dispatch(deleteItem(store.state.cart)); 

      if (body['success'] == true) {      
      setState(() {
         _isDeleted = true; 
       });
        } 
      //   else {  //_showMsg(body['message']);     
      //   }
      setState(() {
        
      });
  }
}