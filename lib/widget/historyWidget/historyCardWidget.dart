import 'package:canna_go_dev/customPlugin/routeTransition/routeAnimation.dart';
import 'package:canna_go_dev/screen/DriverLocation/DriverLocation.dart';
import 'package:canna_go_dev/screen/historyDetailPage.dart/historyDetailsPage.dart';
import 'package:canna_go_dev/screen/reportPage/reportPage.dart';
import 'package:flutter/material.dart';

class HistoryCard extends StatefulWidget {
  final orderedItem;
  HistoryCard(this.orderedItem);
  @override
  _HistoryCardState createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  var orderIdd;

  @override
  void initState() {
    setState(() {
      orderIdd = widget.orderedItem.id;
    });
    super.initState();
  }

  double _itemsliderValue1 = 3.0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            SlideLeftRoute(page: HistoryDetailsPage(widget.orderedItem)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              blurRadius: 6,
              //offset: Offset(0.0,3.0)
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ////////////////Pic Name Price Slide Section Start////////////
            Container(
              //color: Colors.red,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ///////////  image/////////

                  Container(
                    width: 90,
                    height: 90,
                    margin: EdgeInsets.only(right: 10),
                    decoration: new BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: widget.orderedItem.seller.user.img == null
                            ? new AssetImage('assets/img/camera.png')
                            : NetworkImage("https://www.dynamyk.biz" +
                                widget.orderedItem.seller.user.img),
                      ),
                    ),
                  ),

                  /////////// item image end/////////

