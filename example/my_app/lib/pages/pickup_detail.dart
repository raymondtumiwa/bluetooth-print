import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_app/pages/pickup.dart';
import 'package:my_app/pages/pickup_checkout.dart';
import 'package:my_app/pages/pickup_validation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:my_app/models/pickup.dart';
import 'package:my_app/services/onrest.dart';

class PickUpDetail extends StatefulWidget {
  final String bookingId;
  final bool confirmed;

  const PickUpDetail({
    required this.bookingId,
    required this.confirmed,
    Key? key,
  }) : super(key: key);

  @override
  PickupDetailState createState() => PickupDetailState();
}

class PickupDetailState extends State<PickUpDetail> {
  dialogConfirmAssign() {
    return showDialog(
            context: context,
            builder: const _AlertConfirmation(
                    message: 'Apakah ingin mengambil paket ini ?')
                .build)
        .then((status) {
      if (status) {
        setState(() {
          _isInAsyncCall = true;
        });
        return _assignBooking().then((value) {
          _dialogSuccess('Paket Berhasil di Konfirmasi!');
          setState(() {
            _isInAsyncCall = false;
          });
        }).catchError((err) {
          _dialogError('Mohon Selesaikan Pickup Anda Saat Ini !');
          setState(() {
            _isInAsyncCall = false;
          });
        });
      }
      return false;
    });
  }

  dialogConfirmCancel(String type) {
    if (type == "pickup") {
      return showDialog(
              context: context,
              builder: _AlertConfirmationCancel(type: type).build)
          .then((value) {
        print(value);
        if (value['status']) {
          setState(() {
            _isInAsyncCall = true;
          });
          return _cancelPickup(value['message']).then((value) {
            _dialogSuccess('Paket Berhasil di Cancel Pickup !');
            setState(() {
              _isInAsyncCall = false;
            });
          }).catchError((err) {
            _dialogError('Anda Tidak Memiliki Pickup Ini !');
            setState(() {
              _isInAsyncCall = false;
            });
          });
        }
        return false;
      });
    } else {
      return showDialog(
              context: context,
              builder: _AlertConfirmationCancel(type: type).build)
          .then((value) {
        if (value['status']) {
          setState(() {
            _isInAsyncCall = true;
          });
          return _cancelBooking(value['message']).then((value) {
            _dialogSuccess('Paket Berhasil di Cancel Booking !');
            setState(() {
              _isInAsyncCall = false;
            });
          }).catchError((err) {
            _dialogError('Anda Tidak Memiliki Pickup Ini !');
            setState(() {
              _isInAsyncCall = false;
            });
          });
        }
        return false;
      });
    }
  }

