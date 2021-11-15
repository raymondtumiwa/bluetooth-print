import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:path_provider/path_provider.dart';
import 'package:realme_mapps/class/passingdata.dart';
import 'package:realme_mapps/screens/home/home_screen.dart';
import 'package:realme_mapps/screens/main_screen.dart';

import 'package:realme_mapps/services/on_rest.dart';
import 'package:realme_mapps/screens/home/attachment_viewer.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:realme_mapps/services/on_shared_preferences.dart';
import 'package:realme_mapps/widgets/take_picture_page.dart';

// var _commentControllerNew = new TextEditingController();
// List<TextEditingController> _commentController = [];
List<File> attachmentList = [];
List<File> files = [];
var commentValues = ["", "", "", ""];

class HomeShowBrandingApproval extends StatefulWidget {
  const HomeShowBrandingApproval(
      {Key key,
      @required this.screenMode,
      @required this.jwt,
      @required this.docNumber,
      @required this.baHeader,
      @required this.baValue,
      @required this.baTransfer})
      : super(key: key);

  final String screenMode;
  final String jwt;
  final String docNumber;
  final List baHeader;
  final List baValue;
  final List baTransfer;
  @override
  _HomeShowBrandingApprovalState createState() =>
      _HomeShowBrandingApprovalState(
          screenMode, jwt, docNumber, baHeader, baValue, baTransfer);
}

class _HomeShowBrandingApprovalState extends State<HomeShowBrandingApproval> {
  String screenMode;
  String docNumber;
  String jwt;
  List baValue;
  List baHeader;
  List baTransfer;
  _HomeShowBrandingApprovalState(this.screenMode, this.jwt, this.docNumber,
      this.baHeader, this.baValue, this.baTransfer);
  static ScrollController _hideButtonController;
  Stream _future;
  var orderan = [];
  var flowApproval = [];
  int tukangEs = 10;
  String usernameGlobal;
  //String _jwt2;
  int _index = 0;

  var brandingApprovalFeed = [
    {"document_id": "test", "status": "unapproved", "type": "text"}
  ];
  var listNameGenerator;
  @override
  void initState() {
    super.initState();
    attachmentList = [];
    files = [];
    listNameGenerator = "No uploaded files";
    print("baValz");
    print(docNumber);
    commentValues = ["", "", "", ""];
    //for (int i = 1; i < 5; i++) _commentController.add(TextEditingController());
    OnRest.instance
        .retrieveApprovalFlow(docNumber, jwt)
        .then((value2) => setState(() {
              print("value ");
              print(value2);
              flowApproval = value2;
            }));
    /*
    OnSharedPreferences.instance
        .getStringValue("accessToken")
        .then((value) => setState(() {
              _jwt = value;
              print(_jwt);
              
            }));
*/

    OnSharedPreferences.instance
        .getStringValue("username")
        .then((value) => {usernameGlobal = value});
/*
    OnSharedPreferences.instance
        .getStringValue("accessToken")
        .then((value) => {_jwt = value});

    //print("errrrr" + username);
   
    OnSharedPreferences.instance
        .getStringValue("accessToken")
        .then((value) => {setUpTimedFetch(value)});

        */

    /*
    String tokens =
        OnSharedPreferences.instance.getStringValue('accessToken').toString();
    //initData();
    setUpTimedFetch(tokens);
    */
  }

