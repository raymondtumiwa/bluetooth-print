import 'dart:async';

import 'package:flutter/material.dart';

import 'package:realme_mapps/services/on_rest.dart';
import 'package:realme_mapps/services/on_shared_preferences.dart';

import '../../constant.dart';
import 'package:realme_mapps/screens/home/home_showba.dart';

class HomeCcToMe extends StatefulWidget {
  HomeCcToMe({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeCcToMeState createState() => _HomeCcToMeState();
}

class _HomeCcToMeState extends State<HomeCcToMe> {
  Stream _future;
  var orderan = [];
  int tukangEs = 10;
  String username;
  String _jwt;
  String employeeRole;
  String employeeArea;
  bool switchExist = true;

  var brandingApprovalFeed = [
    {"document_id": "test", "status": "unapproved", "type": "text"},
    {"document_id": "test2", "status": "unapproved", "type": "text"},
  ];

  @override
  void initState() {
    super.initState();

    OnSharedPreferences.instance
        .getStringValue("username")
        .then((value) => {username = value});

    OnSharedPreferences.instance
        .getStringValue("accessToken")
        .then((value) => {_jwt = value});
    OnSharedPreferences.instance
        .getStringValue("employeeRole")
        .then((value) => {employeeRole = value});
    OnSharedPreferences.instance
        .getStringValue("employeeArea")
        .then((value) => {employeeArea = value});

    //print("errrrr" + username);
    OnSharedPreferences.instance.getStringValue("accessToken").then((value) =>
        {setUpTimedFetch(username, employeeRole, employeeArea, value)});
    /*
    String tokens =
        OnSharedPreferences.instance.getStringValue('accessToken').toString();
    //initData();
    setUpTimedFetch(tokens);
    */
  }

  void showDialogConfirm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Berhasil"),
          content: Text("Berhasil Pickup"),
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

  setUpTimedFetch(username, employeeRole, employeeArea, tokens) {
    //print(tokens);

    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      if (mounted) {
        //OnSharedPreferences.instance
        //    .setStringValue('accessToken', testdrive['accessToken']);
        //orderan = brandingApprovalFeed;
        // print("username");
        // print(username);
        // print(tokens);

        OnRest.instance
            .findNewCC(username, tokens)
            .then((value) => setState(() {
                  //print("disini?");
                  //print(value);
                  if (value.isEmpty) {
                    this.switchExist = false;
                  } else {
                    //print("disini?");
                    this.switchExist = true;
                    orderan = value;
                  }
                }));

        setState(() {
          _future = Stream.value(timer.tick.toString());
        });
      }
    });
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      StreamBuilder(
          stream: _future,
          builder: (context, snapshot) {
            //print(switchExist);
            if (this.switchExist == false) {
              return Container(child: Text("No Data"));
            } else {
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
                                        //print(orderan);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeShowBrandingApproval(
                                                        screenMode: "cc",
                                                        jwt: _jwt,
                                                        docNumber:
                                                            orderan[index]
                                                                ["docNumber"],
                                                        baHeader: orderan[index]
                                                            ["data"],
                                                        baValue: orderan[index]
                                                            ["value"],
                                                        baTransfer: [
                                                          {
                                                            "task":
                                                                orderan[index]
                                                                    ["task"],
                                                            "current_place":
                                                                orderan[index][
                                                                    "current_place"],
                                                          }
                                                        ])));
                                        //dispose();
                                      },
                                      child: Container(
                                          width: 360,
                                          height: 50,
                                          child: Column(children: <Widget>[
                                            SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.mark_as_unread,
                                                  size: 35,
                                                ),
                                                SizedBox(width: 10),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      "Branding Approval",
                                                      style: kBlackBoldMedium,
                                                    ),
                                                    Text(
                                                      orderan[index]
                                                                  ["docNumber"]
                                                              .toString() +
                                                          " " +
                                                          orderan[index]
                                                              ["createdAt"],
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
            }
          }),
    ]);
  }
}