                  ////////////// Details//////////////

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        /////////////   title   /////////////
                        Container(
                          //width: 150,
                          // color: Colors.green,
                          //  height: 10,
                          width: MediaQuery.of(context).size.width / 2,
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            //"name",
                            "${widget.orderedItem.seller.name}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Color(0xFF343434),
                                fontFamily: "DINPro",
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        ////////////   price    ///////////////

                        Container(
                          //width: 80,
                          //color: Colors.green,
                          width: MediaQuery.of(context).size.width / 2,
                          margin: EdgeInsets.only(top: 5),
                          child: Text.rich(
                            TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: "Total: ",
                                style: TextStyle(
                                    color: Colors.grey[900],
                                    fontFamily: "DINPro",
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                              TextSpan(
                                text:
                                    "\$ ${(widget.orderedItem.price).toStringAsFixed(2)}",
                                style: TextStyle(
                                    color: Color(0xFF01D56A),
                                    fontFamily: "DINPro",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                          ),
                        ),

                        ///////////  Rating Start ///////////

                        Container(
                          // color: Colors.yellow,
                          //width: MediaQuery.of(context).size.width - 120,
                          margin: EdgeInsets.only(top: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              ///////////  Rating Text ///////////

                              Container(
                                child: Text(
                                  'Order Status: ',
                                  //overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    color: Colors.grey[900],
                                    fontSize: 15.0,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'sourcesanspro',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),

                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Text(
                                  '${widget.orderedItem.status}',
                                  // overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    color:
                                        widget.orderedItem.status == "Completed"
                                            ? Color(0xFF01D56A)
                                            : widget.orderedItem.status ==
                                                    "Cancelled"
                                                ? Colors.red[300]
                                                : Color(0xFFffa900),
                                    fontSize: 16.0,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'sourcesanspro',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),

                              ///////////////////   Rating Bar ///////////

                              //      Expanded(
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: <Widget>[

                              //       Container(
                              //         //color: Colors.red,
                              //         child: Text(
                              //                 "Rating",
                              //                  textAlign: TextAlign.center,
                              //                  style: TextStyle(
                              //                 color: Colors.black54,
                              //                 fontFamily:"sourcesanspro",
                              //                 fontSize: 15,
                              //                 fontWeight: FontWeight.normal
                              //                   ),
                              //                  ),
                              //       ),
                              //       Expanded(
                              //         child: Slider(
                              //       activeColor: Colors.grey[600],
                              //       min: 0.0,
                              //       max: 4.0,
                              //       onChanged: (newRating) {
                              //         setState(() => _itemsliderValue1 = newRating);
                              //       },
                              //       value: _itemsliderValue1,
                              //           ),
                              //         ),

                              //       // This is the part that displays the value of the slider.
                              //       Card(
                              //         elevation: 4,
                              //         //color: Colors.green,
                              //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              //         child: Container(
                              //           width: 60.0,
                              //           height: 25,
                              //           alignment: Alignment.center,
                              //           child: Text('${_itemsliderValue1.toInt()}',
                              //               style: TextStyle(
                              //                   color: Colors.greenAccent[400],
                              //                   fontFamily:"sourcesanspro",
                              //                   fontSize: 14,
                              //                   fontWeight: FontWeight.normal
                              //                     )),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),

                              /////////Rating bar//////////
                            ],
                          ),
                        ),

                        ///////////  Rating End ///////////
                      ],
                    ),
                  )
                ],
              ),
            ),
            ////////////////Pic Name Price Slide Section end////////////

            ////////////////Reviw Section Start////////////

            // Container(
            //   //color: Colors.blue,
            //   margin: EdgeInsets.only(top: 5),

            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: <Widget>[

            //         ////////  review /////////
            //     Container(
            //     //  width: 65,
            //      // height: 30,
            //      margin: EdgeInsets.only(right: 5),
            //       child: Text(
            //           "Review",
            //            textAlign: TextAlign.left,
            //            style: TextStyle(

            //               color: Color(0xFF9b9b9b),
            //               fontFamily: "MyriadPro",
            //               fontSize: 16,
            //               fontWeight: FontWeight.w400
            //                   ),
            //                ),
            //             ),

            //       ////////  review textfield /////////

            //        Expanded(
            //                                 child: Card(
            //                elevation: 4,
            //                shape: RoundedRectangleBorder(
            //                borderRadius: BorderRadius.circular(20)
            //                            ),
            //               child: Container(
            //                   width: 215,
            //                   //height: 35,

            //                   decoration: BoxDecoration(
            //                   color: Colors.white70,
            //                     borderRadius: BorderRadius.circular(20),
            //                     //boxShadow: Colors.black,
            //                   ),

            //               child:TextField(

            //                   style: TextStyle(color: Color(0xFF000000)),
            //                   cursorColor: Color(0xFF9b9b9b),
            //                     decoration:

            //                     InputDecoration(
            //                           focusedBorder: OutlineInputBorder(
            //                               borderRadius: BorderRadius.circular(20),
            //                               borderSide: BorderSide(color: Color(0xFFFBFBFB))
            //                             ),
            //                     enabledBorder: UnderlineInputBorder(
            //                             borderRadius: BorderRadius.circular(20),

            //                             borderSide: BorderSide(color: Color(0xFFFFFFFF)),

            //                     ),
            //                     hintText: "Type here",
            //                     hintStyle: TextStyle(
            //                           color: Color(0xFF9b9b9b),
            //                           fontSize: 12,
            //                           fontFamily:"standard-regular",
            //                           fontWeight: FontWeight.w400
            //                         ),
            //                   contentPadding: EdgeInsets.only(left: 20, bottom: 8, top: 8),
            //                   fillColor: Colors.white70,
            //                   filled: true,
            //                   ),
            //                 ),

            //             ),
            //          ),
            //        ),

            //       ],
            //     ),
            // ),

            ////////////////Reviw Section end////////////

            ////////////////Button Section Start////////////
            Container(
              //color: Colors.yellow,
              margin: EdgeInsets.only(top: 8),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, SlideLeftRoute(page: ReportPage(orderIdd)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1.5,
                            color: Colors.red[300],
                          ),
                        ),
                      ),

                      ///////////////// "Report Issue"///////////////
                      child: Text(
                        "Report Issue",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.red[300],
                            fontFamily: "sourcesanspro",
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),

                  /////////////////track location Button///////////////

                  Container(
                      decoration: BoxDecoration(
                        color:
                            widget.orderedItem.status == "Order is on the way"
                                ? Color(0xFF01D56A)
                                : Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      height: 35,
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: FlatButton(
                        child: Text(
                          'Driver Location',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.0,
                            fontFamily: 'MyriadPro',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        onPressed: () {
                         widget.orderedItem.status=="Order is on the way" ? Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      DriverLocation(widget.orderedItem))):
                                      _showHint();
                        },
                      )), //:Container(),

                  ///////////////// reorder Button///////////////
                  //         Container(
                  //                 decoration: BoxDecoration( color:Color(0xFF01D56A),
                  //                  borderRadius: BorderRadius.all(Radius.circular(20.0)),

                  //       ),
                  //                 height: 35,
                  //                 padding: EdgeInsets.only(left: 20, right: 20),
                  //                 child: FlatButton(
                  //                   child: Text(
                  //                   'Reorder',

                  //                   textAlign: TextAlign.center,
                  //                   style: TextStyle(
                  //                   color: Colors.white,
                  //                   fontSize: 17.0,

                  //                   fontFamily: 'MyriadPro',
                  //                   fontWeight: FontWeight.normal,
                  //                   ),
                  //                   ),

                  //                   onPressed: () {
                  // //                     Navigator.push(
                  // //  context,
                  // //  new MaterialPageRoute(
                  // //    builder: (context) => Inquire()
                  // //  ));
                  //                   },
                  //                 )),
                ],
              ),
            )

            ////////////////Button Section end////////////
          ],
        ),
      ),
    );
  }
  void _showHint() {
   
    showDialog( 
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: EdgeInsets.all(5),
          title: Text(
            "You can see driver location when the order is on the way",
            // textAlign: TextAlign.justify,
            style: TextStyle(
                color: Color(0xFF000000), 
                fontFamily: "grapheinpro-black",
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
          content: Container(
              height: 70,
              width: 250,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.greenAccent[400],
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        width: 110,
                        height: 45,
                        margin: EdgeInsets.only(top: 25, bottom: 15),
                        child: OutlineButton(
                            color: Colors.greenAccent[400],
                            child: new Text(
                              "Close",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            borderSide:
                                BorderSide(color: Colors.green, width: 0.5),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0))))
                  ])),
        );
      },
    );
    // });
  }
  
}
