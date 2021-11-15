import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';

import 'package:realme_mapps/services/on_rest.dart';
import 'package:realme_mapps/widgets/take_picture_page.dart';
import 'package:realme_mapps/services/on_shared_preferences.dart';
import 'package:maps_launcher/maps_launcher.dart';
//import 'package:path/path.dart' as path;

class OngoingScreen extends StatefulWidget {
  @override
  _OngoingScreenState createState() => _OngoingScreenState();
}

class _OngoingScreenState extends State<OngoingScreen> {
  Stream _future;
  var orderan = [];
  int tukangEs = 10;
  List<File> attachmentList = [];

  String username;
  String _jwt;

  @override
  void initState() {
    super.initState();
    //print(OnSharedPreferences.instance.getUsername);
    OnSharedPreferences.instance
        .getStringValue("username")
        .then((value) => {username = value});

    OnSharedPreferences.instance
        .getStringValue("accessToken")
        .then((value) => {_jwt = value});
    OnSharedPreferences.instance
        .getStringValue("accessToken")
        .then((value) => {setUpTimedFetch(value)});
  }

//kind person start
  void _showCamera(waybillNum) async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    final pickedImage = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TakePicturePage(camera: camera)));
    setState(() {
      attachmentList.add(File(pickedImage));
      //print(path.basename(pickedImage.path));
    });
    var test = await OnRest.instance.uploadImage(pickedImage, waybillNum);
    print(test);
    OnRest.instance
        .confirmOrderCourier(username, waybillNum, _jwt, pickedImage)
        .then((results) => setState(() {
              if (results != 'error') {
                //Navigator.of(context).pop();
                showDialogConfirm();
              }
            }))
        .catchError((onError) {
      print('conn error');
      //Navigator.of(context).pop();
    });
    // return result;
  }

  void showDialogConfirm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Berhasil"),
          content: Text("Berhasil Terima"),
          actions: <Widget>[
            FlatButton(
              child: Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _removeImage(File pickedFile) {
    setState(() {
      attachmentList.remove(pickedFile);
    });
  }
//kind person end

  void _showDialog(String waybillNum, String nameKI, String indomaretKI,
      String destKI, lat, long) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Konfirmasi"),
          content: Text("Konfirmasi terima paket? \nAWB : " +
              waybillNum +
              "\nPenerima : " +
              nameKI +
              "\nIndomaret : " +
              indomaretKI +
              "\nAlamat :" +
              destKI),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("Yes"),
              onPressed: () {
                tukangEs = 1;
                Navigator.of(context).pop();
                _showCamera(waybillNum);
              },
            ),
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Maps"),
              onPressed: () {
                MapsLauncher.launchCoordinates(lat, long);
                //Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  setUpTimedFetch(tokens) {
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      if (mounted) {
        /*
        OnRest.instance
            .findNewTodo(tokens, username)
            .then((value) => setState(() {
                  //print(value);
                  orderan = value;
                }));
        setState(() {
          _future = Stream.value(timer.tick.toString());
        });
        */
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      StreamBuilder(
          stream: _future,
          builder: (context, snapshot) {
            return Column(
              children: <Widget>[
                //0xFF1254A0
                GridView.count(
                  //padding: EdgeInsets.all(5),
                  childAspectRatio: 5.75,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 1,
                  children: List.generate(
                    //int.parse(value),
                    orderan.length,
                    (index) {
                      return Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Card(
                                color: Colors.white,
                                child: InkWell(
                                    splashColor: Colors.blue.withAlpha(30),
                                    onTap: () {
                                      _showDialog(
                                          orderan[index]["waybill_number"],
                                          orderan[index]["recipient_name"],
                                          orderan[index]["indomaret_id"],
                                          orderan[index]["recipient_address"],
                                          double.parse(
                                              orderan[index]["recipient_lat"]),
                                          double.parse(orderan[index]
                                              ["recipient_long"]));
                                    },
                                    child: Container(
                                        width: 360,
                                        height: 50,
                                        //alignment: Alignment.centerLeft,
                                        child: Column(children: <Widget>[
                                          SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Icon(
                                                Icons.person_pin,
                                                size: 35,
                                              ),
                                              SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    "Pesanan baru dari " +
                                                        orderan[index][
                                                                'recipient_name']
                                                            .toString(),
                                                    style: kBlackBoldMedium,
                                                    //textAlign: TextAlign.left,
                                                  ),
                                                  Text(
                                                    "Dari " +
                                                        orderan[index]
                                                            ["indomaret_id"] +
                                                        " ke Tujuan",
                                                    //textAlign: TextAlign.left,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ])))),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }),
    ]);
  }
}
