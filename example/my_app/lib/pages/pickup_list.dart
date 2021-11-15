import 'package:flutter/material.dart';
import 'package:my_app/models/pickup.dart';
import 'package:my_app/pages/pickup_detail.dart';
import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PickUpList extends StatefulWidget {
  @override
  _PickUpListState createState() => _PickUpListState();
}

class _PickUpListState extends State<PickUpList> {
  @override
  void initState() {
    super.initState();
    connectAndListen();
  }

  bool isLoading = false;
  late IO.Socket socket = IO.io(
      'https://apisat.ondelivery.id',
      IO.OptionBuilder()
          .setPath('/booking/delivery/socket/')
          .setQuery({
            'room':
                '1:DC_KOTA:PICKUP_ROOM,1:OMA_KECAMATAN:PICKUP_ROOM,1:OPA_KECAMATAN:PICKUP_ROOM,1:OPA_KELURAHAN:PICKUP_ROOM'
          })
          .disableAutoConnect()
          .setTransports(['websocket'])
          .build());
  List<Booking> bookings = [];

  void connectAndListen() {
    if (!socket.connected) {
      setState(() {
        isLoading = true;
      });
    } else {
      socket.io
        ..disconnect()
        ..connect();
    }

    socket.connect();
    // socket.query[''] = "";
    socket.onError((data) => print(data.toString()));
    socket.onConnect((_) {
      print('connect');
    });

    //When an event recieved from server, data is added to the stream
    socket.on('list_data', (data) {
      setState(() {
        bookings = (data as List).map((e) {
          return Booking.fromJson(e);
        }).toList();
        isLoading = false;
      });
    });
    socket.onDisconnect((_) => print('disconnect'));
  }

  @override
  void dispose() {
    super.dispose();
    socket.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Padding(
    //     padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
    //     child: StaggeredGridView.countBuilder(
    //         shrinkWrap: true,
    //         mainAxisSpacing: 3,
    //         crossAxisSpacing: 3,
    //         staggeredTileBuilder: (int index) => const StaggeredTile.fit(3),
    //         crossAxisCount: 2,
    //         itemCount: bookings.length,
    //         itemBuilder: _getChild));
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.745,
        child: !isLoading
            ? bookings.isNotEmpty
                ? ListView.builder(
                    itemCount: bookings.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PickUpDetail(
                                        bookingId: bookings[index].bookingId,
                                        confirmed: false,
                                      )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                                  color:
                                      const Color(0xFF388EE9).withOpacity(0.5),
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
                                                bookings[index].fullAddress,
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
                                                  bookings[index].phoneNumber,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400)),
                                          Text(bookings[index].bookingId,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400)),
                                          Text(bookings[index].createdAt,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400)),
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
                  )
                : Center(
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
                  )
            : Center(
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
              ),
      ),
    );
  }
}