  dialogConfirmCheckout(BookingDetail bookingDetail, {BuildContext? context}) {
    return showDialog(
            context: context!,
            builder: const _AlertConfirmation(
                    message: 'Apakah ingin checkout paket ini ?')
                .build)
        .then((value) {
      if (value) {
        setState(() {
          _isInAsyncCall = true;
        });
        List<int> arrTotal =
            bookingDetail.packageInfo.map((e) => e.fixedPrice).toList();
        int totalPrice = arrTotal.reduce((a, b) => a + b);
        return Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PickUpCheckout(
                      bookingDetail: bookingDetail,
                      totalPrice: totalPrice,
                    ))).then((value) {
          if (value) {
            print(PickUp.of(context));
            Navigator.of(context).pop();
          }
        });
      }
      return value;
    });
  }

  late bool _isInAsyncCall = false;
  _dialogSuccess(String message) {
    return showDialog(
      context: context,
      builder: _AlertSuccess(
        message: message,
      ).build,
    );
  }

  _dialogError(String message) {
    // print(error);
    return showDialog(
      context: context,
      builder: _AlertError(
        message: message,
      ).build,
    );
  }

  _generatePackageInfo(BookingDetail? data, [bool status = false]) {
    List<Widget> widget = [];
    for (var i = 0; i < data!.packageInfo.length; i++) {
      widget.add(Container(
          margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.only(
            left: 15,
            top: 15,
          ),
          // color: Colors.white,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 16.0, color: Colors.lightBlue.shade600),
              bottom: BorderSide(width: 16.0, color: Colors.lightBlue.shade900),
            ),
            color: Colors.white,
          ),
          width: MediaQuery.of(context).size.width * 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text("Booking No :",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      data.bookingId,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text("Nama Pengirim :",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      data.packageInfo[i].senderName,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text("No Telp :",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      data.packageInfo[i].senderPhone,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text("Nama Penerima :",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      data.packageInfo[i].receiverName,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text("Alamat Jemput:",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      data.address.fullAddress,
                    ),
                  ),
                  isJobExist && status
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PickUpValidation(
                                            packageInfo:
                                                data.packageInfo[i]))).then(
                                    (value) {
                                  if (value != null) {
                                    setState(() {
                                      data.packageInfo[i] = value;
                                    });
                                    // print(data.packageInfo[i].toJson());
                                  }
                                });
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
                                    child: Text('Validasi Informasi',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 12))),
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                width: MediaQuery.of(context).size.width * 0.3,
                              )))
                      : const Text(""),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                      onPressed: () {
                        launch(
                            'https://www.google.com/maps/search/?api=1&query=' +
                                data.address.lat.toString() +
                                ',' +
                                data.address.long.toString());
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
                        child: Center(
                            child: SvgPicture.asset(
                          'assets/icons/maps.svg',
                          width: 18.0,
                          height: 18.0,
                          color: Colors.white,
                        )),
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.1,
                      )),
                  MaterialButton(
                      onPressed: () {
                        launch("tel://" + data.packageInfo[i].senderPhone);
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
                            child: Icon(Icons.phone, color: Colors.white)),
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.1,
                      )),
                  MaterialButton(
                      onPressed: () {
                        launch("whatsapp://send?phone=" +
                            data.packageInfo[i].senderPhone);
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
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/wa.svg',
                            width: 18.0,
                            height: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.1,
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.095,
                  ),
                  isJobExist && status
                      ? MaterialButton(
                          onPressed: null,
                          child: SizedBox(
                            child: Center(
                              child: Icon(
                                  data.packageInfo[i].status
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank,
                                  color: data.packageInfo[i].status
                                      ? Colors.green
                                      : Colors.grey),
                            ),
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.1,
                          ))
                      : const Text(""),
                ],
              ),
            ],
          )));
    }
    return widget;
  }

  Future<BookingDetail> _fetchDetailPickUp(String bookingId) {
    return _memoizer.runOnce(() async {
      setState(() {
        isLoading = true;
        bookingID = bookingId;
      });
      print(bookingId);
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
        print("erroreee");
        print(e);
        return e;
      });
    });
  }

  Future<bool> _assignBooking() {
    return OnRest.instance
        .assignDriverJob(bookingID)
        .then((value) => value)
        .catchError((e) {
      print("error");
      print(e);
      return e;
    });
  }

  Future<bool> _cancelBooking(String message) {
    return OnRest.instance
        .revokeBooking(message)
        .then((value) => value)
        .catchError((e) {
      print("error");
      print(e);
      return e;
    });
  }

  Future<bool> _cancelPickup(String message) {
    return OnRest.instance
        .cancelDriverJob(message)
        .then((value) => value)
        .catchError((e) {
      print("error");
      print(e);
      return e;
    });
  }

  Future<bool> _checkoutPickUp(String message) {
    return OnRest.instance
        .cancelDriverJob(message)
        .then((value) => value)
        .catchError((e) {
      print("error");
      print(e);
      return e;
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
  String bookingID = "";

  Widget _buttonCond(bool isConfirmed, AsyncSnapshot<BookingDetail> snapshot) {
    Widget button;
    if (isConfirmed) {
      button = Row(
        children: [
          MaterialButton(
              onPressed: () {
                isJobExist
                    ? dialogConfirmCancel('pickup')
                    : _dialogError('Anda Tidak Memiliki Pickup Ini !');
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: <Color>[
                        Colors.red.shade800,
                        Colors.red.shade200,
                      ]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                    child: Text('Cancel Pickup',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 12))),
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.23,
              )),
          MaterialButton(
              onPressed: () {
                isJobExist
                    ? dialogConfirmCancel('booking')
                    : _dialogError('Anda Tidak Memiliki Pickup Ini !');
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: <Color>[
                        Colors.red.shade800,
                        Colors.red.shade200,
                      ]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                    child: Text('Cancel Booking',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 12))),
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.23,
              )),
          MaterialButton(
              onPressed: () {
                // isJobExist &&
                //         snapshot.data!.packageInfo.length ==
                //             snapshot.data!.packageInfo
                //                 .where((e) => e.status)
                //                 .length
                //     ? dialogConfirmCheckout(snapshot.data!, context: context)
                //     : _dialogError('Mohon Validasi Packet Terlebih Dahulu !');
                Navigator.pushNamed(context, '/print');
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: snapshot.data!.packageInfo.length ==
                              snapshot.data!.packageInfo
                                  .where((e) => e.status)
                                  .length
                          ? <Color>[
                              const Color(0xFF1254A0),
                              const Color(0xFF15bae8),
                            ]
                          : <Color>[
                              Colors.grey.shade800,
                              Colors.grey.shade400,
                            ]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                    child: Text('Checkout',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 12))),
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.23,
              ))
        ],
      );
    } else {
      button = MaterialButton(
          onPressed: () {
            !isJobExist
                ? dialogConfirmAssign()
                : _dialogError('Mohon Selesaikan Pickup Anda Saat Ini !');
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
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.5,
          ));
    }
    return button;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: const Text("Details"),
      ),
      body: ModalProgressHUD(
        child: FutureBuilder<BookingDetail>(
            future: _fetchDetailPickUp(widget
                .bookingId), // a previously-obtained Future<String> or null
            builder:
                (BuildContext context, AsyncSnapshot<BookingDetail> snapshot) {
              Widget widgetBuilder;
              if (snapshot.hasData) {
                widgetBuilder = Container(
                    color: Colors.grey[200],
                    height: MediaQuery.of(context).size.height,
                    // width: MediaQuery.of(context).size.width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text("Informasi Paket",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: _generatePackageInfo(
                                          snapshot.data, widget.confirmed),
                                    )
                                  ],
                                ),
                              )),
                          _buttonCond(widget.confirmed, snapshot),
                        ],
                      ),
                    ));
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
            }),
        inAsyncCall: _isInAsyncCall,
        // demo of some additional parameters
        opacity: 0.5,
        progressIndicator: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            CircularProgressIndicator.adaptive(),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Loading ...'),
            )
          ],
        ),
      ),
    );
  }
}

