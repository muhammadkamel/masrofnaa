import 'dart:io';

import 'package:flutter/material.dart';
import 'package:masrofnaa/ui/shared/export.dart';

class ViewImage extends StatefulWidget {
  @override
  _ViewImageState createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    // Masrofna myMasrofs = Masrofna.fromMyMap(snapshot.data[index]);
    return Scaffold(
      // key: _scaffoldKey,
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              // child: InteractiveViewer(
              // child: Image.file(
              // File(myMasrofs2.img),
              // fit: BoxFit.cover,
              // width: screenSize.width,
              // height: screenSize.height,
              // ),
              // ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  child: ClipOval(
                    child: Material(
                      child: Ink(
                        color: Colors.white,
                        child: IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () {
                            print('Test');
                            Navigator.pop(context);
                            // Navigator.pushNamedAndRemoveUntil(
                            //     context, '/', (route) => true);
                            // Navigator.of(context).pushNamed('/');
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
