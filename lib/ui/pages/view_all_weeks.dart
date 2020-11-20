import 'package:flutter/material.dart';
import 'package:masrofnaa/ui/shared/export.dart';

class ViewWeeks extends StatefulWidget {
  @override
  _ViewWeeksState createState() => _ViewWeeksState();
}

class _ViewWeeksState extends State<ViewWeeks> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  Widget _viewAllWeeks() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        // color: Colors.red,
        color: Color(0xfff9f9f9),
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              kSizedHMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomWeek(index: 1),
                  CustomWeek(index: 0),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomWeek(index: 3),
                  CustomWeek(index: 2),
                ],
              ),
              CustomWeek(index: 4),
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
          elevation: 0.3,
          backgroundColor: Colors.white,
          leading: Text(''),
        ),
        body: _viewAllWeeks(),
      ),
    );
  }
}
