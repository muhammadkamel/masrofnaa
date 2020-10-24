import 'package:flutter/material.dart';

const kLinearColors = LinearGradient(
  colors: [
    Colors.purpleAccent,
    Colors.indigoAccent,
  ],
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  // tileMode: TileMode.repeated,
  // stops: [5, 0],
);

const kText = TextStyle(
  color: Colors.blue,
  fontSize: 18,
  height: 1.7,
  fontFamily: 'GE',
);

const kDeleteIcon = Icon(
  Icons.delete,
  color: Colors.red,
  size: 18,
);

const kEditIcon = Icon(
  Icons.edit,
  color: Colors.white,
  size: 18,
);

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
