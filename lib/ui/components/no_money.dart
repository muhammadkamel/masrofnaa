import 'package:flutter/material.dart';

import '../shared/export.dart';

class NoMoney extends StatefulWidget {
  const NoMoney({
    required this.orientation,
    required this.screenSize,
    required this.headerTitle,
    required this.index,
  });

  final Orientation orientation;
  final Size screenSize;
  final Masrofna headerTitle;
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
                builder: (_) => ViewMasrofna(
                  index: widget.index,
                  imgs: '',
                ),
              ),
              (route) => false);
        });
      },
      child: Stack(
        children: [
          Container(
            width: widget.orientation == Orientation.portrait
                ? (widget.index == 4
                    ? widget.screenSize.width * 0.83
                    : widget.screenSize.width * 0.40)
                : (widget.index == 4
                    ? widget.screenSize.width * 0.63
                    : widget.screenSize.width * 0.30),
            height: widget.orientation == Orientation.portrait
                ? widget.screenSize.height * 0.25
                : widget.screenSize.height * 0.45,
            margin: const EdgeInsets.all(7.0),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(kRadiusMedium),
              boxShadow: [
                BoxShadow(
                  color: Color(0xffEBEBEB),
                  offset: Offset.zero,
                )
              ],
            ),
            child: Center(
              child: Text(
                'لا يوجد أي منتج',
                textAlign: TextAlign.center,
                style: kText.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
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
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 15,
                ),
              ),
            ),
          ),

          Positioned(
            top: 20,
            right: 0,
            left: 0,
            child: Text(
              widget.headerTitle.headerTitle[widget.index],
              textAlign: TextAlign.center,
              style: kTitleStyle,
            ),
          ),
        ],
      ),
    );
  }
}
