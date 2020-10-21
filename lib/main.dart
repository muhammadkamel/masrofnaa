import 'package:flutter/material.dart';
import 'package:masrofnaa/ui/shared/export.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            return DBHelper();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return Masrofna();
          },
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'GE',
      ),
      // home: HomePage(),
      routes: {
        '/': (_) => HomePage(),
      },
    );
  }
}
