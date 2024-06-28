import 'package:advance_flutter_exam/view/cart_page.dart';
import 'package:advance_flutter_exam/view/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/api_service.dart';
import '../model/product_model.dart';

class Ecommerce extends StatefulWidget {
  const Ecommerce({super.key});

  @override
  State<Ecommerce> createState() => _EcommerceState();
}

class _EcommerceState extends State<Ecommerce> {
  List<Product> products = [];
  List<Product> filteredProducts = [];
  String selectedCategory = 'All';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SharedPreferences.getInstance().then((value) {
      var themeMode = value.getInt("themeMode");
      Provider.of<ThemeProvider>(context, listen: false)
          .changeTheme(themeMode ?? 0);
    });
  }

  Future<void> fetchProducts() async {
    try {
      List<Product> fetchedProducts = await ApiService.fetchProducts();
      setState(() {
        products = fetchedProducts;
        filteredProducts = products;
        isLoading = false;
      });
    } catch (error) {
      print("Error fetching products: $error");
      setState(() {
        isLoading = false;
      });
    }
  }

  void filterProducts(String category) {
    print('Selected Category: $category');
    setState(() {
      selectedCategory = category;
      if (category == 'All') {
        filteredProducts = products;
      } else {
        filteredProducts = products.where((product) {
          return product.category.toLowerCase() == category.toLowerCase();
        }).toList();
      }
      print('Filtered Products Count: ${filteredProducts.length}');
    });
  }

  void navigateToProductDetails(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetails(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('E-commerce App', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          DropdownButton<String>(
            iconEnabledColor: Colors.white,
            dropdownColor: Colors.black,
            value: selectedCategory,
            onChanged: (String? newValue) {
              if (newValue != null) {
                filterProducts(newValue);
              }
            },
            items: [
              'All',
              'Electronics',
              'Jewelery',
              'Men\'s clothing',
              'Women\'s clothing'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(color: Colors.white)),
              );
            }).toList(),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff243C98),
                    Colors.black,
                  ],
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                        "assets/images/ecommerce_logo-removebg-preview.png"),
                  ),
                  Text(
                    'Harsh',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text("E-commerce App", style: TextStyle(color: Colors.white))
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("App of online shopping"),
                      content: Text(
                          '=> Introducing Harsh Vasoya innovative e-commerce application, crafted with Flutter expertise! This dynamic platform seamlessly integrates cutting-edge technology with a user-friendly interface, designed to elevate your shopping experience to new heights \n\n=> Powered by APIs, this app delivers real-time data, ensuring that you have access to the latest products, prices, and information. The sleek and captivating UI is a testament to Harsh Vasoya dedication to creating visually stunning applications that are as delightful to use as they are functional.'),
                    );
                  },
                );
              },
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<ThemeProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  return Row(
                    children: [
                      SizedBox(width: 10),
                      Icon(Icons.ac_unit),
                      SizedBox(width: 10),
                      Text(
                        " Theme :",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(width: 30),
                      DropdownButton(
                        dropdownColor: Colors.black38,
                        value: value.themeMode,
                        items: [
                          DropdownMenuItem(child: Text("System"), value: 0),
                          DropdownMenuItem(child: Text("Light"), value: 1),
                          DropdownMenuItem(child: Text("Dark"), value: 2),
                        ],
                        onChanged: (value) async {
                          var instance = await SharedPreferences.getInstance();
                          instance.setInt("themeMode", value ?? 0);

                          Provider.of<ThemeProvider>(context, listen: false)
                              .changeTheme(value ?? 0);
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            Divider(),
            SizedBox(height: 80),
            Image.asset("assets/images/shopping-unscreen.gif",
                width: 250, height: 250),
            SizedBox(height: 70),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Exit'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : filteredProducts.isEmpty
              ? Center(child: Text('No products found'))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return GestureDetector(
                        onTap: () => navigateToProductDetails(product),
                        child: Card(
                          elevation: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Image.network(
                                  product.image,
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  product.title,
                                  style: TextStyle(fontSize: 16),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  '\$${product.price}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_cart_checkout),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CartPage();
          },));
        },
      ),
    );
  }
}
