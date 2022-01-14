import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as initl;
import 'package:provider/provider.dart';

import '../shared/export.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewMasrofna extends StatefulWidget {
  const ViewMasrofna({
    Key? key,
    required this.index,
    this.imgs,
  }) : super(key: key);
  final int index;
  final String? imgs;
  @override
  _ViewMasrofnaState createState() => _ViewMasrofnaState();
}

class _ViewMasrofnaState extends State<ViewMasrofna>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  final ScrollController _scrollController = ScrollController();
  var myDate = initl.DateFormat().add_Md().format(DateTime.now());
  String? newImg;

  bool isSelected = false;

  bool isTrue = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )
      // ..forward()
      ..addListener(() {
        setState(() {
          // _change();
        });
      });

    getData();
    setData();
    _scrollController.addListener(() {});
  }

  setData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('img', widget.imgs!);
    });
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      newImg = prefs.getString('img');
      setData();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var providerH = context.watch<DBHelper>();
    var providerM = context.watch<Masrofna>();
    return WillPopScope(
      onWillPop: () {
        _back();
        return Future.value(false);
      },
      child: Scaffold(
        // backgroundColor: Color(0xff1D212B),
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            providerM.headerTitle[widget.index],
            style: kText,
          ),
          backgroundColor: Colors.white,
          elevation: 0.5,
          leading: const Text(''),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (route) => false);
                });
              },
              icon: const Icon(Icons.arrow_forward),
              color: Colors.black54,
            ),
          ],
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
            future: providerH.getAllMasrof(providerM.tables[widget.index]),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                // _checkWeekMoney(snapshot);

                return _buildMyListView(snapshot);
              }
            },
          ),
        ),
        floatingActionButton: _buildMyFloatButton(context),
      ),
    );
  }

  // _wantDelete() {
  showAlertDialog(BuildContext context, AsyncSnapshot snapshot, index) {
    Masrofna myMasrofs = Masrofna.fromMyMap(snapshot.data[index]);
    var providerH = context.read<DBHelper>();
    var providerM = context.read<Masrofna>();

    Widget cancelButton = TextButton(
      child: const Text("لا"),
      onPressed: () {
        setState(() {
          Navigator.of(context).pop();
        });
      },
    );
    Widget continueButton = TextButton(
      child: const Text("نعم"),
      onPressed: () {
        setState(() {
          isTrue = false;
          providerH.deleteMasrof(
            myMasrofs.id!,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
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
      content: const Text(
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

// Alert amount limit
// _wantDelete() {
  _showLimitAlert(BuildContext context) {
    // set up the AlertDialog
    Widget alert = const AlertDialog(
      content: Text(
        "تم الوصول إلى الحد الأقصى لهذا الإسبوع...",
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontFamily: 'AJ',
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  //// Methods
  // ListView
  Widget _buildMyListView(AsyncSnapshot snapshot) {
    var orientation = MediaQuery.of(context).orientation;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: orientation == Orientation.landscape ? 3 : 2),
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        Masrofna myMasrofs = Masrofna.fromMyMap(snapshot.data[index]);
        var screenSize = MediaQuery.of(context).size;
        var orientation = MediaQuery.of(context).orientation;
        if (myMasrofs.weekMoney! >= 500) {
          // setState(() {
          isTrue = true;
          // });
        } else if (myMasrofs.weekMoney! < 500) {
          // setState(() {
          isTrue = false;
          // });
        }
        // setState(() {
        // });
        return Container(
          width: orientation == Orientation.portrait
              ? screenSize.width * 0.50
              : screenSize.width * 0.25,
          // height: 390,
          margin: const EdgeInsets.all(5.0),
          // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: index.isEven ? kColors[0] : kColors[1],
            borderRadius: const BorderRadius.all(
              Radius.circular(14),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icons column
              SizedBox(
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
                    kSizedHMedium,
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
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (_) => UpdateMasrof(
                                        headerTitle:
                                            myMasrofs.headerTitle[widget.index],
                                        titles: myMasrofs.titles[widget.index],
                                        tables: myMasrofs.tables[widget.index],
                                        masrof: myMasrofs,
                                        index: widget.index,
                                      ),
                                    ),
                                    (route) => false);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    kSizedHMedium,
                    myMasrofs.img != null
                        ? Container(
                            alignment: Alignment.center,
                            width: 30,
                            height: 30,
                            child: ClipOval(
                              child: Material(
                                child: Ink(
                                  color: Colors.amber,
                                  child: IconButton(
                                      icon: kImageIcon,
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                            return _viewReceipt(
                                                screenSize, context, myMasrofs);
                                          }),
                                        );
                                      }),
                                ),
                              ),
                            ),
                          )
                        : const Text(''),
                  ],
                ),
              ),

              // Text column
              Column(
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
                  kSizedHSmall,
                  // Price
                  Padding(
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
                  kSizedHSmall,

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
                  kSizedHSmall,
                  Padding(
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
                  kSizedHSmall,

                  // No of Items
                  Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          myDate,
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
            ],
          ),
        );
      },
    );
  }

  Widget _viewReceipt(
      Size screenSize, BuildContext context, Masrofna myMasrofs) {
    return SizedBox(
      width: screenSize.width,
      height: screenSize.height,
      child: SafeArea(
        child: Scaffold(
          body: Stack(children: [
            Container(
              width: screenSize.width,
              height: screenSize.height,
              alignment: Alignment.center,
              child: InteractiveViewer(
                child: Image.file(
                  File(myMasrofs.img!),
                  fit: BoxFit.cover,
                  // width: screenSize.width,
                  // height: screenSize.height,
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Align(
                  alignment: Alignment.center,
                  child: ClipOval(
                    child: Material(
                      child: Ink(
                        color: Colors.amber,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          color: Colors.black,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  )),
            ),
          ]),
        ),
      ),
    );
  }

  // Floating Action Button
  Widget _buildMyFloatButton(BuildContext context) {
    return FloatingActionButton(
      // backgroundColor: isSelected ? Colors.redAccent : Colors.greenAccent,
      onPressed: () {
        // setState(() {
        // isTrue = true;
        if (isTrue) {
          print('I am $isTrue');
          _showLimitAlert(context);
        } else {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) {
              return AddNewMasrof(
                index: widget.index,
              );
            }),
            (route) => false,
          );
        }
        // });
      },
      child: const Icon(
        Icons.add,
      ),
    );
  }

  void _back() {
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }

  // _checkWeekMoney(AsyncSnapshot shot) {
  //   Masrofna myMasrofs = Masrofna.fromMyMap(shot.data[0]);

  //   int dor = 3;
  //   if (myMasrofs.weekMoney == 500) {
  //     print('I have 500 EGP');
  //   }
  // }
}
