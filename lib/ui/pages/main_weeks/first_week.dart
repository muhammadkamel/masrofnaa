import 'package:flutter/material.dart';
import 'package:masrofnaa/ui/shared/export.dart';

class FirstWeek extends StatefulWidget {
  @override
  _FirstWeekState createState() => _FirstWeekState();
}

class _FirstWeekState extends State<FirstWeek> {
  @override
  void initState() {
    super.initState();
  }

  // ListView
  Widget _buildMyListView(AsyncSnapshot snapshot) {
    var providerM = context.read<Masrofna>();
    Masrofna myMasrof = Masrofna.fromMyMap(snapshot.data[0]);
    var screenSize = MediaQuery.of(context).size;
    var orientation = MediaQuery.of(context).orientation;
    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ViewMasrofna(index: 0),
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
              color: Colors.greenAccent,
              // gradient: LinearGradient(
              //   colors: [
              //     Colors.blue.shade100,
              //     Colors.blue.shade50,
              //   ],
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              // ),
              borderRadius: BorderRadius.circular(14),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey[300],
              //     offset: Offset.zero,
              //     blurRadius: 20,
              //   ),
              // ],
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
                      '${myMasrof.weekMoney}',
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
                  // '${widget.title}',
                  '${providerM.titles[0]}',
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
                gradient: LinearGradient(
                  colors: [
                    Colors.indigoAccent,
                    Colors.blueAccent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var providerH = context.watch<DBHelper>();
    var providerM = context.select((Masrofna value) => value.tables[0]);

    return Container(
        // color: Colors.red,
        // padding: EdgeInsets.all(7.0),
        child: FutureBuilder(
            future: providerH.getAllMasrof(providerM),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                try {
                  return _buildMyListView(snapshot);
                } catch (e) {
                  var screenSize = MediaQuery.of(context).size;
                  var orientation = MediaQuery.of(context).orientation;
                  var providerM = context.watch<Masrofna>();
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ViewMasrofna(index: 0),
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.redAccent.shade400,
                            // gradient: LinearGradient(
                            //   colors: [
                            //     Colors.white,
                            //     Colors.grey.shade100,
                            //   ],
                            //   begin: Alignment.topCenter,
                            //   end: Alignment.bottomCenter,
                            // ),
                            borderRadius: BorderRadius.circular(14),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.grey[300],
                            //     offset: Offset.zero,
                            //     blurRadius: 20,
                            //   ),
                            // ],
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
                                    'لا يوجد أي منتج',
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
                                    '',
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
                                // '${widget.title}',
                                '${providerM.titles[0]}',
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
                              gradient: LinearGradient(
                                colors: [
                                  Colors.indigoAccent,
                                  Colors.blueAccent,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              } else if (snapshot.hasError) {
                return Text('Error');
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
