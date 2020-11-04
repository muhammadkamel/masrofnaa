import 'package:flutter/material.dart';
import 'package:masrofnaa/ui/shared/export.dart';

class ViewAllMasrofs extends StatefulWidget {
  @override
  _ViewAllMasrofsState createState() => _ViewAllMasrofsState();
}

class _ViewAllMasrofsState extends State<ViewAllMasrofs> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildAllWeeks() {
    return Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        // padding: EdgeInsets.all(7.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 7.0),
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
              children: [],
            ),
            SizedBox(
              height: 15,
            ),
            ExtraAmount(),
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
      body: _buildAllWeeks(),
    );
  }
}
