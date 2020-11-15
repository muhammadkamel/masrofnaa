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

  Widget _buildNoPrice() {
    var screenSize = MediaQuery.of(context).size;
    var orientation = MediaQuery.of(context).orientation;
    var providerM = context.read<Masrofna>();
    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => ViewMasrofna(index: 4),
              ),
              (route) => false);
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

  @override
  Widget build(BuildContext context) {
    var providerH = context.watch<DBHelper>();
    var providerM = context.select((Masrofna masrofna) => masrofna.tables[4]);

    return Container(
      child: FutureBuilder(
          future: providerH.getAllMasrof(providerM),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              try {
                Masrofna myMasrof = Masrofna.fromMyMap(snapshot.data[0]);
                return CustomView(snapshot: myMasrof, index: 4);
              } catch (e) {
                return _buildNoPrice();
              }
            } else if (snapshot.hasError) {
              return Text('Error');
            } else {
              return CustomView(
                index: 4,
                // snapshot: ,
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
