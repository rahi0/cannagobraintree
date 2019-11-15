import 'dart:convert';
import 'package:canna_go_dev/form/profileEditForm/profileEditform.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileEditPage extends StatelessWidget {
 final userData;
 final cannagoData;
  ProfileEditPage(this.userData, this.cannagoData);


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
        //backgroundColor: Colors.grey[200],
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
          'Edit Profile',
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
        
       
        body: SafeArea(
                  child: ProfileEditForm(userData, cannagoData)
        ),
     
      
    );
  }
}
