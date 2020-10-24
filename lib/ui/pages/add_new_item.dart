import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masrofnaa/ui/pages/view_added_items.dart';
import 'package:masrofnaa/ui/shared/export.dart';

class AddNewMasrof extends StatefulWidget {
  AddNewMasrof({
    @required this.myTable,
    @required this.tableTitle,
    @required this.appBarTitle,
  });
  final String myTable;
  final String tableTitle;
  final String appBarTitle;

  @override
  _AddNewMasrofState createState() => _AddNewMasrofState();
}

class _AddNewMasrofState extends State<AddNewMasrof> {
  String product;
  double price, noItems, weekMoney;
  DateTime date;
  var focus;
  final _productController = TextEditingController();
  final _priceController = TextEditingController();
  final _noItemsController = TextEditingController();

  bool isNumber = true;
  @override
  void initState() {
    super.initState();
    focus = FocusNode();
    _productController.addListener(() {
      _productController.value = _productController.value.copyWith(
        text: _productController.text,
        selection: TextSelection.fromPosition(
          TextPosition(
            offset: _productController.text.length,
          ),
        ),
      );
    });
    _priceController.addListener(() {
      _priceController.value = _priceController.value.copyWith(
        text: _priceController.text,
        selection: TextSelection.fromPosition(
          TextPosition(
            offset: _priceController.text.length,
          ),
        ),
      );
    });
    _noItemsController.addListener(() {
      _noItemsController.value = _noItemsController.value.copyWith(
        text: _noItemsController.text,
        selection: TextSelection.fromPosition(
          TextPosition(
            offset: _noItemsController.text.length,
          ),
        ),
      );
    });
  }

  clearText() {
    setState(() {
      _productController.buildTextSpan(
        style: TextStyle(
          color: Colors.greenAccent,
        ),
      );
    });
  }

  @override
  void dispose() {
    _productController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var helperProvider = context.watch<DBHelper>();

    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'إضافة مصروف',
            style: kText,
          ),
          backgroundColor: Colors.white,
          elevation: 3.0,
          actions: [
            Align(
              alignment: Alignment.center,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.grey[600],
                ),
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ViewMasrofna(
                          myTable: widget.myTable,
                          tableTitle: widget.tableTitle,
                          appBarTitle: widget.appBarTitle,
                        ),
                      ),
                    );
                  });
                },
              ),
            ),
          ],
          // leading:
        ),
        body: SingleChildScrollView(
          child: Container(
            height: screenSize.height,
            // color: Colors.red,
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  // Name input form
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (val) {
                        try {
                          if (val.isEmpty) {
                            return "Please enter the number";
                          } else {
                            return null;
                          }
                        } catch (e) {
                          return 'TTTT';
                        }
                      },
                      controller: _productController,
                      autofocus: true,
                      onChanged: (val) {
                        setState(() {
                          product = val;
                        });
                      },
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'GE',
                      ),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      decoration: kInputDecoration.copyWith(
                        hintText: 'إسم المنتج',
                        alignLabelWithHint: true,
                        hintStyle: TextStyle(
                          fontFamily: 'GE',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // Content input form
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Directionality(
                      textDirection:
                          isNumber ? TextDirection.ltr : TextDirection.rtl,
                      child: TextFormField(
                        onFieldSubmitted: (val) {
                          setState(() {
                            isNumber = false;
                            print(val);
                          });
                        },
                        onEditingComplete: () {
                          setState(() {
                            isNumber = false;
                            print('Done');
                          });
                        },
                        validator: (val) {
                          try {
                            if (val.isEmpty) {
                              return "Please enter the number";
                            } else {
                              return null;
                            }
                          } catch (e) {
                            return 'TTTT';
                          }
                        },
                        enableInteractiveSelection: false,
                        controller: _priceController,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                        ),
                        focusNode: focus,
                        onChanged: (val) {
                          setState(() {
                            price = double.parse(val);
                          });
                        },
                        // textAlign: TextAlign.right,
                        inputFormatters: kInputNoFormats,
                        keyboardType: TextInputType.number,
                        decoration: kInputDecoration.copyWith(
                          hintText: 'السعر',
                          hintStyle: TextStyle(
                            fontFamily: 'GE',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // Level
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (val) {
                        try {
                          if (val.isEmpty) {
                            return "Please enter the number";
                          } else {
                            return null;
                          }
                        } catch (e) {
                          return 'TTTT';
                        }
                      },
                      controller: _noItemsController,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                      ),
                      onChanged: (val) {
                        setState(() {
                          noItems = double.parse(val);
                        });
                      },
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.right,
                      inputFormatters: kInputNoFormats,
                      decoration: kInputDecoration.copyWith(
                        hintText: 'العدد',
                        hintStyle: TextStyle(
                          fontFamily: 'GE',
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Submit
                  Container(
                    width: screenSize.width * 0.50,
                    height: 45,
                    margin: EdgeInsets.all(7.0),
                    child: FlatButton(
                      color: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1000),
                      ),
                      onPressed: () async {
                        Masrofna myMasrof = Masrofna.fromMyMap({
                          'product': product,
                          'price': price,
                          'noItems': noItems,
                          'weekMoney': weekMoney,
                        });
                        await helperProvider.createMasrofna(
                            myMasrof, widget.myTable);
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      child: Text(
                        'حفظ',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
