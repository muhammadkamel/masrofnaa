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
    var providerTablesList = context.watch<DBHelper>();
    var providerList = context.watch<Masrofna>();
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
                  myTable: providerTablesList.tableTwo,
                  appBarTitle: providerList.appBarTitle[1],
                  title: providerList.myList[1],
                ),
                CreateAWeek(
                  myTable: providerTablesList.tableOne,
                  appBarTitle: providerList.appBarTitle[0],
                  title: providerList.myList[0],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CreateAWeek(
                  myTable: providerTablesList.tableFour,
                  appBarTitle: providerList.appBarTitle[3],
                  title: providerList.myList[3],
                ),
                CreateAWeek(
                  myTable: providerTablesList.tableThree,
                  appBarTitle: providerList.appBarTitle[2],
                  title: providerList.myList[2],
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
