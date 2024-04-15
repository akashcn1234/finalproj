

import 'package:flutter/material.dart';

Color KmainColor = Colors.white;
Color KButtonColor =   Color(0xff50aafa);
Color KtextColor = Colors.black;
Color kFieldBoarderColor = Colors.grey;



const baseUrl ='https://medicine-management-systems-backend.onrender.com';
    // 'https://medicine-management-systems.onrender.com';


const indicator =  Center(
            child: CircularProgressIndicator(color: Colors.teal,),
          );


customSnackBar({
  required BuildContext context,
  required String  messsage,
}){

  return ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(messsage)));
}