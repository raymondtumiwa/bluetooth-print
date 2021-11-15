import 'package:flutter/material.dart';
import '../services/globals.dart' as globals;

class DetailsPage extends StatelessWidget {
  final String waybillNumber;
  final String origin;
  final String service;
  final String senderName;
  final String senderPhone;
  final String senderCity;
  final String senderZipcode;
  final String consigneeName;
  final String consigneePhone;
  final String consigneeZipcode;
  final String consigneeAddress;
  final String destination;
  final String scannedAt;
  final int goodsKoli;
  final int goodsWeight;
  final String status;

  const DetailsPage(
    this.waybillNumber,
    this.origin,
    this.service,
    this.senderName,
    this.senderPhone,
    this.senderCity,
    this.senderZipcode,
    this.consigneeName,
    this.consigneePhone,
    this.consigneeZipcode,
    this.consigneeAddress,
    this.destination,
    this.scannedAt,
    this.goodsKoli,
    this.goodsWeight,
    this.status, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: const Text("Details"),
      ),
      body: SizedBox(
        child: Container(
          color: Colors.grey[200],
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 30),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),

                    // color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
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
                                const Text(
                                  "Waybill Number : ",
                                  style: TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(waybillNumber,
                                    style: const TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Origin : ",
                                    style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Colors.grey)),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(origin,
                                    style: const TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Service : ",
                                    style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Colors.grey)),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(service,
                                    style: const TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Sender Name : ",
                                    style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Colors.grey)),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(senderName,
                                    style: const TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Sender Phone : ",
                                    style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Colors.grey)),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(senderPhone,
                                    style: const TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Sende City : ",
                                    style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Colors.grey)),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(senderCity,
                                    style: const TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Sender Zipcode : ",
                                    style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Colors.grey)),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(senderZipcode,
                                    style: const TextStyle(fontSize: 14)),
                              ],
                            ),
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
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Consignee Name : ",
                                    style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Colors.grey)),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(consigneeName,
                                    style: const TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Consignee Phone : ",
                                    style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Colors.grey)),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(consigneePhone,
                                    style: const TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Consignee Zipcode : ",
                                    style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Colors.grey)),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(consigneeZipcode,
                                    style: const TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Consignee Address : ",
                                    style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Colors.grey)),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(consigneeAddress,
                                    style: const TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Destination : ",
                                    style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Colors.grey)),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(destination,
                                    style: const TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Scanned At : ",
                                    style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Colors.grey)),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(scannedAt,
                                    style: const TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Divider(
                                  thickness: 1,
                                ),
                                const Text("Goods Koli : ",
                                    style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Colors.grey)),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(goodsKoli.toString(),
                                    style: const TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Goods Weight : ",
                                    style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Colors.grey)),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(goodsWeight.toString(),
                                    style: const TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Status : ",
                                    style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Colors.grey)),
                                Text(status,
                                    style: const TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              MaterialButton(
                  onPressed: () {
                    globals.waybill = waybillNumber;
                    Navigator.pushNamed(context, '/test'); //dialogConfirm();
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.5,
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
                        child: Text('Ambil Foto',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 14))),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
