import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:realme_mapps/class/passingdata.dart';
import '../../constant.dart';

//import 'package:onmapps/screens/ondelivery/ondelivery_findplace.dart';

var _noresiController = new TextEditingController();

class OndeliveryTrackPackage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/font_ondeliv.png',
          fit: BoxFit.contain,
          height: 100,
        ),
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
      body: CustomScrollView(
        //controller: _hideButtonController,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return OndeliveryTrackPackageBody();
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class OndeliveryTrackPackageBody extends StatefulWidget {
  @override
  OndeliveryTrackPackageBodyState createState() {
    return new OndeliveryTrackPackageBodyState();
  }
}

class OndeliveryTrackPackageBodyState
    extends State<OndeliveryTrackPackageBody> {
  // The GlobalKey keeps track of the visible state of the list items
  // while they are being animated.
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  // backing data
  List<String> _data = ['Sun'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            width: double.infinity,
            child: Card(
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Text(
                "Lacak Paket",
                style: kBlackBoldMedium,
                textAlign: TextAlign.left,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: TextField(
                    controller: _noresiController,
                    decoration: InputDecoration(
                        //prefixText: "Resi: ",
                        labelText: "Masukkan No.Resi",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)))),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: RaisedButton(
                  color: Colors.lightBlue[800],
                  child: Text(
                    "Lacak",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(
                          builder: (context) => Trackpackage2(
                              value: Track(
                            noresi: _noresiController.text,
                          )),
                        ))
                        .then((value) => setState(() {}));
                  },
                ),
              ),
            ]))),
      ],
    );
  }
}

// ===========Stepper============

class Trackpackage2 extends StatefulWidget {
  final Track value;

  Trackpackage2({Key key, @required this.value}) : super(key: key);

  @override
  _Trackpackage2State createState() => _Trackpackage2State(value);
}

class _Trackpackage2State extends State<Trackpackage2> {
  Track value;

  _Trackpackage2State(this.value);

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/font_ondeliv.png',
          fit: BoxFit.contain,
          height: 100,
        ),
        //centerTitle: true,

        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Color(0xFF15bae8),
                Color(0xFF1254A0),
              ])),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Card(
              child: Padding(
                padding:
                    EdgeInsets.only(top: 20, bottom: 20, left: 5, right: 5),
                child: Text(
                  "No Resi: ${value.noresi}",
                  style: TextStyle(color: Colors.grey[600], fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Container(
              child: Stepper(
            steps: [
              Step(
                title: Text("PAKET ANDA SUDAH SAMPAI DI TANJUNG PRIOK"),
                content: Text(""),
                subtitle: Text("16-12-2020 17.00"),
                isActive: false,
              ),
              Step(
                title: Text("PAKET ANDA BERADA DI DC UTARA"),
                content: Text(""),
                subtitle: Text("16-12-2020 16.00"),
                isActive: false,
              ),
              Step(
                title:
                    Text("PAKET ANDA MENUJU OMA CLUSTER CALIFORNIA KALIBARU"),
                content: Text(""),
                subtitle: Text("16-12-2020 15.00"),
                isActive: true,
              ),
              Step(
                title: Text("PAKET ANDA DITERIMA OLEH HARUN DOSAN"),
                content: Text(""),
                subtitle: Text("16-12-2020 15.00"),
                isActive: true,
                // state: StepState.complete
              ),
            ],
            currentStep: _index,
            onStepTapped: (index) {
              setState(() {
                _index = index;
              });
            },
            controlsBuilder: (BuildContext context,
                    {VoidCallback onStepContinue, VoidCallback onStepCancel}) =>
                Container(),
          )),
        ],
      ),
    );
  }
}
