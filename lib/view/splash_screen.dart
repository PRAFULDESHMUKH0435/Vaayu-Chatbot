import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/Routes/routenames.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 7),(){
         Navigator.pushReplacementNamed(context,RouteNames.homescreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Lottie.asset("assets/lottie/loading.json")),
      ),
    );
  }
}


