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

const kActiveColor = LinearGradient(
  colors: [
    // Color(0xffF2635E),
    // Color(0xffED2148),
    Color(0xFFECEFF1),
    Color(0xFFECEFF1),
    // Colors.orange.shade50,
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
const kHeaderColor = LinearGradient(
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

const kRadiusMedium = Radius.circular(22);

const kText = TextStyle(
  color: Color(0xff707070),
  fontSize: 16,
  height: 1.7,
  fontFamily: 'AJ',
);

const kTitleStyle = TextStyle(
  color: Color(0xff9A9A9A),
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
  const Color(0xFFE3F2FD).withOpacity(0.3),
  const Color(0xFFE8F5E9).withOpacity(0.3),
];

// const String kNoPrice = 'لم يتم إضافة أي منتج';
// const String kPriceContent = 'المبلغ الإجمالي';
// const String kPriceEG = 'جنية';

const kSizedHSmall = SizedBox(height: 10);
const kSizedHMedium = SizedBox(height: 20);
const kSizedHLarge = SizedBox(height: 30);

final kInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
  hintStyle: const TextStyle(
    fontSize: 16,
    fontFamily: 'Montserrat',
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(100.0),
    borderSide: const BorderSide(
      width: 2,
      color: Colors.blue,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(100.0),
    borderSide: const BorderSide(
      width: 2,
      color: Colors.blue,
    ),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(100.0),
    borderSide: const BorderSide(
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
    RegExp(r"\s\b|\b\s"),
  ),
];
