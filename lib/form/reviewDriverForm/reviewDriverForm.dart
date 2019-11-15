import 'dart:convert';

import 'package:canna_go_dev/api/api.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:canna_go_dev/widget/bottomAppBar/bottomAppBar.dart';

class DriverReviewForm extends StatefulWidget {
  final d;
  DriverReviewForm(this.d);
  @override
  _DriverReviewFormState createState() => _DriverReviewFormState();
}

class _DriverReviewFormState extends State<DriverReviewForm> {
  bool _isLoading = false;
  var rating = 0.0;
  TextEditingController reviewController = TextEditingController();

// @override
//   void initState() {
//     print(widget.d.driver.user.name);
//     super.initState();
//   }


  void showMsg(BuildContext context, String msg) {
  //
  final snackBar = SnackBar(
    content: Text(msg),
    action: SnackBarAction(
      label: 'Close',
      onPressed: () {
        // Some code to undo the change!
      },
    ),
  );
  Scaffold.of(context).showSnackBar(snackBar);
}

  @override
  Widget build(BuildContext context) {
    return Container(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                //color: Colors.red,
                child: Column(
                  children: <Widget>[
                    ///////////Picture///////////
                    Container(
                      margin: EdgeInsets.only(bottom: 20, top: 20),
                      height: MediaQuery.of(context).size.width / 1.5, 
                      width: MediaQuery.of(context).size.width / 1.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      //  border: Border.all(color: Colors.black38, width: 0.5),
                        // image: DecorationImage(
                        //     image: AssetImage('assets/img/med.jpg'),
                        //     fit: BoxFit.fill),
                         image: DecorationImage(
                         
                           image:widget.d.driver.user.img==null? AssetImage('assets/img/camera.png'):NetworkImage("https://www.dynamyk.biz"+widget.d.driver.user.img),
                           fit: BoxFit.fill),
                      boxShadow: [
                          BoxShadow(
                            color: Colors.grey[200],
                          //  offset: Offset(5.0, 2.5),
                            blurRadius: 20.0,
                          )
                        ],
                      ),
                    ),
                    /////////picture End////////

                    ////////// Item Details /////////
                    Card(
                      elevation: 0,
                      margin: EdgeInsets.only(
                          bottom: 15, left: 5, right: 5, top: 5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: <Widget>[


                            /////////////RAting////////
                            

                            Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              //color: Colors.red,
                              margin: EdgeInsets.only(bottom: 10),
                              child: Text(
                                'Please give review for this product',
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17.0,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'MyriadPro',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            SmoothStarRating(
                              allowHalfRating: false,
                              rating: rating,
                              size: 35,
                              starCount: 5,
                              spacing: 2.0,
                              color: Color(0xFFffa900),
                              borderColor: Color(0xFF343434),
                              onRatingChanged: (value) {
                                setState(() {
                                  rating = value;
                                });
                              },
                            ),
                          ],
                        ),
                            


                            ///////Rating end/////////


                            /////////////
                            Container(
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, top: 15, bottom: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    //width: 300,
                                    height: 30,
                                    margin: EdgeInsets.only(left: 15, top: 15),
                                    child: Text(
                                      "Review",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Color(0xFF000000),
                                          fontFamily: "sourcesanspro",
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                  //  height: 200,
                                       decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      
                                            boxShadow:[
                           BoxShadow(color:Colors.grey[300],
                           blurRadius: 17,
                            //offset: Offset(0.0,3.0)
                            )
                         
                         ], 
                                        
                      color: Colors.white),
                                    //color: Colors.blue,
                                    //padding: EdgeInsets.all(10.0),
                                    child: new SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                     // reverse: true,
                                      child: new TextField(
                                        maxLength: 250,
                                        maxLines: 4,
                                        controller: reviewController,
                                        decoration: new InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                  color: Color(0xFFFFFFFF))),
                                          enabledBorder: UnderlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                  color: Color(0xFFFFFFFF))),
                                          hintText: 'Add your text here',
                                          hintStyle: TextStyle(
                                              color: Color(0xFF9b9b9b),
                                              fontSize: 15,
                                              fontFamily: "sourcesanspro",
                                              fontWeight: FontWeight.w300),
                                          fillColor: Color(0xFFFFFFFF),
                                          filled: true,
                                          contentPadding: EdgeInsets.only(
                                              left: 20, bottom: 10, top: 12, right: 10),
                                        ),
                                      ),
                                    ),
                                  ),


                                  ///////////////// Button Section Start///////////////
                                  
                                  Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                //padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  'Back',
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    //decoration: TextDecoration.underline,
                                    fontFamily: 'MyriadPro',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                //color: Colors.red,
                              ),
                            ),

                            ///////////////// Add to cart Button  Start///////////////

                            Container(
                                decoration: BoxDecoration(
                                  color: _isLoading ? Colors.grey :Color(0xFF00CE7C),
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                ),
                                //width: 150,
                                height: 45,
                                child: FlatButton(
                                  onPressed: _isLoading ? null : _submitReview,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10, right: 10),
                                    child: Text(
                                       _isLoading ? 'Submiting...' :'Submit',
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17.0,
                                        decoration: TextDecoration.none,
                                        fontFamily: 'MyriadPro',
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  color: Colors.transparent,
                                  // elevation: 4.0,
                                  //splashColor: Colors.blueGrey,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0)),
                                )),

                            ///////////////// Add to cart Button  End///////////////
                          ],
                        ),
                      )


                                  ///////////////// Button Section End///////////////
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    ////////// Item Details end/////////
                  ],
                ),
              ),
            ),
          );
  }



  void _submitReview() async {
    if (rating == 0.0) {
      return showMsg(context, "Star rating is no given");
    } else if (reviewController.text.isEmpty) {
      return showMsg(context, "Content is empty");
    }

    setState(() {
      _isLoading = true;
    });

    var data = {
      'driverId': widget.d.driverId,
      'order_id': widget.d.id,
      'rating': rating,
      'content': reviewController.text,
      'title': "Review",
      'body': "You have a review for order ${widget.d.id}",
      'click_action': 'FLUTTER_NOTIFICATION_CLICK'
    };

    print(data);

   var res = await CallApi().postData(data, '/app/driverreviews');
   var body = json.decode(res.body);

   print(body);
   print(widget.d.id);

    if (body['success']==true) {


      _showDialog('Review given successfully');
    } else {
      _showDialog('Something is wrong');
    }

    setState(() {
      _isLoading = false;
      reviewController.text = "";
      rating = 0.0;
    });
  }





  void _showDialog(msg) {
    // flutter defined function
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              backgroundColor: Colors.white,
              content: new Text(msg,
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
                  child: new Text("Close"),
                  onPressed: () {
                    Navigator.push(
          context, new MaterialPageRoute(builder: (context) => Navigation()));
                  },
                ),
              ],
            );
          },
        );
  }
}
