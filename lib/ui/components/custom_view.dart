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
    // var providerM = context.read<Masrofna>();
    var providerM =
        context.select((Masrofna value) => value.titles[widget.index]);
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
                    ? screenSize.width * 0.93
                    : screenSize.width * 0.45)
                : (widget.index == 4
                    ? screenSize.width * 0.78
                    : screenSize.width * 0.38),
            height: orientation == Orientation.portrait
                ? screenSize.height * 0.33
                : screenSize.height * 0.60,
            margin: EdgeInsets.all(7.0),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              gradient: kActiveColor,
              borderRadius: BorderRadius.circular(14),
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
                            style: kText.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
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
                            style: kText.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
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
            top: 0,
            child: Container(
              width: orientation == Orientation.portrait
                  ? (widget.index == 4
                      ? screenSize.width * 0.93
                      : screenSize.width * 0.45)
                  : (widget.index == 4
                      ? screenSize.width * 0.78
                      : screenSize.width * 0.38),
              height: 42,
              margin: EdgeInsets.all(7.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(14),
                  topLeft: Radius.circular(14),
                ),
                // gradient: kHeaderColor,
                // color: Colors.greenAccent,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$providerM',
                      textAlign: TextAlign.center,
                      style: kTitleStyle,
                    ),
                    Divider(
                      height: 2.5,
                    ),
                    // Container(
                    //   width: 200,
                    //   height: 1.7,
                    //   decoration: BoxDecoration(
                    //     gradient: kActiveWeek,
                    //     // color: Colors.purpleAccent,
                    //     // borderRadius: BorderRadius.circular(7.0),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            child: Container(
              width: orientation == Orientation.portrait
                  ? (widget.index == 4
                      ? screenSize.width * 0.93
                      : screenSize.width * 0.45)
                  : (widget.index == 4
                      ? screenSize.width * 0.78
                      : screenSize.width * 0.38),
              height: 42,
              margin: EdgeInsets.all(7.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                // gradient: kHeaderColor,
                // color: Colors.red,
              ),
              child: Image(
                image: AssetImage('images/dollar.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
