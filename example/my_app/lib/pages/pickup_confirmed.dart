import 'package:flutter/material.dart';
import 'package:my_app/models/pickup.dart';
import 'package:my_app/pages/pickup_detail.dart';
import 'package:my_app/services/onrest.dart';
import '../services/globals.dart' as globals;
import 'dart:async';
import 'package:async/async.dart';

class PickUpConfirmed extends StatefulWidget {
  @override
  PickUpConfirmedState createState() => PickUpConfirmedState();
}

class PickUpConfirmedState extends State<PickUpConfirmed> {
  Future<dynamic> _fetchCorfirmedBooking() {
    return _memoizer.runOnce(() async {
      setState(() {
        isLoading = true;
      });
      return OnRest.instance.getStatusDriver().then((driver) async {
        if (driver.bookingId != "") {
          setState(() {
            bookingId = driver.bookingId;
          });
          return OnRest.instance
              .getBookingDetail(driver.bookingId)
              .then((value) => value);
        } else {
          return false;
        }
      }).catchError((e) {
        print("error");
        print(e);
        return e;
      });
    });
  }

  late AsyncMemoizer<dynamic> _memoizer;

  @override
  void initState() {
    super.initState();
    _memoizer = AsyncMemoizer();
  }

  bool isLoading = true;
  bool isJobExist = false;
  String bookingId = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: FutureBuilder<dynamic>(
              future:
                  _fetchCorfirmedBooking(), // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                Widget widgetBuilder;
                if (snapshot.hasData) {
                  print(snapshot.data);
                  print(snapshot.data is BookingDetail);
                  if (snapshot.data is BookingDetail) {
                    BookingDetail bookingDetail = snapshot.data;
                    print(bookingDetail);
                    widgetBuilder = ListView.builder(
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PickUpDetail(
                                            bookingId: bookingId,
                                            confirmed: true)))
                                .then((value) => setState(() {
                                      _memoizer = AsyncMemoizer();
                                    }));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Container(
                                padding: const EdgeInsets.only(left: 15),
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: <Color>[
                                          Color(0xFF1254A0),
                                          Color(0xFF15bae8),
                                        ]),
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xFF388EE9)
                                        .withOpacity(0.5),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0, 3))
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
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.7,
                                              child: Text(
                                                  bookingDetail
                                                      .address.fullAddress,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                                "Telp: " +
                                                    bookingDetail.phoneNumber,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            Text(bookingId,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            Text(bookingDetail.timestamp,
                                                style: const TextStyle(
                                                    fontSize: 14,
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
                        );
                      },
                    );
                  } else {
                    widgetBuilder = Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const <Widget>[
                          Icon(
                            Icons.table_chart_sharp,
                            color: Colors.red,
                            size: 60,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text('Empty'),
                          )
                        ],
                      ),
                    );
                  }
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
              })),
    );
  }
}
