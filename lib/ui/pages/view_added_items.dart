import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as initl;
import 'package:masrofnaa/ui/shared/export.dart';

class ViewMasrofna extends StatefulWidget {
  ViewMasrofna({
    @required this.myTable,
    @required this.tableTitle,
    @required this.appBarTitle,
  });
  final String myTable;
  final String tableTitle;
  final String appBarTitle;
  @override
  _ViewMasrofnaState createState() => _ViewMasrofnaState();
}

class _ViewMasrofnaState extends State<ViewMasrofna> {
  ScrollController _scrollController = ScrollController();
  var myDate = initl.DateFormat().add_Md().format(DateTime.now());
  // DBList myList;
  // int index;
  @override
  void initState() {
    super.initState();
    _scrollController..addListener(() {});
    // myList = DBList();
    // index = myList.getLength;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var helperProvider = context.watch<DBHelper>();
    return Scaffold(
      // backgroundColor: Color(0xff1D212B),
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.appBarTitle,
          style: kText,
        ),
        backgroundColor: Colors.white,
        elevation: 3.0,
        leading: Text(''),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                Navigator.of(context).pushReplacementNamed('/');
              });
            },
            icon: Icon(Icons.arrow_forward),
            color: Colors.black54,
          ),
          // Go to courses
          // _buildAddingCourseButton(),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
          future: helperProvider.getAllMasrof(widget.myTable),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return _buildMyListView(snapshot);
            }
          },
        ),
      ),
      floatingActionButton: _buildMyFloatButton(context),
    );
  }

  // _wantDelete() {
  showAlertDialog(BuildContext context, AsyncSnapshot snapshot, index) {
    Masrofna myMasrofs = Masrofna.fromMyMap(snapshot.data[index]);
    var helperProvider = context.read<DBHelper>();
    // String myTable = 'table1';
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("لا"),
      onPressed: () {
        setState(() {
          Navigator.of(context).pop();
        });
        // helper.delete(myCourse.id);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("نعم"),
      onPressed: () {
        setState(() {
          helperProvider.delete(
            myMasrofs.id,
            widget.myTable,
          );
          Navigator.pop(context);
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Container(
        alignment: Alignment.center,
        // color: Colors.redAccent,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        // height: 30,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "حذف المنتج",
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              height: 2,
            ),
          ],
        ),
      ),
      content: Text(
        "هل تريد حذف هذا المنتج نهائيًا؟",
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.start,
        style: TextStyle(),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  // }

  //// Methods
  // ListView
  Widget _buildMyListView(AsyncSnapshot snapshot) {
    return ListView.builder(
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(vertical: 20),
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        Masrofna myMasrofs = Masrofna.fromMyMap(snapshot.data[index]);
        // Masrofna myPrice = Masrofna().viewPrice();

        var screenSize = MediaQuery.of(context).size;
        var orientation = MediaQuery.of(context).orientation;
        return Container(
          width: orientation == Orientation.portrait
              ? screenSize.width * 0.95
              : screenSize.width * 0.95,
          // height: 900,
          margin: EdgeInsets.all(7.0),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icons column
              Container(
                width: screenSize.width * 0.12,
                // color: Colors.green,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 35,
                      height: 35,
                      child: ClipOval(
                        child: Material(
                          child: Ink(
                            color: Colors.black87,
                            child: IconButton(
                              icon: kDeleteIcon,
                              onPressed: () {
                                setState(() {
                                  showAlertDialog(context, snapshot, index);
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 35,
                      height: 35,
                      child: ClipOval(
                        child: Material(
                          child: Ink(
                            color: Colors.teal,
                            child: IconButton(
                              icon: kEditIcon,
                              onPressed: () {
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //     builder: (context) => UpdateFirstWeek(
                                //       masrofna1: myMasrofs,
                                //     ),
                                //   ),
                                // );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Text column
              Container(
                width: screenSize.width * 0.75,
                // color: Colors.black,
                padding: EdgeInsets.only(
                  right: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Item
                    Text(
                      'المنتج: ${myMasrofs.product}',
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey[400],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Price
                    Container(
                      width: screenSize.width * 0.80,
                      // color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 3.0),
                        child: Text(
                          'السعر: ${myMasrofs.price}',
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blueGrey[300],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Date

                    // No of Items
                    Padding(
                      padding: const EdgeInsets.only(left: 3.0),
                      child: Text(
                        'العدد: ${myMasrofs.noItems}',
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueGrey[300],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 3.0),
                        child: Text(
                          'المجموع: ${myMasrofs.total}',
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blueGrey[300],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    // No of Items
                    Padding(
                      padding: const EdgeInsets.only(left: 3.0),
                      child: Text(
                        'التاريخ: $myDate',
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueGrey[300],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Floating Action Button
  FloatingActionButton _buildMyFloatButton(BuildContext context) {
    // String myTable = 'table1';
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return AddNewMasrof(
                  myTable: widget.myTable,
                  tableTitle: widget.tableTitle,
                  appBarTitle: widget.appBarTitle,
                );
                // return;
              },
            ),
          );
        });
      },
      child: Icon(
        Icons.add,
      ),
    );
  }
}
