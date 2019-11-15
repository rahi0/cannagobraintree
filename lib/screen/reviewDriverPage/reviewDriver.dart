

import 'package:canna_go_dev/form/reviewDriverForm/reviewDriverForm.dart';
import 'package:flutter/material.dart';

class ReviewDriverPage extends StatefulWidget {
  final d;
  ReviewDriverPage(this.d); 
  @override
  _ReviewDriverPageState createState() => _ReviewDriverPageState();
}

class _ReviewDriverPageState extends State<ReviewDriverPage> {
  
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
           // elevation: 0,
           automaticallyImplyLeading: false,
           leading: GestureDetector(
                onTap:(){
            //   print("object");
              Navigator.of(context).pop();
                 
             },
                                      child: Container(
        
             child: 
                
           
            Icon(Icons.arrow_back_ios, color:Color(0xFF01d56a)),
                
           ),
                  ),
            title: Text(
              "${widget.d.driver.user.name}",style: TextStyle( color:Color(0xFF01d56a)),
              ),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          body: DriverReviewForm(widget.d)
          ),
    );
  }

}




///////


