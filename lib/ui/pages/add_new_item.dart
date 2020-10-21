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

  @override
  void initState() {
    super.initState();
    focus = FocusNode();
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
                      autofocus: true,
                      onChanged: (val) {
                        setState(() {
                          product = val;
                        });
                      },
                      textAlign: TextAlign.right,
                      decoration: kInputDecoration.copyWith(
                        hintText: 'إسم المنتج',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // Content input form
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      focusNode: focus,
                      onChanged: (val) {
                        setState(() {
                          price = double.parse(val);
                        });
                      },
                      textAlign: TextAlign.right,
                      inputFormatters: kInputNoFormats,
                      keyboardType: TextInputType.number,
                      decoration: kInputDecoration.copyWith(
                        hintText: 'السعر',
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
                        hintStyle: TextStyle(),
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
                        borderRadius: BorderRadius.circular(20),
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
