import 'package:flutter/material.dart';
import 'package:my_app/pages/validasi_pickup.dart';
import 'package:url_launcher/url_launcher.dart';

class ConfirmedPickUpDetail extends StatefulWidget {
  @override
  _ConfirmedPickUpDetailState createState() => _ConfirmedPickUpDetailState();
}

class _ConfirmedPickUpDetailState extends State<ConfirmedPickUpDetail> {
  void _launchMapsUrl() async {
    double lat = -6.1597996;
    double lon = 106.9050171;
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void dialogLoading() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: MediaQuery.of(context).size.height * 0.08,
            width: MediaQuery.of(context).size.width * 0.3,
            child: Column(
              children: const [CircularProgressIndicator(), Text('Loading')],
            ),
          ),
        );
      },
    );
  }

  var whatsappUrl = "whatsapp://send?phone=+6287754161578";

  dialogConfirm4() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                child: Icon(Icons.cancel),
                //child: Text('batal'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.15,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Hubungi pengirim",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ))
                ],
              ),
            ),
          ),
          actions: [
            Center(
              child: Column(
                children: [
                  MaterialButton(
                      onPressed: () {
                        //Navigator.pushNamed(context, '/pickup');
                        launch("tel://+6287754161578");
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
                            child: Text('NO telp',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 14))),
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.5,
                      )),
                  MaterialButton(
                      onPressed: () async {
                        //Navigator.pushNamed(context, '/pickup');
                        await launch(whatsappUrl);
                        // canLaunch(whatsappUrl)
                        //     ?  : print(
                        //         "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
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
                            child: Text('Whatsapp',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 14))),
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.5,
                      )),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // Future<BookingDetail> _fetchDetailPickUp(String bookingId) {
  //   return this._memoizer.runOnce(() async {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     return OnRest.instance.getBookingDetail(bookingId).then((value) async {
  //       StatusDriver driver = await OnRest.instance.getStatusDriver();
  //       print(driver.bookingId);
  //       if (driver.bookingId != "") {
  //         setState(() {
  //           isJobExist = true;
  //         });
  //       }
  //       print(isJobExist);
  //       setState(() {
  //         isLoading = false;
  //       });
  //       return value;
  //     }).catchError((e) {
  //       print("error");
  //       print(e);
  //       return e;
  //     });
  //   });
  // }

  // late AsyncMemoizer<BookingDetail> _memoizer;

  // @override
  // void initState() {
  //   super.initState();
  //   _memoizer = AsyncMemoizer();
  // }

  bool isLoading = true;
  bool isJobExist = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
          title: const Text("Details"),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            // width: MediaQuery.of(context).size.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: Container(
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.745,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                        fontSize: 13, color: Colors.grey)),
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
                                        fontSize: 13, color: Colors.grey)),
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
                                        fontSize: 13, color: Colors.grey)),
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
                                        fontSize: 13, color: Colors.grey)),
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
                                        fontSize: 13, color: Colors.grey)),
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
                                        fontSize: 13, color: Colors.grey)),
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
                                        fontSize: 13, color: Colors.grey)),
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
                                        fontSize: 13, color: Colors.grey)),
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
                                        fontSize: 13, color: Colors.grey)),
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
                                        fontSize: 13, color: Colors.grey)),
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
                                        fontSize: 13, color: Colors.grey)),
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
                                        fontSize: 13, color: Colors.grey)),
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
                                        fontSize: 13, color: Colors.grey)),
                                const SizedBox(
                                  height: 3,
                                ),
                                const Text("2021-11",
                                    style: TextStyle(fontSize: 14)),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
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
                                      Text("1", style: TextStyle(fontSize: 14)),
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
                  ),
                  Container(
                    color: Colors.grey[100],
                    height: MediaQuery.of(context).size.height * 0.09,
                    child:
                        //   color: Colors.red,
                        // )
                        Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.phone,
                              ),
                              iconSize: 30,
                              color: Colors.blue,
                              splashColor: Colors.purple,
                              onPressed: () {
                                dialogConfirm4();
                              },
                            ),
                            Text("Telephone")
                          ],
                        ),
                        Container(color: Colors.black, width: 0.5, height: 50),

                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.map,
                              ),
                              iconSize: 30,
                              color: Colors.green,
                              onPressed: () async {
                                //dialogConfirm4();

                                double lat = -6.1597996;
                                double lon = 106.9050171;
                                await launch(
                                    'https://www.google.com/maps/search/?api=1&query=$lat,$lon');
                              },
                            ),
                            Text("Lokasi")
                          ],
                        ),
                        Container(color: Colors.black, width: 0.5, height: 50),

                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.details),
                              iconSize: 30,
                              color: Colors.yellow,
                              splashColor: Colors.purple,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ValidasiPickup()));
                              },
                            ),
                            Text("Validasi")
                          ],
                        ),
                        Container(color: Colors.black, width: 0.5, height: 50),

                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.cancel,
                              ),
                              iconSize: 30,
                              color: Colors.red,
                              splashColor: Colors.purple,
                              onPressed: () {
                                dialogConfirm4();
                              },
                            ),
                            Text("Batal")
                          ],
                        ),
                        // MaterialButton(
                        //     onPressed: () {
                        //       dialogConfirm4();
                        //     },
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //         gradient: const LinearGradient(
                        //             begin: Alignment.centerLeft,
                        //             end: Alignment.centerRight,
                        //             colors: <Color>[
                        //               Color(0xFF1254A0),
                        //               Color(0xFF15bae8),
                        //             ]),
                        //         borderRadius: BorderRadius.circular(10),
                        //       ),
                        //       child: const Center(
                        //           child: Text('Tombol\nPengirim',
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.bold,
                        //                   color: Colors.white,
                        //                   fontSize: 12))),
                        //       height:
                        //           MediaQuery.of(context).size.height * 0.05,
                        //       width:
                        //           MediaQuery.of(context).size.width * 0.2,
                        //     )),
                        // MaterialButton(
                        //     onPressed: () {
                        //       dialogConfirm4();
                        //     },
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //         gradient: const LinearGradient(
                        //             begin: Alignment.centerLeft,
                        //             end: Alignment.centerRight,
                        //             colors: <Color>[
                        //               Color(0xFF1254A0),
                        //               Color(0xFF15bae8),
                        //             ]),
                        //         borderRadius: BorderRadius.circular(10),
                        //       ),
                        //       child: const Center(
                        //           child: Text('Buka\nmaps',
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.bold,
                        //                   color: Colors.white,
                        //                   fontSize: 12))),
                        //       height:
                        //           MediaQuery.of(context).size.height * 0.05,
                        //       width:
                        //           MediaQuery.of(context).size.width * 0.2,
                        //     )),
                        // MaterialButton(
                        //     onPressed: () {
                        //       dialogConfirm4();
                        //     },
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //         gradient: const LinearGradient(
                        //             begin: Alignment.centerLeft,
                        //             end: Alignment.centerRight,
                        //             colors: <Color>[
                        //               Color(0xFF1254A0),
                        //               Color(0xFF15bae8),
                        //             ]),
                        //         borderRadius: BorderRadius.circular(10),
                        //       ),
                        //       child: const Center(
                        //           child: Text('Validasi informasi',
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.bold,
                        //                   color: Colors.white,
                        //                   fontSize: 12))),
                        //       height:
                        //           MediaQuery.of(context).size.height * 0.05,
                        //       width:
                        //           MediaQuery.of(context).size.width * 0.1,
                        //     )),
                        // MaterialButton(
                        //     onPressed: () {
                        //       dialogLoading();
                        //     },
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //         gradient: const LinearGradient(
                        //             begin: Alignment.centerLeft,
                        //             end: Alignment.centerRight,
                        //             colors: <Color>[
                        //               Color(0xFF1254A0),
                        //               Color(0xFF15bae8),
                        //             ]),
                        //         borderRadius: BorderRadius.circular(10),
                        //       ),
                        //       child: const Center(
                        //           child: Text('Cancel pickup',
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.bold,
                        //                   color: Colors.white,
                        //                   fontSize: 12))),
                        //       height:
                        //           MediaQuery.of(context).size.height * 0.05,
                        //       width:
                        //           MediaQuery.of(context).size.width * 0.1,
                        //     )),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
