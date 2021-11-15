import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:blue/services/onrest.dart';
import '../services/globals.dart' as globals;

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();

  void onNewCameraSelected(camera) {}
}

class _TestPageState extends State<TestPage> {
  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  String? imagePath;
  String? _chosenValue;
  TextEditingController inputController = TextEditingController();

  @override
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
        imageFile = File(pickedFile.path);
        print(imageFile);
        print('imageFile');
      });
    }
  }

  dialogDone() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: AlertDialog(
            title: const Text("Berhasil"),
            content: Container(
              height: 50,
              child: Center(
                child: Column(
                  children: const [
                    Icon(
                      Icons.done,
                      color: Colors.green,
                    ),
                    Text("Upload Data Berhasil"),
                  ],
                ),
              ),
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/main');
                },
                child: const Text('Home'),
              ),
            ],
          ),
        );
      },
    );
  }

  diaologFailed() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: AlertDialog(
            title: const Text("Mohon diisi terlebih dahulu"),
            content: Container(
              height: 70,
              child: Center(
                child: Column(
                  children: const [
                    Icon(
                      Icons.warning,
                      color: Colors.red,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text("Upload Tidak Berhasil"),
                  ],
                ),
              ),
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Kembali'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget build(BuildContext context) {
    var inputReason = TextFormField(
      autofocus: false,
      controller: inputController,
      decoration: const InputDecoration(
        labelText:
            //  phoneNumberFromServer == null
            // ?
            'Ketik  disini',
        // : '$phoneNumberFromServer',
        hintText: 'Ketik  disini',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );
    final submitButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Color(0xFF1254A0),
                  Color(0xFF15bae8),
                ]),
            borderRadius: BorderRadius.circular(10),
          ),
          child: MaterialButton(
            minWidth: 330.0,
            height: 42.0,
            onPressed: () {
              if (inputController.text != "") {
                OnRest.instance
                    .uploadProblem(imagePath, globals.waybill, _chosenValue,
                        inputController.text)
                    .then((value) async {
                  dialogDone();
                  print(value);
                });
              } else {
                diaologFailed();
              }
            },
            child: const Text('Submit',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14)),
          ),
        ),
      ),
    );
    var keyboard_arrow_down;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
      ),
      body: SingleChildScrollView(
        // child: Center(
        child: Container(
          margin: EdgeInsets.only(top: 200),
          alignment: Alignment.center,
          // margin: const EdgeInsets.all(30),
          // height: 550,
          // width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(left: 40, right: 40, top: 40),
              //   child:
              Container(
                height: 200,
                width: 200,
                margin: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF1254A0),
                        Color(0xFF15bae8),
                      ]),
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 9.0,
                    ),
                  ],
                  // borderRadius: BorderRadius.circular(25),
                ),
                // height: MediaQuery.of(context).size.height * 0.25,
                // width: MediaQuery.of(context).size.width * 0.80,
                child: Container(
                    child: imageFile == null
                        ? Container(
                            // margin: const EdgeInsets.all(15),
                            child: IconButton(
                              onPressed: () {
                                _getFromCamera();
                              },
                              icon: const Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                          )
                        // Container(
                        //     // alignment: Alignment.center,
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: <Widget>[
                        //         Container(
                        //           alignment: Alignment.center,
                        //           child: IconButton(
                        //             onPressed: () {
                        //               _getFromCamera();
                        //             },
                        //             icon: const Icon(
                        //               Icons.camera_alt_rounded,
                        //               size: 50,
                        //             ),
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //   )
                        : Container(
                            child: Image.file(
                              imageFile!,
                              fit: BoxFit.cover,
                            ),
                          )),
              ),
              // ),
              imageFile != null
                  ? Column(
                      children: [
                        DropdownButton<String>(
                          value: _chosenValue,
                          //elevation: 5,
                          style: const TextStyle(color: Colors.black),

                          items: <String>[
                            'Problem',
                            'Delivered',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          hint: const Text(
                            "Please choose ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _chosenValue = value!;
                              print(_chosenValue);
                              print("BELA DAN");
                            });
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _chosenValue != null
                            ? _chosenValue == 'Problem'
                                ? const Text(
                                    'Alasan Anda',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  )
                                : const Text(
                                    'Atas Nama',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  )
                            : const Text('-'),
                        const SizedBox(
                          height: 10,
                        ),
                        _chosenValue != null
                            ? Column(
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: inputReason),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: submitButton),
                                ],
                              )
                            : const Text('-')
                      ],
                    )
                  : const Text(
                      'Silakan ambil gambar',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blue),
                    )
            ],
          ),
        ),
        // ),
      ),
    );
  }
}

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class TestPage extends StatefulWidget {
//   @override
//   _TestPageState createState() => _TestPageState();
// }

// class _TestPageState extends State<TestPage> {
//   /// Variables
//   File? imageFile;
//   String? imagePath;

//   /// Widget
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Image Picker"),
//         ),
//         body:
// Container(
//             child: imageFile == null
//                 ? Container(
//                     alignment: Alignment.center,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         RaisedButton(
//                           color: Colors.greenAccent,
//                           onPressed: () {
//                             _getFromGallery();
//                           },
//                           child: const Text("PICK FROM GALLERY"),
//                         ),
//                         Container(
//                           height: 40.0,
//                         ),
//                         RaisedButton(
//                           color: Colors.lightGreenAccent,
//                           onPressed: () {
//                             _getFromCamera();
//                           },
//                           child: const Text("PICK FROM CAMERA"),
//                         )
//                       ],
//                     ),
//                   )
//                 : Container(
//                     child: Image.file(
//                       imageFile!,
//                       fit: BoxFit.cover,
//                     ),
//                   )));
//   }

//   /// Get from gallery
//   Future _getFromGallery() async {
//     final pickedFile = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//       // maxWidth: 1800,
//       // maxHeight: 1800,
//     );
//     setState(() {});
//     if (pickedFile != null) {
//       setState(() {
//         imageFile = File(pickedFile.path);
//         imagePath = pickedFile.path;
//       });
//     }
//   }

/// Get from Camera

// }
