import 'package:flutter/material.dart';
import 'package:masrofnaa/ui/shared/export.dart';

class CustomWeek extends StatefulWidget {
  CustomWeek({@required this.index});
  final int index;
  @override
  _CustomWeekState createState() => _CustomWeekState();
}

class _CustomWeekState extends State<CustomWeek> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var providerH = context.watch<DBHelper>();
    var providerM =
        context.select((Masrofna masrofna) => masrofna.tables[widget.index]);

    return Container(
      // color: Colors.red,
      // padding: EdgeInsets.all(7.0),
      child: FutureBuilder(
          future: providerH.getAllMasrof(providerM),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              try {
                Masrofna myMasrof = Masrofna.fromMyMap(snapshot.data[0]);
                return CustomView(
                    snapshot: myMasrof,
                    index: widget.index,
                    child: CircularProgressIndicator());
              } catch (e) {
                var screenSize = MediaQuery.of(context).size;
                var orientation = MediaQuery.of(context).orientation;
                var providerM = context.watch<Masrofna>();
                return NoMoney(
                    orientation: orientation,
                    screenSize: screenSize,
                    headerTitle: providerM,
                    index: widget.index);
              }
            } else if (snapshot.hasError) {
              return Text('Nothing to view');
            } else {
              return CustomView(
                index: widget.index,
                // snapshot: ,
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
