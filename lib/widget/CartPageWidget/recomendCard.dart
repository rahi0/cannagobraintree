import 'package:canna_go_dev/customPlugin/routeTransition/routeAnimation.dart';
import 'package:canna_go_dev/screen/itemPage/itemPage.dart';
import 'package:flutter/material.dart';


class RecomendedCard extends StatelessWidget {
  final item;
  RecomendedCard(this.item);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, SlideLeftRoute(page: ItemPage(item)));
      },
          child: Container(    
             margin: EdgeInsets.only(top: 10,left: 6,bottom: 5),
                      decoration: BoxDecoration(
                                     color: Color(0xFFFFFFFF),
                                    borderRadius: BorderRadius.circular(10),
                                      boxShadow:[
                             BoxShadow(color:Colors.grey[300],
                             blurRadius: 17,
                              //offset: Offset(0.0,3.0)
                              )
                           
                           ], 
                                  ),
                         child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                        
                            
                      Container(
                      
                                          width: 80,
                                          height: 80,
                                       
                                          decoration: new BoxDecoration(
                                            color: Colors.white,
                                         // shape: BoxShape.circle,
                      
                                       image: new DecorationImage(
                                        fit: BoxFit.cover,
                                        
                                        image:item.img==null? new AssetImage("assets/img/medicine_icon.PNG"):NetworkImage("https://www.dynamyk.biz"+item.img),
                                        
                                    )
                              )
                           ),
                                       Container(
                                         alignment: Alignment.center,
                                           padding: EdgeInsets.only(top: 10),
                                          //color: Colors.red,
                                          width: 95,
                                          //height: 95,
                                        //  padding: EdgeInsets.only(left: 8),
                                          child: Text.rich(
                            TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: "\$ ${(item.price).toStringAsFixed(2)}",
                                style: TextStyle(
                             color: Color(0xFF00bb5d),
                              fontFamily: "sourcesanspro",
                              fontSize: 15,
                              fontWeight: FontWeight.bold      
                                    ),
                              ),
                              // TextSpan(
                              //   text: ".55",
                              //   style: TextStyle(
                              // color: Color(0xFF01D56A),
                              // fontFamily: "sourcesanspro",
                              // fontSize: 11,
                              // fontWeight: FontWeight.w400       
                              //       ),
                              // ),
                            ] ),
                          ),
                                        ),

                                      Container(    
                  width: 95,
                 //color: Colors.red,
                  margin: EdgeInsets.only(top: 3),
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Text(
                          "${item.name}",
                           textAlign: TextAlign.center,
                           overflow: TextOverflow.ellipsis,
                           style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily:"sourcesanspro",
                              fontSize: 13,
                              fontWeight: FontWeight.w600      
                                    ),
                               ),
                            ),

                //       Container(    
                //   width: 95,
                //  //color: Colors.blue,
                //   margin: EdgeInsets.only(top: 3),
                //   padding: EdgeInsets.only(left: 3, right: 3),
                //   child: Text(
                //           "900v",
                //            textAlign: TextAlign.center,
                //            overflow: TextOverflow.ellipsis,
                //            style: TextStyle(
                //               color: Color(0xFF000000),
                //               fontFamily:"sourcesanspro",
                //               fontSize: 11,
                //               fontWeight: FontWeight.w400       
                //                     ),
                //                ),
                //             ),
                                      ],
                                    ),
                                      ),
    );
  }
}