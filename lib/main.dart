import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/shared/export.dart';

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
            return Masrofna({});
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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('ar', ''), // Arabic, no country code
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // fontFamily: 'GE',
          ),
      // home: MyHomei(),
      routes: {
        '/': (_) => ViewWeeks(),
      },
    );
  }
}
