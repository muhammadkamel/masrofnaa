import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../shared/export.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNewMasrof extends StatefulWidget {
  const AddNewMasrof({required this.index});
  final int index;

  @override
  _AddNewMasrofState createState() => _AddNewMasrofState();
}

class _AddNewMasrofState extends State<AddNewMasrof> {
  late String product, img;
  late double price, noItems, weekMoney;
  late DateTime date;
  late FocusNode focus;
  final _productController = TextEditingController();
  final _priceController = TextEditingController();
  final _noItemsController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  bool isPrice = true;
  bool isNoItems = true;

  // Image
  final picker = ImagePicker();

  Future getAnImage(ImageSource source) async {
    final XFile? pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        img = pickedFile.path;
        setData(pickedFile.path);
      } else {
        print('No selected image');
      }
    });
  }

  setData(String myPath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      prefs.setString('key', myPath);
    });
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      img = prefs.getString('key')!;
    });
  }

  deleteData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    focus = FocusNode();
    _productController.addListener(() {
      _productController.value = _productController.value.copyWith(
        text: _productController.text,
        selection: TextSelection.fromPosition(
          TextPosition(
            offset: _productController.text.length,
          ),
        ),
      );
    });
    _priceController.addListener(() {
      _priceController.value = _priceController.value.copyWith(
        text: _priceController.text,
        selection: TextSelection.fromPosition(
          TextPosition(
            offset: _priceController.text.length,
          ),
        ),
      );
    });
    _noItemsController.addListener(() {
      _noItemsController.value = _noItemsController.value.copyWith(
        text: _noItemsController.text,
        selection: TextSelection.fromPosition(
          TextPosition(
            offset: _noItemsController.text.length,
          ),
        ),
      );
    });
  }

  clearText() {
    setState(() {
      _productController.buildTextSpan(
        style: const TextStyle(
          color: Colors.greenAccent,
        ),
        context: context,
        withComposing: false,
      );
    });
  }

  @override
  void dispose() {
    _productController.dispose();
    _priceController.dispose();
    _noItemsController.dispose();

    super.dispose();
  }

  _submit() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      Masrofna myMasrof = Masrofna.fromMyMap({
        'product': product,
        'price': price,
        'noItems': noItems,
        'weekMoney': weekMoney,
        'img': img,
      });
      var providerH = context.read<DBHelper>();
      var providerM = context.read<Masrofna>();
      await providerH.createMasrofna(myMasrof, providerM.tables[widget.index]);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ViewMasrofna(index: widget.index, imgs: img),
        ),
      );
    }
    // Dismiss the keyboard
    var currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          _back();
          return Future.value(false);
        },
        child: Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text(
              'إضافة مصروف',
              style: kText,
            ),
            backgroundColor: Colors.white,
            elevation: 0.5,
            actions: [
              Align(
                alignment: Alignment.center,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.grey[600],
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (_) =>
                                ViewMasrofna(index: widget.index, imgs: img),
                          ),
                          (route) => false);
                    });
                  },
                ),
              ),
            ],
            // leading:
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  kSizedHMedium,

                  // Product
                  _product(),
                  kSizedHMedium,

                  // Price
                  _price(),
                  kSizedHMedium,

                  // No Items
                  _noItems(),

                  // Add an image
                  kSizedHMedium,
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: screenSize.width * 0.55,
                          height: 225,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(14),
                            ),
                            border: Border.symmetric(
                              horizontal: BorderSide(
                                width: 2.0,
                                color: Colors.blue,
                              ),
                              vertical: BorderSide(
                                width: 2.0,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              img.isNotEmpty
                                  ? Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            child: InteractiveViewer(
                                              child: Image.file(
                                                File(img),
                                                fit: BoxFit.cover,
                                                width: 140,
                                                height: 170,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: 30,
                                          height: 30,
                                          child: ClipOval(
                                            child: Material(
                                              child: Ink(
                                                color: Colors.white,
                                                child: IconButton(
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    size: 15,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      deleteData();
                                                      getData();
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : const Center(
                                      child: Text(
                                        'يتم إضافة اسعار\n المنتجات كصورة هنا!',
                                        style: TextStyle(
                                          fontFamily: 'AJ',
                                        ),
                                        textAlign: TextAlign.center,
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 150,
                        height: 40,
                        child: TextButton.icon(
                          icon: kAddImgIcon,
                          // color: Colors.blue.withOpacity(0.05),
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(7),
                          // ),
                          // splashColor: Colors.blue.withOpacity(0.03),
                          // highlightColor: Colors.blue.shade50,
                          label: const Text(
                            'إضافة صورة',
                            style: TextStyle(
                              fontFamily: 'AJ',
                              color: Colors.blue,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              showModalBottomSheet(
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(22),
                                    topRight: Radius.circular(22),
                                  ),
                                ),
                                context: context,
                                builder: (context) {
                                  // Size screenSize =
                                  //     MediaQuery.of(context).size;
                                  return SizedBox(
                                    // color: Colors.red,
                                    // height: screenSize.height * 0.20,
                                    height: 200,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: ListTile(
                                            leading: const Icon(Icons.photo),
                                            title: const Text(
                                              'الصور',
                                              style:
                                                  TextStyle(fontFamily: 'AJ'),
                                            ),
                                            onTap: () {
                                              getAnImage(ImageSource.gallery);
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                        kSizedHSmall,
                                        Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: ListTile(
                                            leading:
                                                const Icon(Icons.camera_alt),
                                            title: const Text(
                                              'الكاميرا',
                                              style:
                                                  TextStyle(fontFamily: 'AJ'),
                                            ),
                                            onTap: () {
                                              getAnImage(ImageSource.camera);
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            });
                          },
                        ),
                      )
                    ],
                  ),

                  kSizedHMedium,
                  // Submit
                  Container(
                    width: screenSize.width * 0.35,
                    height: 45,
                    margin: const EdgeInsets.all(7.0),
                    child: TextButton(
                      // color: Colors.blueAccent,
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(1000),
                      // ),
                      onPressed: () async {
                        await _submit();
                        setState(() {});
                      },
                      child: const Text(
                        'حفظ',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'AJ',
                        ),
                      ),
                    ),
                  ),
                  kSizedHLarge,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _product() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          validator: (val) {
            if (val!.isEmpty) {
              return "يجب عليك اضافة منتج";
            } else {
              return null;
            }
          },
          controller: _productController,
          onChanged: (val) {
            setState(() {
              product = val;
            });
          },
          autofocus: true,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'AJ',
          ),
          decoration: kInputDecoration.copyWith(
            hintText: 'إسم المنتج',
            alignLabelWithHint: true,
            hintStyle: const TextStyle(
              fontFamily: 'AJ',
            ),
            errorStyle: const TextStyle(),
          ),
        ),
      ),
    );
  }

  Widget _price() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          validator: (val) {
            if (val!.isEmpty) {
              return "يجب عليك اضافة سعر المنتج";
            } else {
              return null;
            }
          },
          controller: _priceController,
          style: const TextStyle(
            fontFamily: 'Montserrat',
          ),
          onChanged: (val) {
            setState(() {
              if (_priceController.text.isEmpty) {
                isPrice = true;
              } else {
                isPrice = false;
                price = double.parse(val);
              }
            });
          },
          keyboardType: TextInputType.number,
          inputFormatters: kInputNoFormats,
          textAlign: isPrice ? TextAlign.right : TextAlign.left, // Inside
          textDirection: TextDirection.rtl,
          decoration: kInputDecoration.copyWith(
            hintText: 'السعر',
            hintStyle: const TextStyle(
              fontFamily: 'AJ',
            ),
          ),
        ),
      ),
    );
  }

  Widget _noItems() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          validator: (val) {
            if (val!.isEmpty) {
              return "يجب عليك اضافة عدد المنتج";
            } else {
              return null;
            }
          },
          controller: _noItemsController,
          style: const TextStyle(
            fontFamily: 'Montserrat',
          ),
          onChanged: (val) {
            setState(() {
              if (_noItemsController.text.isEmpty) {
                isNoItems = true;
              } else {
                isNoItems = false;
                noItems = double.parse(val);
              }
            });
          },
          keyboardType: TextInputType.number,
          inputFormatters: kInputNoFormats,
          textAlign: isNoItems ? TextAlign.right : TextAlign.left, // Inside
          textDirection: TextDirection.rtl,
          decoration: kInputDecoration.copyWith(
            hintText: 'العدد',
            hintStyle: const TextStyle(
              fontFamily: 'AJ',
            ),
          ),
        ),
      ),
    );
  }

  // Back
  _back() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => ViewMasrofna(
            index: widget.index,
            imgs: '',
          ),
        ),
        (route) => false);
  }
}
