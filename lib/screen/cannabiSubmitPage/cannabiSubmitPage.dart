import 'package:canna_go_dev/form/cannaBiSubmitForm/cannabiSubmitForm.dart';
import 'package:flutter/material.dart';

class CannabiSubmitPage extends StatelessWidget {
//  final userData;
//  final cannagoData;
//   CannabiEditPage(this.userData, this.cannagoData);


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
          'Submit Cannabis License',
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
        
      //  resizeToAvoidBottomPadding: false,
        body: SafeArea(
                  child: CannabisSubmitForm()
        ),
     
      
    );
  }
}