import 'package:flutter/material.dart';

class ValidasiPickup extends StatefulWidget {
  @override
  _ValidasiPickupState createState() => _ValidasiPickupState();
}

class _ValidasiPickupState extends State<ValidasiPickup> {
  TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var inputReason = TextFormField(
      autofocus: false,
      controller: inputController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Text',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0)),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: const Text("Details"),
      ),
      body: Container(
        color: Colors.grey[200],
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Penerima',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Consignee Name: '),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: inputReason),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Consignee Phone:'),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: inputReason),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Consignee Address:'),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: inputReason),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Goods Weight:'),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: inputReason),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Notes:'),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: inputReason),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Goods Type:'),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: inputReason),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 10),
                child: Column(
                  children: const [
                    Text(
                      'Biaya Lama:',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                    Text('Rp 5.000'),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25, left: 10),
                child: Column(
                  children: const [
                    Text(
                      'Biaya Baru:',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                    Text('Rp 5.000'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: Column(
                  children: const [
                    Text('Metode Pembayaran',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ),
              // SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              // MaterialButton(
              //     onPressed: () {
              //       //globals.waybill = waybillNumber;
              //       //Navigator.pushNamed(context, '/test'); //dialogConfirm();
              //     },
              //     child: Container(
              //       height: MediaQuery.of(context).size.height * 0.05,
              //       width: MediaQuery.of(context).size.width * 0.3,
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
              //           child: Text('Konfirmasi\npembayaran',
              //               style: TextStyle(
              //                   fontWeight: FontWeight.bold,
              //                   color: Colors.white,
              //                   fontSize: 14))),
              //     )),
            ],
          ),
        ),
      ),
    );
  }
}
