import 'package:advance_flutter_exam/view/order_place.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/cart_model.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double charge = 30.00;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          "Cart",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600,color: Colors.white),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 30,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.products.length,
              itemBuilder: (context, index) {
                final product = cart.products[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 80,
                    width: 200,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 3),
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      leading: Image.network(
                        product.image,
                        width: 50,
                      ),
                      title: Text(
                        product.title,
                        maxLines: 1,
                      ),
                      subtitle: Text('\$${product.price}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          cart.removeProduct(product);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
          height: 280,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 51,
                color: Colors.black38,
                spreadRadius: 4,
              )
            ],
            borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      "Selected items:",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 105),
                    child: Text(
                      '\$${(cart.totalPrice).toStringAsFixed(3)}',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      "Shipping Charge:",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 93),
                    child: Text(
                      "\$${charge}",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Divider(),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      "Total:",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 195),
                    child: Text(
                      "\$${(cart.totalPrice + charge).toStringAsFixed(3)}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(

                        title: Text('Confirm Order'),
                        content: Text('Are you sure you want to order?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel")),
                          TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return OrderPlace();
                                  },
                                ));
                              },
                              child: Text("Order"))
                        ],
                      );
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 11),
                  child: Container(
                    height: 70,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      color: Color(0xff26283C),
                    ),
                    child: Center(
                        child: Text(
                      "Order Now".toUpperCase(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    )),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
