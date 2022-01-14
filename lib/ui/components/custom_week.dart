import 'package:flutter/material.dart';
import '../shared/export.dart';

import 'package:provider/provider.dart';

class CustomWeek extends StatefulWidget {
  const CustomWeek({required this.index});
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

    return FutureBuilder<List<dynamic>>(
        future: providerH.getAllMasrof(providerM),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            try {
              Masrofna myMasrof = Masrofna.fromMyMap(snapshot.data!.first);
              return CustomView(
                  snapshot: myMasrof,
                  index: widget.index,
                  child: const CircularProgressIndicator());
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
            return const Text('Nothing to view');
          } else {
            return CustomView(
              index: widget.index,
              // snapshot: ,
              child: const CircularProgressIndicator(),
            );
          }
        });
  }
}
