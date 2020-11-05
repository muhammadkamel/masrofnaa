import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const kLinearColors = LinearGradient(
  colors: [
    Colors.purpleAccent,
    Colors.indigoAccent,
  ],
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
);

LinearGradient kActiveColor = LinearGradient(
  colors: [
    Colors.grey.shade50,
    // Colors.orange.shade50,
    Colors.grey.shade50,
  ],
  // begin: Alignment.topCenter,
  // end: Alignment.bottomCenter,
);
LinearGradient kHeaderColor = LinearGradient(
  colors: [
    Colors.orange.shade100,
    Colors.orange.shade100,
  ],
);
const kDeactiveColor = LinearGradient(
  colors: [
    Color(0xfffafafa),
    Color(0xfff9f9f9),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

const kRadiusMedium = Radius.circular(14);

const kText = TextStyle(
  color: Colors.blue,
  fontSize: 16,
  height: 1.7,
  fontFamily: 'AJ',
);

const kDeleteIcon = Icon(
  Icons.delete,
  color: Colors.red,
  size: 15,
);

const kEditIcon = Icon(
  Icons.edit,
  color: Colors.white,
  size: 15,
);

List<Color> kColors = [
  Color(0xFFE3F2FD).withOpacity(0.3),
  Color(0xFFE8F5E9).withOpacity(0.3),
];

const String kNoPrice = 'لم يتم إضافة أي منتج';
const String kPriceContent = 'المبلغ الإجمالي';
const String kPriceEG = 'جنية';

final kInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 17),
  hintStyle: TextStyle(
    fontSize: 16,
    fontFamily: 'Montserrat',
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(100.0),
    borderSide: BorderSide(
      width: 2,
      color: Colors.blue,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(100.0),
    borderSide: BorderSide(
      width: 2,
      color: Colors.blue,
    ),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(100.0),
    borderSide: BorderSide(
      width: 2,
      color: Colors.green,
    ),
  ),
);

List<TextInputFormatter> kInputNoFormats = [
  FilteringTextInputFormatter.allow(
    RegExp('[0-9, .]'),
  ),
  FilteringTextInputFormatter.deny(
    new RegExp(r"\s\b|\b\s"),
  ),
];
