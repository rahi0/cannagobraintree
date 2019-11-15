
import 'package:canna_go_dev/form/cannabiEditForm/cannabiEditForm.dart';
import 'package:flutter/material.dart';


class CannabiEditPage extends StatelessWidget {
 final userData;
 final cannagoData;
  CannabiEditPage(this.userData, this.cannagoData);


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        //backgroundColor: Colors.grey[200],
           backgroundColor: Colors.white,
         appBar: AppBar(
        //elevation: 0,
        automaticallyImplyLeading: false,
              leading: Builder(
    builder: (BuildContext context) {
      return IconButton(
        icon: const Icon(Icons.arrow_back_ios,color:Color(0xFF01d56a),),
        onPressed: () { 
          Navigator.of(context).pop();
        },
       
      );
    },
  ), 
        title: Text(
          'Edit License',
          style: TextStyle(
          color:Color(0xFF01d56a),
            //fontSize: 21.0,
            fontWeight: FontWeight.normal,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.white,
       // centerTitle: true,
      ),
        
       
        body: SafeArea(
                  child: CannabiEditForm(userData, cannagoData)
        ),
     
      
    );
  }
}


//////



