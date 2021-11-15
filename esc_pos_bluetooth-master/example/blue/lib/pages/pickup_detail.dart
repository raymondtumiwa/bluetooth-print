import 'package:flutter/material.dart';
import 'package:blue/models/pickup.dart';
import 'package:blue/pages/pickup.dart';
import 'package:blue/services/onrest.dart';
import '../services/globals.dart' as globals;
import 'dart:async';
import 'package:async/async.dart';

class PickUpDetail extends StatefulWidget {
  final String bookingId;

  const PickUpDetail({
    required this.bookingId,
    Key? key,
  }) : super(key: key);

  @override
  PickupDetailState createState() => PickupDetailState();
}

class PickupDetailState extends State<PickUpDetail> {
  dialogConfirm4() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Berhasil"),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.15,
            child: Column(
              children: const [
                Icon(Icons.check_circle, color: Colors.green, size: 80),
                Text("Paket berhasil di konfermasi")
              ],
            ),
          ),
          actions: [
            Center(
              child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/pickup');
                  },
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
                    child: const Center(
                        child: Text('Selesai',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 14))),
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.5,
                  )),
            ),
          ],
        );
      },
    );
  }

  Future<BookingDetail> _fetchDetailPickUp(String bookingId) {
    return this._memoizer.runOnce(() async {
      setState(() {
        isLoading = true;
      });
      return OnRest.instance.getBookingDetail(bookingId).then((value) async {
        StatusDriver driver = await OnRest.instance.getStatusDriver();
        print(driver.bookingId);
        if (driver.bookingId != "") {
          setState(() {
            isJobExist = true;
          });
        }
        print(isJobExist);
        setState(() {
          isLoading = false;
        });
        return value;
      }).catchError((e) {
        print("error");
        print(e);
        return e;
      });
    });
  }

  late AsyncMemoizer<BookingDetail> _memoizer;

  @override
  void initState() {
    super.initState();
    _memoizer = AsyncMemoizer();
  }

  bool isLoading = true;
  bool isJobExist = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
          title: const Text("Details"),
        ),
        body: FutureBuilder<BookingDetail>(
            future: _fetchDetailPickUp(widget
                .bookingId), // a previously-obtained Future<String> or null
            builder:
                (BuildContext context, AsyncSnapshot<BookingDetail> snapshot) {
              Widget widgetBuilder;
              if (snapshot.hasData) {
                widgetBuilder = Container(
                    height: MediaQuery.of(context).size.height,
                    // width: MediaQuery.of(context).size.width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 25),
                      child: Column(
                        children: [
                          Container(
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.76,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Pengirim",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text("Waybill Number: ",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey)),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      const Text("JKT",
                                          style: TextStyle(fontSize: 14)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text("Orgin:",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey)),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      const Text("DC",
                                          style: TextStyle(fontSize: 14)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text("Service: ",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey)),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      const Text("45",
                                          style: TextStyle(fontSize: 14)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text("Sender Name: ",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey)),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      const Text("ABDUL",
                                          style: TextStyle(fontSize: 14)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text("Sender Phone: ",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey)),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      const Text("0813",
                                          style: TextStyle(fontSize: 14)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text("Sender City: ",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey)),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      const Text("Jakarta",
                                          style: TextStyle(fontSize: 14)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text("Sender Zipcode: ",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey)),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      const Text("14240",
                                          style: TextStyle(fontSize: 14)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Divider(
                                        thickness: 1,
                                      ),
                                      const Text(
                                        "Penerima",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text("Consignee Name: ",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey)),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      const Text("DIMAZ",
                                          style: TextStyle(fontSize: 14)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text("Consignee Phone: ",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey)),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      const Text("081311356789",
                                          style: TextStyle(fontSize: 14)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text("Consignee Zipcode: ",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey)),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      const Text("14240",
                                          style: TextStyle(fontSize: 14)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text("Consignee Address: ",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey)),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      const Text("JL.B",
                                          style: TextStyle(fontSize: 14)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text("Destination: ",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey)),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      const Text("JKT111145",
                                          style: TextStyle(fontSize: 14)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text("Scanned at: ",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey)),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      const Text("2021-11",
                                          style: TextStyle(fontSize: 14)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Divider(
                                              thickness: 1,
                                            ),
                                            Text("Goods Koli : ",
                                                style: TextStyle(
                                                    // fontWeight: FontWeight.bold,
                                                    fontSize: 13,
                                                    color: Colors.grey)),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text("1",
                                                style: TextStyle(fontSize: 14)),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                          MaterialButton(
                              onPressed: () {
                                dialogConfirm4();
                              },
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
                                child: const Center(
                                    child: Text('Konfirmasi',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 14))),
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                width: MediaQuery.of(context).size.width * 0.5,
                              )),
                        ],
                      ),
                    ));

                SizedBox(height: MediaQuery.of(context).size.height * 0.03);
                //MaterialButton

              } else if (snapshot.hasError) {
                widgetBuilder = Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text('Error: ${snapshot.error}'),
                      )
                    ],
                  ),
                );
              } else {
                widgetBuilder = Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const <Widget>[
                      SizedBox(
                        child: CircularProgressIndicator(),
                        width: 60,
                        height: 60,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Awaiting result...'),
                      )
                    ],
                  ),
                );
              }
              return widgetBuilder;
            }));
  }
}
