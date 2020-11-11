import 'package:flutter/material.dart';

class Masrofna with ChangeNotifier {
  // Fields
  int _id;
  String _product;
  double _price;
  double _noItems;
  double _total;
  double _weekMoney;
  String _img;

  List<String> titles = [
    'الأول',
    'الثاني',
    'الثالث',
    'الرابع',
    'إضافات',
  ];

  List<String> headerTitle = [
    'الإسبوع الأول',
    'الإسبوع الثاني',
    'الإسبوع الثالث',
    'الإسبوع الربع',
    'منتجات إضافية',
  ];

  List<String> tables = [
    'tableOne',
    'tableTwo',
    'tableThree',
    'tableFour',
    'tableExtra',
  ];

  // Named Constructor
  Masrofna.fromMyMap(Map<String, dynamic> myData) {
    _id = myData['id'];
    _product = myData['product'];
    _price = myData['price'];
    _noItems = myData['noItems'];
    _total = myData['total'];
    _weekMoney = myData['weekMoney'];
    _img = myData['img'];
  }

  // Getter
  int get id => _id;
  String get product => _product;
  double get price => _price;
  double get noItems => _noItems;
  double get total => _total;
  double get weekMoney => _weekMoney;
  String get img => _img;

  // Methods
  masronfa(Map<String, dynamic> objec) async {
    notifyListeners();
    _id = await objec['id'];
    _product = await objec['product'];
    _price = await objec['price'];
    _noItems = await objec['noItems'];
    _total = await objec['total'];
    _weekMoney = await objec['weekMoney'];
    _img = await objec['img'];
  }

  // Constructor
  Masrofna(dynamic objec) {
    notifyListeners();
    _id = objec['id'];
    _product = objec['product'];
    _price = objec['price'];
    _noItems = objec['noItems'];
    _total = objec['total'];
    _weekMoney = objec['weekMoney'];
    _img = objec['img'];
  }

  Map<String, dynamic> convertToMap() {
    notifyListeners();
    return {
      'id': _id,
      'product': _product,
      'price': _price,
      'noItems': _noItems,
      'total': _total,
      'weekMoney': _weekMoney,
      'img': _img,
    };
  }

  notifyListeners();
}
