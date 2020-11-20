import 'package:flutter/material.dart';
import 'package:masrofnaa/ui/shared/export.dart';

class CustomView extends StatefulWidget {
  CustomView({this.snapshot, @required this.index, this.child});
  final Masrofna snapshot;
  final int index;
  final Widget child;
  @override
  _CustomViewState createState() => _CustomViewState();
}

class _CustomViewState extends State<CustomView> {
  @override
  Widget build(BuildContext context) {
    return _buildViewer(context);
  }

  Widget _buildViewer(BuildContext context) {
    var headerTitle =
        context.select((Masrofna value) => value.headerTitle[widget.index]);
    var screenSize = MediaQuery.of(context).size;
    var orientation = MediaQuery.of(context).orientation;
    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => ViewMasrofna(index: widget.index),
              ),
              (route) => false);
        });
      },
      child: Stack(
        children: [
          Container(
            width: orientation == Orientation.portrait
                ? (widget.index == 4
                    ? screenSize.width * 0.83
                    : screenSize.width * 0.40)
                : (widget.index == 4
                    ? screenSize.width * 0.78
                    : screenSize.width * 0.30),
            height: orientation == Orientation.portrait
                ? screenSize.height * 0.25
                : screenSize.height * 0.45,
            margin: EdgeInsets.all(7.0),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(kRadiusMedium),
              boxShadow: [
                BoxShadow(
                  color: Color(0xffEBEBEB),
                  offset: Offset.zero,
                )
              ],
            ),
            child: widget.snapshot != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Text column
                      Container(
                        // color: Colors.greenAccent,

                        child: Center(
                          child: Text(
                            'إجمالي المبلغ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color(0xff707070),
                              fontFamily: 'AJ',
                            ),
                          ),
                        ),
                      ),

                      kSizedHSmall,

                      // Text column

                      Container(
                        // color: Colors.greenAccent,
                        child: Center(
                          child: Text(
                            '${widget.snapshot.weekMoney}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                              color: Color(0xff707070),
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: widget.child,
                  ),
          ),
          Positioned(
            top: 20,
            right: 0,
            left: 0,
            child: Text(
              '$headerTitle',
              textAlign: TextAlign.center,
              style: kTitleStyle,
            ),
          ),
          // Arrow forward
          Positioned(
            bottom: 25,
            right: 0,
            left: 0,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
