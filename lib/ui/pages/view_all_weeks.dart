import 'package:flutter/material.dart';
import 'package:masrofnaa/ui/shared/export.dart';

class ViewAllMasrofs extends StatefulWidget {
  @override
  _ViewAllMasrofsState createState() => _ViewAllMasrofsState();
}

class _ViewAllMasrofsState extends State<ViewAllMasrofs> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  Widget _buildAllWeeks() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          // padding: EdgeInsets.all(7.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              kSizedHMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SecondWeek(),
                  FirstWeek(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FourthWeek(),
                  ThirdWeek(),
                ],
              ),
              ExtraAmount(),
              kSizedHMedium,
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              // title: Text('Confirm'),
              content: Text(
                'هل تريد حقًا الخروج من البرنامج؟',
                style: TextStyle(),
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('لا'),
                  onPressed: () {
                    Navigator.of(context).pop(false); //Will not exit the App
                  },
                ),
                FlatButton(
                  child: Text('نعم'),
                  onPressed: () {
                    Navigator.of(context).pop(true); //Will exit the App
                  },
                )
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'مصروفنا',
            style: TextStyle(
              fontSize: 21,
              color: Colors.black87,
              fontFamily: 'AJ',
            ),
          ),
          elevation: 1.3,
          backgroundColor: Colors.white,
          leading: Text(''),
        ),
        body: _buildAllWeeks(),
      ),
    );
  }
}
