import 'package:flutter/material.dart';
import 'package:my_app/pages/details.dart';
import 'package:my_app/services/onrest.dart';
// import 'package:giffy_dialog/giffy_dialog.dart';
import '../services/globals.dart' as globals;
import 'dart:async';

class DeliveryList extends StatefulWidget {
  @override
  _DeliveryListState createState() => _DeliveryListState();
}

class _DeliveryListState extends State<DeliveryList> {
  var deliveryList = [];
  bool isValid = false;
  int? itemCount;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    fetchData("");
  }

  TextEditingController _filter = new TextEditingController();

  _onSearchChanged(String query) {
    print("=====");
    print(query);
    print("=====");
    // _postsController.add(jsonEncode({"restart": true}));
    setState(() {
      // orderan = [];
      // paginateQuery['pageIndex'] = 0;
      // indexPage = 0;
    });
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 1200), () {
      if (query != "" || query == null) {
        print("cc");
        print(query);
        setState(() {
          // paginateQuery['search'] = {'prefix': prefix, 'searchQuery': ''};
          // paginateQuery['search']['searchQuery'] = query;
          fetchData(query);
        });
      } else {
        setState(() {
          // paginateQuery['search'] = null;
          fetchData("");
        });
      }
      // channel.add(jsonEncode(paginateQuery));
    });
  }

  void fetchData(String waybill) {
    print("11111111");
    print(waybill);
    print("11111111");
    OnRest.instance
        .listDelivery(globals.agentLocId, globals.courierId, waybill)
        .then((value) {
      if (value != null) {
        setState(() {
          deliveryList = value;
          // isValid = true;
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
  // dialogConfirm(
  //   String waybillNumber,
  //   String origin,
  //   String service,
  //   String senderName,
  //   String senderPhone,
  //   String sendeCity,
  //   String senderZipcode,
  //   String consigneeName,
  //   String consigneePhone,
  //   String consigneeZipcode,
  //   String consigneeAddress,
  //   String destination,
  //   String scannedAt,
  //   var goodsKoli,
  //   var goodWeight,
  //   String status,
  // ) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text("My title"),

  //         // MaterialButton(
  //         //   onPressed: () {
  //         //     Navigator.pop(context);
  //         //   },
  //         //   child: const Text('Back'),
  //         // )
  //         // ],
  //       );
  //     },
  //   );
  // }

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
  void dispose() {
    super.dispose();
    _debounce?.cancel();
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              controller: _filter,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                  hintText: 'Search...', hintStyle: TextStyle(fontSize: 12)),
            )),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Delivery List",
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
                  fetchData("");
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              // ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Text(
            globals.courierId,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 0),
          child: SingleChildScrollView(
              //Padding(
              padding: const EdgeInsets.only(top: 10),
              child: deliveryList.isNotEmpty
                  ? SingleChildScrollView(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: ListView.builder(
                          itemCount: deliveryList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: MaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailsPage(
                                                deliveryList[index]
                                                    ['waybill_number'],
                                                deliveryList[index]['origin'],
                                                deliveryList[index]['service'],
                                                deliveryList[index]
                                                    ['sender_name'],
                                                deliveryList[index]
                                                    ['sender_phone'],
                                                deliveryList[index]
                                                    ['sender_city'],
                                                deliveryList[index]
                                                    ['sender_zipcode'],
                                                deliveryList[index]
                                                    ['consignee_name'],
                                                deliveryList[index]
                                                    ['consignee_phone'],
                                                deliveryList[index]
                                                    ['consignee_zipcode'],
                                                deliveryList[index]
                                                    ['consignee_address'],
                                                deliveryList[index]
                                                    ['destination'],
                                                deliveryList[index]
                                                    ['scanned_at'],
                                                deliveryList[index]
                                                    ['goods_koli'],
                                                deliveryList[index]
                                                    ['goods_weight'],
                                                deliveryList[index]['status'],
                                              )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Container(
                                      padding: EdgeInsets.only(left: 12),
                                      height: 90,
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
                                          color: const Color(0xFF388EE9)
                                              .withOpacity(0.5),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: Offset(0, 3))
                                          ]),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                            color: Colors.white),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
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
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.7,
                                                    child: Text(
                                                        deliveryList[index]
                                                            ['consignee_name'],
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                      "Telp: " +
                                                          deliveryList[index][
                                                              'consignee_phone'],
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                ],
                                              ),
                                              const Icon(
                                                Icons.arrow_right,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : const Text(
                      'Tidak ada data',
                    )),
        ),
      ],
    );
  }
}
