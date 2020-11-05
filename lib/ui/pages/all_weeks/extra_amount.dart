import 'package:flutter/material.dart';
import 'package:masrofnaa/ui/shared/export.dart';

class ExtraAmount extends StatefulWidget {
  @override
  _ExtraAmountState createState() => _ExtraAmountState();
}

class _ExtraAmountState extends State<ExtraAmount> {
  @override
  Widget build(BuildContext context) {
    double marginH = 14.0;
    Size screenSize = MediaQuery.of(context).size;
    var orientation = MediaQuery.of(context).orientation;
    return Align(
      alignment: Alignment.center,
      child: Container(
        // color: Colors.red,
        child: Stack(
          children: [
            Container(
              width: orientation == Orientation.portrait
                  ? screenSize.width - marginH
                  : screenSize.width * 0.80,
              height: 200,
              margin: EdgeInsets.symmetric(horizontal: marginH, vertical: 7.0),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  width: 3,
                  color: Colors.grey.shade50,
                ),
              ),
              child: Center(
                child: Text(
                  'ABC',
                  textAlign: TextAlign.center,
                  style: kText,
                ),
              ),
            ),
            Positioned(
              top: 3,
              right: 3,
              left: 3,
              child: Container(
                alignment: Alignment.center,
                width: (screenSize.width - marginH) - 50,
                height: 50.0,
                margin:
                    EdgeInsets.symmetric(horizontal: marginH, vertical: 7.0),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    'منتجات إضافية',
                    style: kText,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
