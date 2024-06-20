import 'package:flutter/material.dart';
import 'package:advance_flutter_exam/view/home_page.dart';
import 'package:advance_flutter_exam/view/splash_screen.dart';
import 'package:provider/provider.dart';
import 'controller/theme_provider.dart';
import 'model/cart_model.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => CartModel()),
      ],
      builder: (context, child) {
        return Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              themeMode: themeProvider.getThemeMode(),
              home: splashscreen(),
            );
          },
        );
      },
    );
  }
}
