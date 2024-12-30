import 'package:flutter/material.dart';
import 'package:vaayu_chatbot/utils/Routes/RouteNames.dart';
import 'package:vaayu_chatbot/view/home_screen.dart';
import 'package:vaayu_chatbot/view/splash_screen.dart';

class Routes{

  static Route<dynamic> generateRoutes(RouteSettings setting){
    switch(setting.name){
      case RouteNames.splashscreen:
         return MaterialPageRoute(builder: (context)=>SplashScreen());

      case RouteNames.homescreen:
         return MaterialPageRoute(builder: (context)=>HomeScreen());   

      default:
         return MaterialPageRoute(builder: (context){
            return Scaffold(
              body: Center(child: Text("No Route Found")),
            );
         });   
    }
  }
}