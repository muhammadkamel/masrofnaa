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
    Colors.white,
    Colors.white,
    // Colors.orange.shade50,
  ],
  // begin: Alignment.topCenter,
  // end: Alignment.bottomCenter,
);
LinearGradient kHeaderColor = LinearGradient(
  colors: [
    // Colors.orange.shade100,
    // Colors.orange.shade100,
    Colors.white,
    Colors.white,
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
const kDeactiveColor = LinearGradient(
  colors: [
    Color(0xfffafafa),
    Color(0xfff9f9f9),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

const kActiveWeek = LinearGradient(
  colors: [
    Colors.purpleAccent,
    Colors.redAccent,
  ],
  // begin: Alignment.topCenter,
  // end: Alignment.bottomCenter,
);

const kRadiusMedium = Radius.circular(14);

const kText = TextStyle(
  color: Colors.blue,
  fontSize: 16,
  height: 1.7,
  fontFamily: 'AJ',
);

const kTitleStyle = TextStyle(
  color: Colors.black87,
  fontWeight: FontWeight.bold,
  fontFamily: 'AJ',
);

const kAddImgIcon = Icon(
  Icons.attach_file,
  color: Colors.blue,
  size: 20,
);

const kEditIcon = Icon(
  Icons.edit,
  color: Colors.white,
  size: 15,
);

const kDeleteIcon = Icon(
  Icons.delete,
  color: Colors.red,
  size: 15,
);

const kImageIcon = Icon(
  Icons.image,
  size: 15,
  color: Colors.black,
);

List<Color> kColors = [
  Color(0xFFE3F2FD).withOpacity(0.3),
  Color(0xFFE8F5E9).withOpacity(0.3),
];

// const String kNoPrice = 'لم يتم إضافة أي منتج';
// const String kPriceContent = 'المبلغ الإجمالي';
// const String kPriceEG = 'جنية';

const kSizedHSmall = SizedBox(height: 10);
const kSizedHMedium = SizedBox(height: 20);
const kSizedHLarge = SizedBox(height: 30);

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
