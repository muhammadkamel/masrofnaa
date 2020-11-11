// import 'dart:io';
// import 'package:masrofnaa/ui/shared/export.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class TestImage extends StatefulWidget {
//   TestImage({@required this.img});
//   String img;
//   @override
//   _TestImageState createState() => _TestImageState();
// }

// class _TestImageState extends State<TestImage> {
//   final picker = ImagePicker();
//   // File _image;
//   // String imagePath;

//   Future getAnImage(ImageSource source) async {
//     final PickedFile pickedFile = await picker.getImage(source: source);

//     setState(() {
//       if (pickedFile != null) {
//         // _image = File(pickedFile.path);
//         widget.img = pickedFile.path;
//         setData(pickedFile.path);
//       } else {
//         print('No selected image');
//       }
//     });
//   }

//   setData(String myPath) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     setState(() {
//       prefs.setString('key', myPath);
//     });
//   }

//   getData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       widget.img = prefs.getString('key');
//     });
//   }

//   deleteData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       // prefs.remove('key');
//       prefs.clear();
//     });
//   }

//   // _wantDelete() {
//   showAlertDialog(BuildContext context) {
//     Widget cancelButton = FlatButton(
//       child: Text("لا"),
//       onPressed: () {
//         setState(() {
//           Navigator.of(context).pop();
//         });
//       },
//     );
//     Widget continueButton = FlatButton(
//       child: Text("نعم"),
//       onPressed: () async {
//         setState(() {
//           deleteData();
//         });
//         Navigator.pop(context);
//       },
//     );

//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       title: Container(
//         alignment: Alignment.center,
//         // color: Colors.redAccent,
//         padding: EdgeInsets.zero,
//         margin: EdgeInsets.zero,
//         // height: 30,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           // crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text(
//               "حذف المنتج",
//               textDirection: TextDirection.rtl,
//               textAlign: TextAlign.start,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Divider(
//               height: 2,
//             ),
//           ],
//         ),
//       ),
//       content: Text(
//         "هل تريد حذف هذا المنتج نهائيًا؟",
//         textDirection: TextDirection.rtl,
//         textAlign: TextAlign.start,
//         style: TextStyle(),
//       ),
//       actions: [
//         cancelButton,
//         continueButton,
//       ],
//     );

//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }

//   @override
//   void didUpdateWidget(covariant TestImage oldWidget) {
//     // setData();
//     getData();
//     super.didUpdateWidget(oldWidget);
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;
//     return Row(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             width: screenSize.width * 0.55,
//             height: 225,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(14),
//               border: Border.all(
//                 width: 2,
//                 color: Colors.blue,
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 widget.img != null
//                     ? Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(14),
//                               child: InteractiveViewer(
//                                 child: Image.file(
//                                   File(widget.img),
//                                   fit: BoxFit.cover,
//                                   width: 140,
//                                   height: 170,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             alignment: Alignment.center,
//                             width: 30,
//                             height: 30,
//                             child: ClipOval(
//                               child: Material(
//                                 child: Ink(
//                                   color: Colors.white,
//                                   child: IconButton(
//                                     icon: Icon(
//                                       Icons.delete,
//                                       size: 15,
//                                     ),
//                                     onPressed: () {
//                                       setState(() {
//                                         deleteData();
//                                         getData();
//                                       });
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                     : Center(
//                         child: Text(
//                           'يتم إضافة اسعار\n المنتجات كصورة هنا!',
//                           style: TextStyle(
//                             fontFamily: 'AJ',
//                           ),
//                           textAlign: TextAlign.center,
//                           textDirection: TextDirection.rtl,
//                         ),
//                       ),
//               ],
//             ),
//           ),
//         ),
//         Container(
//           alignment: Alignment.center,
//           width: 150,
//           height: 40,
//           child: FlatButton.icon(
//             icon: kAddImgIcon,
//             color: Colors.blue.withOpacity(0.05),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(7),
//             ),
//             splashColor: Colors.blue.withOpacity(0.03),
//             highlightColor: Colors.blue.shade50,
//             label: Text(
//               'إضافة صورة',
//               style: TextStyle(
//                 fontFamily: 'AJ',
//                 color: Colors.blue,
//               ),
//             ),
//             onPressed: () {
//               setState(() {
//                 showModalBottomSheet(
//                   backgroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(30),
//                       topRight: Radius.circular(30),
//                     ),
//                   ),
//                   context: context,
//                   builder: (context) {
//                     Size screenSize = MediaQuery.of(context).size;
//                     return Container(
//                       // color: Colors.red,
//                       height: screenSize.height * 0.20,
//                       width: 100,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           FlatButton.icon(
//                             icon: Icon(Icons.image),
//                             label: Text('Gallery'),
//                             onPressed: () {
//                               getAnImage(ImageSource.gallery);
//                               Navigator.pop(context);
//                             },
//                           ),
//                           FlatButton.icon(
//                             icon: Icon(Icons.camera_alt),
//                             label: Text('Camera'),
//                             onPressed: () {
//                               getAnImage(ImageSource.camera);
//                               Navigator.pop(context);
//                             },
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//                 // showAlertDialog(context, snapshot, index);
//               });
//             },
//           ),
//         )
//       ],
//     );
//   }
// }
