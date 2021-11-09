import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:blue/models/pickup.dart';
import 'package:blue/pages/pickup_detail.dart';
// import 'package:giffy_dialog/giffy_dialog.dart';
import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class PickUpListComponent extends StatefulWidget {
  @override
  _PickUpListComponentState createState() => _PickUpListComponentState();
}

class StreamSocket {
  final _socketResponse = StreamController<String>();

  void Function(String) get addResponse => _socketResponse.sink.add;

  Stream<String> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}

class _PickUpListComponentState extends State<PickUpListComponent> {
  get bottomNavigationBar => null;

  List<Booking> bookings = [];
  // StreamSocket streamSocket = StreamSocket();

  //STEP2: Add this function in main function in main.dart file and add incoming data to the stream
  void connectAndListen() {
    IO.Socket socket = IO.io(
        'https://apisat.ondelivery.id',
        OptionBuilder().setPath('/booking/delivery/socket/').setQuery({
          'room':
              '1:DC_KOTA:PICKUP_ROOM,1:OMA_KECAMATAN:PICKUP_ROOM,1:OPA_KECAMATAN:PICKUP_ROOM,1:OPA_KELURAHAN:PICKUP_ROOM'
        }).setTransports(['websocket']).build());
    socket.onError((data) => print(data.toString()));
    socket.onConnect((_) {
      print('connect');
    });

    //When an event recieved from server, data is added to the stream
    socket.on('list_data', (data) {
      print(bookings.length);
      setState(() {
        bookings = (data as List).map((e) {
          return Booking.fromJson(e);
        }).toList();
      });
    });
    socket.onDisconnect((_) => print('disconnect'));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connectAndListen();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.04,
              child: Padding(
                padding: const EdgeInsets.only(top: 7),
                child: Text('Pickup List',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              )),
          Container(
            child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 0),
                child: bookings.isNotEmpty
                    ? SingleChildScrollView(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.785,
                          child: ListView.builder(
                            itemCount: bookings.length,
                            itemBuilder: (BuildContext context, int index) {
                              return MaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PickUpDetail(
                                                bookingId:
                                                    bookings[index].bookingId,
                                              )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Container(
                                      padding: const EdgeInsets.only(left: 15),
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      decoration: BoxDecoration(
                                          // gradient: const LinearGradient(
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
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.7,
                                                    child: Text(
                                                        bookings[index]
                                                            .fullAddress,
                                                        style: const TextStyle(
                                                            fontSize: 16,
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
                                                          bookings[index]
                                                              .phoneNumber,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                  Text(
                                                      bookings[index].bookingId,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                  Text(
                                                      bookings[index].createdAt,
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
                          ),
                        ),
                      )
                    : const Center(
                        child: Text('HAHAHA'),
                      )),
          ),
        ],
      ),
    );
  }
}
