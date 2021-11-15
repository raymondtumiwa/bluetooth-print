import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:my_app/models/pickup.dart';
import 'package:my_app/services/onrest.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class PickUpCheckout extends StatefulWidget {
  final BookingDetail bookingDetail;
  final int totalPrice;
  const PickUpCheckout(
      {required this.bookingDetail, required this.totalPrice, Key? key})
      : super(key: key);

  @override
  _PickUpCheckoutState createState() => _PickUpCheckoutState();
}

class _PickUpCheckoutState extends State<PickUpCheckout> {
  late bool _isInAsyncCall = false;
  @override
  void initState() {
    super.initState();
  }

  late String _value = "CASH";
  late bool afterCheckout = false;
  late bool isConfirmed = false;

  late IO.Socket socket = IO.io(
      OnRest.instance.apiUS,
      IO.OptionBuilder()
          .setPath('/payment/status/agent/socket')
          .setQuery({'invoice': ''})
          .disableAutoConnect()
          .setTransports(['websocket'])
          .build());

  void connectAndListen() {
    socket.connect();
    // socket.query[''] = "";
    socket.onError((data) => print(data.toString()));
    socket.onConnect((_) {
      print('connect');
    });

    //When an event recieved from server, data is added to the stream
    socket.on('invoice_status', (data) {
      print(data);
    });
    socket.emit('refresh_status');

    socket.onDisconnect((_) => print('disconnect'));
  }

  paymentConfirmation(CheckOutDriverBody body) {
    return OnRest.instance.checkoutDriver(body).then((value) {
      print(value);
      if (_value == "XENDIT") {
        connectAndListen();
        setState(() {
          afterCheckout = true;
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    WebViewXendit(urlXendit: value.paymentUrl!))).then((value) {
          setState(() {
            _isInAsyncCall = false;
          });
        });
      } else {
        Navigator.of(context).pop(true);
        setState(() {
          _isInAsyncCall = false;
        });
      }
    }).catchError((errCheck) {
      print("Checkout Error");
      print(errCheck);
      setState(() {
        _isInAsyncCall = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return afterCheckout ? false : true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
          title: const Text("Checkout"),
        ),
        body: ModalProgressHUD(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: !afterCheckout
                  ? Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.78,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Padding(
                                      padding: EdgeInsets.only(top: 15),
                                      child: Text("Total Pembayaran :",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold))),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Text(
                                          "Rp. " + widget.totalPrice.toString(),
                                          style: const TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold))),
                                  const Padding(
                                      padding: EdgeInsets.only(top: 15),
                                      child: Text("Metode Pembayaran :",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold))),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Column(
                                      children: <Widget>[
                                        ListTile(
                                            title: const Text('Cash'),
                                            horizontalTitleGap: -10,
                                            visualDensity: const VisualDensity(
                                                horizontal: 0, vertical: -4),
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            leading: Radio(
                                              value: 'CASH',
                                              groupValue: _value,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _value = value!;
                                                });
                                              },
                                            )),
                                        ListTile(
                                            title: const Text('Balance'),
                                            horizontalTitleGap: -10,
                                            visualDensity: const VisualDensity(
                                                horizontal: 0, vertical: -4),
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            leading: Radio(
                                              value: 'BALANCE',
                                              groupValue: _value,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _value = value!;
                                                });
                                              },
                                            )),
                                        ListTile(
                                            title: const Text('Cashless'),
                                            horizontalTitleGap: -10,
                                            visualDensity: const VisualDensity(
                                                horizontal: 0, vertical: -4),
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            leading: Radio(
                                              value: 'XENDIT',
                                              groupValue: _value,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _value = value!;
                                                });
                                              },
                                            ))
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Semantics(
                                        label:
                                            'image_picker_example_picked_image',
                                        child: Image.file(File(widget
                                            .bookingDetail
                                            .packageInfo[0]
                                            .image!
                                            .path)),
                                      )
                                    ],
                                  )
                                ])),
                        MaterialButton(
                            onPressed: () {
                              setState(() {
                                _isInAsyncCall = true;
                              });
                              OnRest.instance.pingServerApiSat().then((value) {
                                OnRest.instance
                                    .pingServerApiOndel()
                                    .then((value) {
                                  CheckOutDriverBody body =
                                      CheckOutDriverBody.fromJson({
                                    'amount': widget.totalPrice,
                                    'service': 'ONDELIVERY',
                                    'source': _value,
                                    'client': widget.bookingDetail.user
                                  });
                                  paymentConfirmation(body);
                                }).catchError((errOndel) {
                                  print("ApiOndel Error");
                                  print(errOndel);
                                  setState(() {
                                    _isInAsyncCall = false;
                                  });
                                });
                              }).catchError((errApisat) {
                                print("ApiSat Error");
                                print(errApisat);
                                setState(() {
                                  _isInAsyncCall = false;
                                });
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
                                  child: Text('Bayar',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 12))),
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.23,
                            )),
                      ],
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          // const SizedBox(
                          //   width: 120,
                          // ),
                          SizedBox(
                            child: isConfirmed
                                ? const Icon(Icons.check_circle,
                                    color: Colors.green)
                                : const CircularProgressIndicator(),
                            width: 60,
                            height: 60,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text('Waiting Confirmation'),
                          )
                        ],
                      ),
                    )),
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
      ),
    );
  }
}

class WebViewXendit extends StatefulWidget {
  final String urlXendit;
  const WebViewXendit({required this.urlXendit, Key? key}) : super(key: key);

  @override
  _WebViewXenditState createState() => _WebViewXenditState();
}

class _WebViewXenditState extends State<WebViewXendit> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('QRIS')),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        actions: <Widget>[
          NavigationControls(_controller.future),
        ],
      ),
      // We're using a Builder here so we have a context that is below the Scaffold
      // to allow calling Scaffold.of(context) so we can show a snackbar.
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: widget.urlXendit,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onProgress: (int progress) {
            print("WebView is loading (progress : $progress%)");
          },
          javascriptChannels: <JavascriptChannel>{
            _toasterJavascriptChannel(context),
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              print('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
        );
      }),
      floatingActionButton: favoriteButton(),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  Widget favoriteButton() {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> controller) {
          if (controller.hasData) {
            return FloatingActionButton(
              onPressed: () async {
                final String url = (await controller.data!.currentUrl())!;
                // ignore: deprecated_member_use
                Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Favorited $url')),
                );
              },
              child: const Icon(Icons.favorite),
            );
          }
          return Container();
        });
  }
}

enum MenuOptions {
  showUserAgent,
  listCookies,
  clearCookies,
  addToCache,
  listCache,
  clearCache,
  navigationDelegate,
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController? controller = snapshot.data;
        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: !webViewReady
                  ? null
                  : () {
                      controller!.reload();
                    },
            ),
          ],
        );
      },
    );
  }
}
