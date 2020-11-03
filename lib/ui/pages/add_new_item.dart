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
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  bool isPrice = true;
  bool isNoItems = true;

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
    _priceController.dispose();
    _noItemsController.dispose();

    super.dispose();
  }

  _submit() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      Masrofna myMasrof = Masrofna.fromMyMap({
        'product': product,
        'price': price,
        'noItems': noItems,
        'weekMoney': weekMoney,
      });
      var providerH = context.read<DBHelper>();
      await providerH.createMasrofna(myMasrof, widget.myTable);
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
    }
    // Dismiss the keyboard
    var currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    // _showSnackBar("Data saved successfully");
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
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
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  // Product
                  _product(),
                  SizedBox(
                    height: 20,
                  ),

                  // Price
                  _price(),
                  SizedBox(
                    height: 20,
                  ),

                  // No Items
                  _noItems(),
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
                        await _submit();
                        setState(() {});
                        // Navigator.pop(context);
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

  Widget _product() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          validator: (val) {
            if (val.isEmpty) {
              return "يجب عليك اضافة منتج";
            } else {
              return null;
            }
          },
          controller: _productController,
          onChanged: (val) {
            setState(() {
              product = val;
            });
          },
          autofocus: true,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'GE',
          ),
          decoration: kInputDecoration.copyWith(
            hintText: 'إسم المنتج',
            alignLabelWithHint: true,
            hintStyle: TextStyle(
              fontFamily: 'GE',
            ),
            errorStyle: TextStyle(),
          ),
        ),
      ),
    );
  }

  Widget _price() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          validator: (val) {
            if (val.length == 0) {
              return "يجب عليك اضافة سعر المنتج";
            } else {
              return null;
            }
          },
          controller: _priceController,
          style: TextStyle(
            fontFamily: 'Montserrat',
          ),
          onChanged: (val) {
            setState(() {
              if (_priceController.text.isEmpty) {
                isPrice = true;
              } else {
                isPrice = false;
                price = double.parse(val);
              }
            });
          },
          keyboardType: TextInputType.number,
          inputFormatters: kInputNoFormats,
          textAlign: isPrice ? TextAlign.right : TextAlign.left, // Inside
          textDirection: TextDirection.rtl,
          decoration: kInputDecoration.copyWith(
            hintText: 'السعر',
            hintStyle: TextStyle(
              fontFamily: 'GE',
            ),
          ),
        ),
      ),
    );
  }

  Widget _noItems() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          validator: (val) {
            if (val.length == 0) {
              return "يجب عليك اضافة عدد المنتج";
            } else {
              return null;
            }
          },
          controller: _noItemsController,
          style: TextStyle(
            fontFamily: 'Montserrat',
          ),
          onChanged: (val) {
            setState(() {
              if (_noItemsController.text.isEmpty) {
                isNoItems = true;
              } else {
                isNoItems = false;
                noItems = double.parse(val);
              }
            });
          },
          keyboardType: TextInputType.number,
          inputFormatters: kInputNoFormats,
          textAlign: isNoItems ? TextAlign.right : TextAlign.left, // Inside
          textDirection: TextDirection.rtl,
          decoration: kInputDecoration.copyWith(
            hintText: 'العدد',
            hintStyle: TextStyle(
              fontFamily: 'GE',
            ),
          ),
        ),
      ),
    );
  }
}
