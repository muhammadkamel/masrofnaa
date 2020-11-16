import 'package:flutter/material.dart';
import 'package:masrofnaa/ui/shared/export.dart';

class NoMoney extends StatefulWidget {
  const NoMoney({
    @required this.orientation,
    @required this.screenSize,
    @required this.providerM,
    @required this.index,
  });

  final Orientation orientation;
  final Size screenSize;
  final Masrofna providerM;
  final int index;

  @override
  _NoMoneyState createState() => _NoMoneyState();
}

class _NoMoneyState extends State<NoMoney> {
  @override
  Widget build(BuildContext context) {
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
            width: widget.orientation == Orientation.portrait
                ? (widget.index == 4
                    ? widget.screenSize.width * 0.93
                    : widget.screenSize.width * 0.45)
                : (widget.index == 4
                    ? widget.screenSize.width * 0.78
                    : widget.screenSize.width * 0.38),
            height: widget.orientation == Orientation.portrait
                ? widget.screenSize.height * 0.33
                : widget.screenSize.height * 0.60,
            margin: EdgeInsets.all(7.0),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(
              gradient: kActiveColor,
              // color: Colors.orange.shade200,
              borderRadius: BorderRadius.all(
                Radius.circular(14),
              ),
            ),
            child: Center(
              child: widget.providerM != null
                  ? Text(
                      'لا يوجد أي منتج',
                      textAlign: TextAlign.center,
                      style: kText.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: widget.orientation == Orientation.portrait
                  ? (widget.index == 4
                      ? widget.screenSize.width * 0.93
                      : widget.screenSize.width * 0.45)
                  : (widget.index == 4
                      ? widget.screenSize.width * 0.78
                      : widget.screenSize.width * 0.38),
              height: 42,
              margin: EdgeInsets.all(7.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: kRadiusMedium,
                  topLeft: kRadiusMedium,
                ),
                gradient: kHeaderColor,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.providerM.titles[widget.index]}',
                      textAlign: TextAlign.center,
                      style: kTitleStyle,
                    ),
                    Divider(
                      height: 2.5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
