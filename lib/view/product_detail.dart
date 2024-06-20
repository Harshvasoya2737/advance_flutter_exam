import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/product_model.dart';
import '../model/cart_model.dart';
import 'cart_page.dart';

class ProductDetails extends StatefulWidget {
  final Product product;

  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Product Detail",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.deepPurple,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Center(
                child: Image.network(
                  widget.product.image,
                  height: 300,
                  width: 300,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xff191E39),
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(100)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      Text(
                        widget.product.title,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        '\$${widget.product.price}',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(width: 12),
                            Icon(
                              Icons.high_quality,
                              color: Colors.white,
                              size: 50,
                            ),
                            SizedBox(width: 62),
                            Icon(
                              Icons.waves,
                              color: Colors.white,
                              size: 50,
                            ),
                            SizedBox(width: 55),
                            Icon(
                              Icons.check_box,
                              color: Colors.white,
                              size: 50,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "High Quality",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(width: 55),
                            Text(
                              "Pure",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(width: 65),
                            Text(
                              "Original",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.product.description,
                          maxLines: 3,
                          style: TextStyle(fontSize: 13, color: Colors.green),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<CartModel>(context, listen: false)
                                .addProduct(widget.product);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartPage()),
                            );
                          },
                          child: Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Add to Cart",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
