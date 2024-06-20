import 'dart:async';
import 'package:advance_flutter_exam/view/home_page.dart';
import 'package:flutter/material.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return Ecommerce();
          },
        ));
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              child: Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white60,
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 130,
                    width: 100,
                  ),
                  Image.asset(
                    'assets/images/ecommerce_logo-removebg-preview.png',
                    height: 300,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(150),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