  void _showCamera(waybillNum) async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    final pickedImage = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TakePicturePage(camera: camera)));
    setState(() {
      files.add(File(pickedImage));
      //print(path.basename(pickedImage.path));
    });
    /*
    var test = await OnRest.instance.uploadImage(pickedImage, waybillNum);
    print(test);

    OnRest.instance
        .confirmOrderCourier(usernameGlobal, waybillNum, jwt, pickedImage)
        .then((results) => setState(() {
              if (results != 'error') {
                //Navigator.of(context).pop();
                //showDialogConfirm();
              }
            }))
        .catchError((onError) {
      print('conn error');
      //Navigator.of(context).pop();
    });
    */
    // return result;
  }

  pathPicker() async {
    /*
    FilePickerResult result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      files = result.paths.map((path) => File(path)).toList();
      fileNameAll();
    } else {
      // User canceled the picker
    }
    */
    print("under construction");
  }

  void showDialogDone() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Done"),
          content: Text("Operation Success"),
          actions: <Widget>[
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                Navigator.pushAndRemoveUntil<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => MainScreen(),
                  ),
                  (route) =>
                      false, //if you want to disable back feature set to false
                );
              },
            ),
          ],
        );
      },
    );
  }

  confirmDialog(conditionType, testComment) {
    switch (conditionType) {
      case "approved":
        print(docNumber +
            " " +
            this.baTransfer[0]["current_place"].toString() +
            " " +
            conditionType +
            " " +
            testComment +
            " " +
            this.baTransfer[0]["task"] +
            " " +
            usernameGlobal +
            " " +
            jwt);
        print(files.length);
        print(files);
        print(testComment);
        String listName = "";
        //var valz = {'comment': testComment};
        var test = 0;
        if (files.isNotEmpty) {
          for (var filez in files) {
            if (test == 0) {
              listName = filez.path.split("/").last;
              test = test + 1;
            } else {
              listName = listName + ";" + filez.path.split("/").last;
            }
            OnRest.instance.uploadFreeForm(filez).then((value) => null);
          }
        }
        test = 0;
        var valz = {'comment': testComment, 'myFiles': listName};
        //String fileName = files.path.split("/").last;
        //var valz = {'comment': testComment};
        OnRest.instance
            .freeComment(docNumber, this.baTransfer[0]["current_place"],
                usernameGlobal, valz, jwt)
            .then((value) => null);

        OnRest.instance
            .approvalApply(
                docNumber,
                this.baTransfer[0]["current_place"].toString(),
                conditionType,
                testComment,
                this.baTransfer[0]["task"],
                usernameGlobal,
                jwt)
            .then((values) => setState(() {
                  print(values);
                  showDialogDone();
                }));
        break;
      case "rejected":
        if (files.isNotEmpty) {
          OnRest.instance.uploadFreeForm(files).then((value) => null);
        }
        OnRest.instance
            .approvalReject(
                docNumber,
                this.baTransfer[0]["current_place"],
                conditionType,
                commentValues[1],
                this.baTransfer[0]["task"],
                usernameGlobal,
                jwt)
            .then((values) => setState(() {}));
        break;
      case "return":
        if (files.isNotEmpty) {
          OnRest.instance.uploadFreeForm(files).then((value) => null);
        }
        OnRest.instance
            .approvalReturn(
                docNumber,
                this.baTransfer[0]["current_place"],
                conditionType,
                commentValues[2],
                this.baTransfer[0]["task"],
                usernameGlobal,
                jwt)
            .then((values) => setState(() {
                  showDialogDone();
                }));
        break;
      case "comment":
        OnRest.instance
            .approvalApply(
                docNumber,
                this.baTransfer[0]["current_place"],
                conditionType,
                commentValues[3],
                this.baTransfer[0]["task"],
                usernameGlobal,
                jwt)
            .then((values) => setState(() {}));
        break;
      default:
    }
  }

  fileNameAll() {
    //var listName;
    //var test = 0;
    if (files.isNotEmpty) {
      var test = 0;
      for (var filez in files) {
        if (test == 0) {
          this.listNameGenerator = filez.path.split("/").last;
          test = test + 1;
        } else {
          this.listNameGenerator =
              this.listNameGenerator + ";" + filez.path.split("/").last;
        }
      }
      //return listNameGenerator;
    } else {
      listNameGenerator = "No uploaded files";
    }
  }

  void showDialogConfirm(chooser, popupTitle) {
    //print(commentValues);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(popupTitle),
          //subtitle: Text(""),
          content: Container(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            //mainAxisSize: ,
            children: <Widget>[
              TextField(
                //enabled: false,
                //controller: _commentControllerNew,
                //controller: fakeController[tempNum],
                controller: TextEditingController(text: commentValues[chooser]),
                onChanged: (value) => commentValues[chooser] = value,
                decoration: InputDecoration(
                  labelText: "Please type your comment",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              Text(this.listNameGenerator)
            ],
          )),

          actions: <Widget>[
            TextButton(
              child: Text("Upload file"),
              onPressed: () {
                pathPicker();
                fileNameAll();
                //Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Take Photos"),
              onPressed: () {
                _showCamera(docNumber);
                //Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Confirm"),
              onPressed: () {
                Navigator.of(context).pop();
                confirmDialog(popupTitle, commentValues[chooser]);
              },
            ),
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  fileViewerMenu(extFile, orderanVal, orderanTitle) {
    //print("trio macan " + extFile + " " + orderanVal + " " + orderanTitle);
    return Card(
        color: Colors.white,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AttachmentViewer(
                          baHeader: extFile,
                          baValue: orderanVal,
                        )));
          },
          child: TextField(
            enabled: false,
            controller: TextEditingController(text: orderanVal[0].toString()),
            //controller: fakeController[tempNum],
            decoration: InputDecoration(
              labelText: orderanTitle,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ));
  }

  fileViewerMenu2(extFile, orderanVal, orderanTitle) {
    //print("trio macan " + extFile + " " + orderanVal + " " + orderanTitle);
    return Padding(
        padding: EdgeInsets.only(left: 10, top: 0),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AttachmentViewer(
                          baHeader: extFile,
                          baValue: orderanVal,
                        )));
          },
          child: CircleAvatar(
            backgroundColor: Color(0xFFFFC914),
            foregroundColor: Colors.white,
            //radius: 88.0,
            child: Icon(Icons.file_copy),
          ),
        ));
  }

  switchMode(orderan, orderanVal) {
    print("orderannnnn");
    print(orderanVal);
    print(orderan);
    var fakeController = [];
    int tempNum = orderan["id"];
    switch (orderan["type"]) {
      case "text":
        print(orderan["id"]);
        return Container(
          //height: 100,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              //Container(height: 50),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    //onTap: () {},

                    child: TextField(
                      enabled: false,
                      controller:
                          TextEditingController(text: orderanVal.toString()),
                      //controller: fakeController[tempNum],
                      decoration: InputDecoration(
                        //labelText: orderan["title"],
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        );
      case "file":
        print("rrrr " + orderan["id"].toString());
        print(orderanVal.length);
        return Container(
          color: Colors.white,
          //margin: EdgeInsets.symmetric(vertical: 20.0),
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: List.generate(
              //int.parse(value),
              orderanVal.length,
              (indexes) {
                print("indexes " + indexes.toString());
                return fileViewerMenu2(
                    orderanVal[indexes].toString().split(".").last,
                    orderanVal[indexes],
                    orderan["title"]);
              },
            ),
          ),
        );

      default:
        print(orderan["id"]);
        int tempNum = orderan["id"];
        return Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {},
                    child: TextField(
                      enabled: false,
                      controller:
                          TextEditingController(text: orderanVal.toString()),
                      decoration: InputDecoration(
                        //labelText: orderan["title"],
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        );
    }
  }

/*
  setUpTimedFetch(tokens) {
    //print(tokens);
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      if (mounted) {
        orderan = brandingApprovalFeed;

        setState(() {
          _future = Stream.value(timer.tick.toString());
        });
      }
    });
  }
*/

  baMainTab(orderan, orderanVal) {
    print("checkpoint baMainTab");
    print(orderanVal);
    return CustomScrollView(
      controller: _hideButtonController,
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(children: <Widget>[
                StreamBuilder(
                    stream: _future,
                    builder: (context, snapshot) {
                      return Column(
                        children: <Widget>[
                          //0xFF1254A0
                          GridView.count(
                            padding: EdgeInsets.all(5),
                            childAspectRatio: 2.75,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount: 1,
                            children: List.generate(
                              //int.parse(value),
                              orderan.length,
                              (index) {
                                print(index);
                                return ListTile(
                                  //leading: Icon(Icons.album),
                                  title: Text(orderan[index]["title"]),
                                  subtitle: switchMode(
                                      orderan[index], orderanVal[index]),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }),
              ]);
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }

  var tempStepper = [
    {
      "heading": "Elvaro (INITIATOR)",
      "subject": "APPROVED",
      "updatedAt": "2021-03-07 12:51:09",
      "content": null
    },
    {
      "heading": "Aji (APPROVER)",
      "subject": "PENDING",
      "updatedAt": "2021-03-07 12:51:09",
      "content": null
    }
  ];

  stepperMember(_flowApproval) {
    return Step(
      title: Text(_flowApproval["heading"] + " " + _flowApproval["subject"]),
      content: Text(""),
      subtitle: Text(_flowApproval["updatedAt"]),
      isActive: true,
    );
  }

//List<Step>
  baMainFlow(orderan, orderanVal) {
    print("checkpoint baMainTab");
    print(this.baTransfer);
    if (flowApproval.length != 0) {
      return Container(
          child: Stepper(
        physics: ClampingScrollPhysics(),
        steps: List.generate(
          //int.parse(value),
          flowApproval.length,
          (indexes) {
            print(indexes);
            return stepperMember(flowApproval[indexes]);
          },
        ),
        currentStep: _index,
        onStepTapped: (index) {
          setState(() {
            _index = index;
          });
        },
        controlsBuilder: (BuildContext context,
                {VoidCallback onStepContinue, VoidCallback onStepCancel}) =>
            Container(),
      ));
    }
  }

  // approvalConfirmation(docNumber, current_place, comment, task, username){

  //   OnRest.instance.approvalApply()
  // }

  screenSelector() {
    if (this.screenMode == "todo") {
      return [
        SpeedDialChild(
          child: Icon(Icons.assignment_late),
          backgroundColor: Colors.red,
          label: 'Reject',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => showDialogConfirm(3, "rejected"),
          //onLongPress: () => print('FIRST CHILD LONG PRESS'),
        ),
        SpeedDialChild(
          child: Icon(Icons.assignment_return),
          backgroundColor: Colors.red,
          label: 'Return',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => showDialogConfirm(2, "return"),
          //onLongPress: () => print('FIRST CHILD LONG PRESS'),
        ),
        SpeedDialChild(
          child: Icon(Icons.assignment),
          backgroundColor: Colors.blue,
          label: 'Comment',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => showDialogConfirm(1, "comment"),
          //onLongPress: () => print('SECOND CHILD LONG PRESS'),
        ),
        SpeedDialChild(
          child: Icon(Icons.assignment_turned_in),
          backgroundColor: Colors.blue,
          label: 'Approve',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => showDialogConfirm(0, "approved"),
          //onLongPress: () => print('THIRD CHILD LONG PRESS'),
        )
      ];
    } else if (this.screenMode == "cc") {
      return [
        SpeedDialChild(
          child: Icon(Icons.assignment),
          backgroundColor: Colors.blue,
          label: 'Comment',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => showDialogConfirm(1, "comment"),
          //onLongPress: () => print('SECOND CHILD LONG PRESS'),
        ),
        SpeedDialChild(
          child: Icon(Icons.assignment_turned_in),
          backgroundColor: Colors.blue,
          label: 'Submit',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => showDialogConfirm(0, "approved"),
          //onLongPress: () => print('THIRD CHILD LONG PRESS'),
        )
      ];
    } else {
      return [
        SpeedDialChild(
          child: Icon(Icons.assignment),
          backgroundColor: Colors.blue,
          label: 'Comment',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => showDialogConfirm(1, "comment"),
          //onLongPress: () => print('SECOND CHILD LONG PRESS'),
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    print("initializing..");
    print(baValue);
    //bool clickedCentreFAB = false;
    //var killswitch = true;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              //Tab(icon: Icon(Icons.directions_car)),
              Tab(
                icon: Icon(Icons.near_me),
                text: "Review task",
              ),
              Tab(icon: Icon(Icons.tour), text: "Process"),
            ],
          ),
          title: Text('Approval'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                  Color(0xFFFFC914),
                  Color(0xFFFFC914),
                ])),
          ),
        ),
        body: TabBarView(
          children: [
            Material(
              color: Colors.white,
              child: baMainTab(baHeader, baValue),
            ),
            baMainFlow(baHeader, baValue),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation
            .miniEndFloat, //specify the location of the FAB
        floatingActionButton: SpeedDial(
          /// both default to 16
          marginEnd: 18,
          marginBottom: 20,
          icon: Icons.create,
          activeIcon: Icons.remove,
          buttonSize: 56.0,
          visible: true,
          closeManually: false,

          renderOverlay: false,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          onOpen: () => print('OPENING DIAL'),
          onClose: () => print('DIAL CLOSED'),
          tooltip: 'Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 8.0,
          shape: CircleBorder(),

          children: screenSelector(),
        ),
      ),
    );
  }
}