class _AlertSuccess extends StatelessWidget {
  const _AlertSuccess({
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Berhasil"),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.15,
        child: Column(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            Text(message)
          ],
        ),
      ),
      actions: [
        Center(
          child: MaterialButton(
              onPressed: () {
                Navigator.of(context)
                  ..pop()
                  ..pop();
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
  }
}

class _AlertError extends StatelessWidget {
  const _AlertError({
    required this.message,
  });

  final String message;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Error"),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.16,
        child: Column(
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 70),
            Center(child: Text(message))
          ],
        ),
      ),
      actions: [
        Center(
          child: MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
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
                    child: Text('Ok',
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
  }
}

class _AlertConfirmation extends StatelessWidget {
  const _AlertConfirmation({
    required this.message,
  });

  final String message;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Konfirmasi"),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.15,
        child: Column(
          children: [
            const Icon(Icons.help, color: Colors.grey, size: 70),
            Text(message)
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: <Color>[
                          Colors.red.shade800,
                          Colors.red.shade200,
                        ]),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                      child: Text('No',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 14))),
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.3,
                )),
            MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
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
                      child: Text('Yes',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 14))),
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.3,
                ))
          ],
        ),
      ],
    );
  }
}

class _AlertConfirmationCancel extends StatelessWidget {
  _AlertConfirmationCancel({
    required this.type,
  });
  final _formKey = GlobalKey<FormState>();
  final String type;
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Konfirmasi"),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.17,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon(Icons.check_circle, color: Colors.green, size: 80),
            Text("Apakah Yakin Untuk Cancel " +
                type.split('').first.toUpperCase() +
                type.split('').getRange(1, type.split('').length).join() +
                " Ini ? "),

            const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text("Alasan"),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _controller,
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Mohon Isi Alasan Terlebih Dahulu';
                        }
                        return null;
                      },
                    ),
                  ],
                ))
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop({'status': false});
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: <Color>[
                          Colors.red.shade800,
                          Colors.red.shade200,
                        ]),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                      child: Text('No',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 14))),
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.3,
                )),
            MaterialButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.

                    Navigator.of(context)
                        .pop({'status': true, 'message': _controller.text});
                  }
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
                      child: Text('Yes',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 14))),
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.3,
                ))
          ],
        ),
      ],
    );
  }
}
