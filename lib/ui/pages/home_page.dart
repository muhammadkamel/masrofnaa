import 'package:flutter/material.dart';
import 'package:masrofnaa/ui/shared/export.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  Widget _build4Weeks() {
    var providerH = context.watch<DBHelper>();
    var providerM = context.watch<Masrofna>();
    return Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        // padding: EdgeInsets.all(7.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CreateAWeek(
                  myTable: providerH.tableTwo,
                  appBarTitle: providerM.appBarTitle[1],
                  title: providerM.myList[1],
                ),
                CreateAWeek(
                  myTable: providerH.tableOne,
                  appBarTitle: providerM.appBarTitle[0],
                  title: providerM.myList[0],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CreateAWeek(
                  myTable: providerH.tableFour,
                  appBarTitle: providerM.appBarTitle[3],
                  title: providerM.myList[3],
                ),
                CreateAWeek(
                  myTable: providerH.tableThree,
                  appBarTitle: providerM.appBarTitle[2],
                  title: providerM.myList[2],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'مصروفنا',
          style: TextStyle(
            fontSize: 21,
            color: Colors.black54,
            // fontWeight: FontWeight
          ),
        ),
        elevation: 1.3,
        backgroundColor: Colors.white,
      ),
      body: _build4Weeks(),
    );
  }
}
