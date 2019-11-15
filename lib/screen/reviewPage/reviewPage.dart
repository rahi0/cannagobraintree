
import 'package:canna_go_dev/form/reviewForm/reviewForm.dart';
import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  final d;
  ReviewPage(this.d);
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,

      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
         //   elevation: 0,
               leading:  GestureDetector(
                onTap:(){
            //   print("object");
              Navigator.of(context).pop();
                 
             },
                                      child: Container(
        
             child: 
                
           
            Icon(Icons.arrow_back_ios, color:Color(0xFF01d56a)),
                
           ),
                  ),
            title: Text("${widget.d.item.name}", style: TextStyle( color:Color(0xFF01d56a),),),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          body: ReviewForm(widget.d)
          ),
    );
  }
}




