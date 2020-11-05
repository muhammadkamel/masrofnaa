import 'package:flutter/material.dart';
import 'package:masrofnaa/ui/shared/export.dart';

class ExtraAmount extends StatefulWidget {
  @override
  _ExtraAmountState createState() => _ExtraAmountState();
}

class _ExtraAmountState extends State<ExtraAmount> {
  @override
  void initState() {
    super.initState();
  }

  // ListView
  Widget _buildMyListView(AsyncSnapshot snapshot) {
    // var providerM = context.watch<Masrofna>();
    Masrofna myMasrof = Masrofna.fromMyMap(snapshot.data[0]);
    var screenSize = MediaQuery.of(context).size;
    var orientation = MediaQuery.of(context).orientation;
    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ViewMasrofna(index: 4),
              ));
        });
      },
      child: Stack(
        children: [
          Container(
            width: orientation == Orientation.portrait
                ? screenSize.width * 0.93
                : screenSize.width * 0.78,
            height: orientation == Orientation.portrait
                ? screenSize.height * 0.33
                : screenSize.height * 0.60,
            margin: EdgeInsets.all(7.0),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              gradient: kActiveColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text column
                Container(
                  child: Center(
                    child: Text(
                      'إجمالي المبلغ',
                      style: kText.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                // Text column
                Container(
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
                  ? screenSize.width * 0.93
                  : screenSize.width * 0.78,
              height: 42,
              margin: EdgeInsets.all(7.0),
              child: Center(
                child: Text(
                  '${myMasrof.titles[4]}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(14),
                  topLeft: Radius.circular(14),
                ),
                gradient: kHeaderColor,
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
    var providerM = context.select((Masrofna masrofna) => masrofna.tables[4]);

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
                            builder: (_) => ViewMasrofna(index: 4),
                          ));
                    });
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: orientation == Orientation.portrait
                            ? screenSize.width * 0.93
                            : screenSize.width * 0.78,
                        height: orientation == Orientation.portrait
                            ? screenSize.height * 0.33
                            : screenSize.height * 0.60,
                        margin: EdgeInsets.all(7.0),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          gradient: kActiveColor,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: Text(
                            'لا يوجد أي منتج',
                            textAlign: TextAlign.center,
                            style: kText.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        child: Container(
                          width: orientation == Orientation.portrait
                              ? screenSize.width * 0.93
                              : screenSize.width * 0.78,
                          height: 42,
                          margin: EdgeInsets.all(7.0),
                          child: Center(
                            child: Text(
                              '${providerM.titles[4]}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(14),
                              topLeft: Radius.circular(14),
                            ),
                            gradient: kHeaderColor,
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
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
