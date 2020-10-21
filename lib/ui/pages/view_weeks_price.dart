import 'package:flutter/material.dart';
import 'package:masrofnaa/ui/shared/export.dart';

class CreateAWeek extends StatefulWidget {
  CreateAWeek({
    @required this.myTable,
    @required this.title,
    @required this.appBarTitle,
  });
  final String myTable;
  final String title;
  final String appBarTitle;

  @override
  _CreateAWeekState createState() => _CreateAWeekState();
}

class _CreateAWeekState extends State<CreateAWeek> {
  @override
  void initState() {
    super.initState();
  }

  // ListView
  Widget _buildMyListView(AsyncSnapshot snapshot) {
    Masrofna myMasrofs = Masrofna.fromMyMap(snapshot.data[0]);
    // Masrofna myPrice = Masrofna().viewPrice();

    var screenSize = MediaQuery.of(context).size;
    var orientation = MediaQuery.of(context).orientation;
    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ViewMasrofna(
                  appBarTitle: widget.appBarTitle,
                  myTable: widget.myTable,
                  tableTitle: 'Table Title',
                ),
              ));
        });
      },
      child: Stack(
        children: [
          Container(
            width: orientation == Orientation.portrait
                ? screenSize.width * 0.45
                : screenSize.width * 0.38,
            height: orientation == Orientation.portrait
                ? screenSize.height * 0.33
                : screenSize.height * 0.60,
            margin: EdgeInsets.all(7.0),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              // color: Colors.grey[100],

              color: Colors.lightBlue.withOpacity(0.15),

              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text column

                Container(
                  // color: Colors.greenAccent,

                  child: Center(
                    child: Text(
                      'إجمالي المبلغ',
                      style: kText,
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                // Text column

                Container(
                  // color: Colors.greenAccent,

                  child: Center(
                    child: Text(
                      '${(myMasrofs.weekMoney).toStringAsFixed(1)}',
                      style: kText.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: orientation == Orientation.portrait
                  ? screenSize.width * 0.45
                  : screenSize.width * 0.38,
              height: 42,
              margin: EdgeInsets.all(7.0),
              child: Center(
                child: Text(
                  '${widget.title}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(14),
                  topLeft: Radius.circular(14),
                ),
                gradient: LinearGradient(colors: [
                  Colors.purpleAccent.shade200,
                  Colors.blueAccent.shade200,
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var providerHelper = context.watch<DBHelper>();

    return Container(
      // color: Colors.red,
      // padding: EdgeInsets.all(7.0),
      child: FutureBuilder(
          future: providerHelper.getAllMasrof(widget.myTable),
          builder: (context, snapshot) {
            try {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return _buildMyListView(snapshot);
              }
            } catch (e) {
              var screenSize = MediaQuery.of(context).size;
              var orientation = MediaQuery.of(context).orientation;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ViewMasrofna(
                            myTable: widget.myTable,
                            tableTitle: widget.title,
                            appBarTitle: widget.appBarTitle),
                      ),
                    );
                  });
                },
                child: Stack(
                  children: [
                    Container(
                      width: orientation == Orientation.portrait
                          ? screenSize.width * 0.45
                          : screenSize.width * 0.38,
                      height: orientation == Orientation.portrait
                          ? screenSize.height * 0.33
                          : screenSize.height * 0.60,
                      margin: EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.withOpacity(0.03),
                        borderRadius: BorderRadius.circular(14.0),
                        border: Border.all(
                          width: 2.0,
                          color: Colors.grey[200],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'لا يوجد أي مبلغ',
                          style: kText,
                        ),

                        // child: CircularProgressIndicator(),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      child: Container(
                        width: orientation == Orientation.portrait
                            ? screenSize.width * 0.45
                            : screenSize.width * 0.38,
                        height: 42,
                        margin: EdgeInsets.all(7.0),
                        child: Center(
                          child: Text(
                            '${widget.title}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(14),
                            topLeft: Radius.circular(14),
                          ),
                          gradient: LinearGradient(colors: [
                            Colors.purpleAccent.shade200,
                            Colors.blueAccent.shade200,
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
