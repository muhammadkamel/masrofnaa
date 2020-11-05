import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as initl;
import 'package:masrofnaa/ui/shared/export.dart';

class ViewMasrofna extends StatefulWidget {
  ViewMasrofna({this.index});
  final int index;
  @override
  _ViewMasrofnaState createState() => _ViewMasrofnaState();
}

class _ViewMasrofnaState extends State<ViewMasrofna> {
  ScrollController _scrollController = ScrollController();
  var myDate = initl.DateFormat().add_Md().format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _scrollController..addListener(() {});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var providerH = context.watch<DBHelper>();
    var providerM = context.watch<Masrofna>();
    return Scaffold(
      // backgroundColor: Color(0xff1D212B),
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${providerM.headerTitle[widget.index]}',
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
          future: providerH.getAllMasrof(providerM.tables[widget.index]),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
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
    var providerH = context.read<DBHelper>();
    var providerM = context.read<Masrofna>();
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
          providerH.deleteMasrof(
            myMasrofs.id,
            providerM.tables[widget.index],
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
          // crossAxisAlignment: CrossAxisAlignment.end,
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
    var orientation = MediaQuery.of(context).orientation;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: orientation == Orientation.landscape ? 3 : 2),
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(vertical: 20),
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        Masrofna myMasrofs = Masrofna.fromMyMap(snapshot.data[index]);
        var screenSize = MediaQuery.of(context).size;
        var orientation = MediaQuery.of(context).orientation;
        return Container(
          width: orientation == Orientation.portrait
              ? screenSize.width * 0.20
              : screenSize.width * 0.25,
          // height: 900,
          margin: EdgeInsets.all(7.0),
          // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: index.isEven ? kColors[0] : kColors[1],
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      width: 30,
                      height: 30,
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
                      width: 30,
                      height: 30,
                      child: ClipOval(
                        child: Material(
                          child: Ink(
                            color: Colors.teal,
                            child: IconButton(
                              icon: kEditIcon,
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => UpdateMasrof(
                                      headerTitle:
                                          '${myMasrofs.headerTitle[widget.index]}',
                                      titles:
                                          '${myMasrofs.titles[widget.index]}',
                                      tables:
                                          '${myMasrofs.tables[widget.index]}',
                                      masrof: myMasrofs,
                                      index: widget.index,
                                    ),
                                  ),
                                );
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
                // width: screenSize.width * 0.30,
                // color: Colors.black,
                // padding: EdgeInsets.only(
                //   right: 20,
                // ),
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
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.blueGrey[500],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Price
                    Container(
                      // width: screenSize.width * 0.80,
                      // color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 3.0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${myMasrofs.price}',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.blueGrey[400],
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            Text(
                              'السعر: ',
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.blueGrey[400],
                              ),
                            ),
                          ],
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
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${myMasrofs.noItems}',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blueGrey[400],
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          Text(
                            'العدد: ',
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blueGrey[400],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 3.0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${(myMasrofs.total)}',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.blueGrey[400],
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            Text(
                              'المجموع: ',
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.blueGrey[400],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    // No of Items
                    Padding(
                      padding: const EdgeInsets.only(left: 3.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '$myDate',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blueGrey[400],
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          Text(
                            'التاريخ: ',
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blueGrey[400],
                            ),
                          ),
                        ],
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
                return AddNewMasrof(index: widget.index);
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
