import 'dart:async';

import 'package:advance_flutter_exam/view/order_sucessfully.dart';
import 'package:flutter/material.dart';

class OrderPlace extends StatefulWidget {
  const OrderPlace({super.key});

  @override
  State<OrderPlace> createState() => _OrderPlaceState();
}

class _OrderPlaceState extends State<OrderPlace> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 5),
          () {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return OrderSuccess();
          },
        ));
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/order-unscreen.gif"),
            Text(
              "Ordering...",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 400,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50,
                    width: 160,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel"),
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50,
                    width: 160,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                          return OrderSuccess();
                        },));
                      },
                      child: Text("Ok"),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
