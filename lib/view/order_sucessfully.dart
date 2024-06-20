import 'dart:async';

import 'package:advance_flutter_exam/view/home_page.dart';
import 'package:flutter/material.dart';

class OrderSuccess extends StatefulWidget {
  const OrderSuccess({super.key});

  @override
  State<OrderSuccess> createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 5),
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
      backgroundColor: Color(0xff1C79AC),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(child: Image.asset("assets/images/basket.gif")),
            SizedBox(
              height: 30,
            ),
            Text(
              "Thank You!!".toUpperCase(),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 45,
                  fontStyle: FontStyle.italic),
            ),
            Text(
              "Your Order has been \nsuccessfully placed!",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
