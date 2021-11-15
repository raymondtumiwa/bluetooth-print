import 'package:flutter/material.dart';
import 'package:blue/services/onrest.dart';
// import 'package:giffy_dialog/giffy_dialog.dart';
import '../services/globals.dart' as globals;

class ConfirmList extends StatefulWidget {
  @override
  _ConfirmListState createState() => _ConfirmListState();
}

class _ConfirmListState extends State<ConfirmList> {
  var confirmList = [];
  bool isValid = false;
  int? itemCount;

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  void fetchData() {
    OnRest.instance
        .listConfirm(globals.agentLocId, globals.courierId)
        .then((value) {
      if (value != null) {
        print(value);
        print("BELA");
        print(value.length);
        setState(() {
          confirmList = [];
          for (int i = 0; i < value.length; i++) {
            confirmList.add(value[i]);
            print(confirmList);
          }
          print(confirmList);
          isValid = true;
        });
        // setState(() {
        //   globals.fleetId = value['fleetId'];
        //   globals.checkInTime = value['checkInTime'];
        //   globals.tripId = value['tripId'];
        //   globals.latLongIn = value['latLongIn'];
        // });
        // Navigator.of(context).pushNamedAndRemoveUntil(
        //     '/checkin', (Route<dynamic> route) => false);
      }
    }).catchError((ee) {
      print(ee);
    });
  }

  dialogConfirm(
    String waybillNumber,
    String origin,
    String service,
    String senderName,
    String senderPhone,
    String sendeCity,
    String senderZipcode,
    String consigneeName,
    String consigneePhone,
    String consigneeZipcode,
    String consigneeAddress,
    String destination,
    String scannedAt,
    var goodsKoli,
    var goodWeight,
    String status,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Details"),
          content: SizedBox(
            height: 400,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      children: [
                        const Text(
                          "Waybill Number : ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(waybillNumber),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      children: [
                        const Text("Origin : ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(origin),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      children: [
                        const Text("Service : ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(service),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      children: [
                        const Text("Sender Name : ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(senderName),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      children: [
                        const Text("Sender Phone : ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(senderPhone),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      children: [
                        const Text("Sende City : ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(sendeCity),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      children: [
                        const Text("Sender Zipcode : ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(senderZipcode),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      children: [
                        const Text("Consignee Name : ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(consigneeName),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      children: [
                        const Text("Consignee Phone : ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(consigneePhone),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      children: [
                        const Text("Consignee Zipcode : ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(consigneeZipcode),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      children: [
                        const Text("Consignee Address : ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(consigneeAddress),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      children: [
                        const Text("Destination : ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(destination),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      children: [
                        const Text("Scanned At : ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(scannedAt),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      children: [
                        const Text("Goods Koli : ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(goodsKoli.toString()),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      children: [
                        const Text("Goods Weight : ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(goodWeight.toString()),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      children: [
                        const Text("Status : ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(status),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // MaterialButton(
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          //   child: const Text('Back'),
          // )
          // ],
        );
      },
    );
  }

  dialogConfirm4() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("List"),
          content: const Text("Submit"),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Yes'),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Confirmed Delivery List",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              // InkWell(
              //   onTap: () {
              //     fetchData();
              //   },
              //   child:
              RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: const Text(
                  "Refresh",
                ),
                onPressed: () {
                  fetchData();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              // ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 0),
          child: SingleChildScrollView(
              //Padding(
              padding: const EdgeInsets.only(top: 10),
              child: confirmList.isNotEmpty
                  ? SingleChildScrollView(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: ListView.builder(
                          itemCount: confirmList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: MaterialButton(
                                onPressed: () {
                                  dialogConfirm(
                                    confirmList[index]['waybill_number'],
                                    confirmList[index]['origin'],
                                    confirmList[index]['service'],
                                    confirmList[index]['sender_name'],
                                    confirmList[index]['sender_phone'],
                                    confirmList[index]['sender_city'],
                                    confirmList[index]['sender_zipcode'],
                                    confirmList[index]['consignee_name'],
                                    confirmList[index]['consignee_phone'],
                                    confirmList[index]['consignee_zipcode'],
                                    confirmList[index]['consignee_address'],
                                    confirmList[index]['destination'],
                                    confirmList[index]['scanned_at'],
                                    confirmList[index]['goods_koli'],
                                    confirmList[index]['goods_weight'],
                                    confirmList[index]['status'],
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 12),
                                  height: 90,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: const Color(0xFF388EE9)
                                        .withOpacity(0.5),
                                  ),
                                  child: Container(
                                      height: 100,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      decoration: BoxDecoration(
                                          // gradient: LinearGradient(
                                          //     begin: Alignment.centerLeft,
                                          //     end: Alignment.centerRight,
                                          //     colors: <Color>[
                                          //       Color(0xFF1254A0),
                                          //       Color(0xFF15bae8),
                                          //     ]),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            right: 10, left: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.7,
                                                  child: Text(
                                                      confirmList[index]
                                                          ['consignee_name'],
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                    "Status: " +
                                                        confirmList[index]
                                                            ['status'],
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              ],
                                            ),
                                            const Icon(
                                              Icons.check,
                                              color: Colors.green,
                                              size: 20,
                                            ),
                                            const Icon(
                                              Icons.info_outline_rounded,
                                              size: 20,
                                            )
                                          ],
                                        ),
                                      )),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : const Center(child: Text('Tidak ada data'))),
        ),
      ],
    );
  }
}
