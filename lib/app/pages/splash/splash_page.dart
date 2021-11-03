import 'package:engeselt_teste/app/pages/home/home_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((value) =>
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage())));
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  transform: GradientRotation(1.666 / 8),
                  begin: Alignment.topCenter,
                  end: Alignment.bottomLeft,
                  colors: [Color(0xFF274B74), Color(0xFF00A98F)])),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(100.0),
              child: Image.asset('assets/logo.png'),
            ),
          )),
    );
  }
}
