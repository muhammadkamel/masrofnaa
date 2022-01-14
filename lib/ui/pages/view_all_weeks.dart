import 'package:flutter/material.dart';
import '../shared/export.dart';

class ViewWeeks extends StatefulWidget {
  @override
  _ViewWeeksState createState() => _ViewWeeksState();
}

class _ViewWeeksState extends State<ViewWeeks> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  Widget _viewAllWeeks() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        // color: Colors.red,
        color: const Color(0xfff9f9f9),
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
                children: const [
                  CustomWeek(index: 1),
                  CustomWeek(index: 0),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  CustomWeek(index: 3),
                  CustomWeek(index: 2),
                ],
              ),
              const CustomWeek(index: 4),
              kSizedHMedium,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'مصروفنا',
          style: TextStyle(
            fontSize: 21,
            color: Colors.black87,
            fontFamily: 'AJ',
          ),
        ),
        elevation: 0.3,
        backgroundColor: Colors.white,
        leading: const Text(''),
      ),
      body: _viewAllWeeks(),
    );
  }
}
