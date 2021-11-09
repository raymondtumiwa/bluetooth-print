import 'package:blue/print.dart';
import 'package:flutter/material.dart';

class ValidasiPickup extends StatefulWidget {
  @override
  _ValidasiPickupState createState() => _ValidasiPickupState();
}

enum SingingCharacter { lafayette, jefferson }
String? _chosenValue;

class _ValidasiPickupState extends State<ValidasiPickup> {
  TextEditingController inputController = TextEditingController();
  SingingCharacter? _character = SingingCharacter.lafayette;
  @override
  Widget build(BuildContext context) {
    var inputReason = TextFormField(
      autofocus: false,
      controller: inputController,
      decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding:
              const EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
          hintText: "Hint here"),
      // decoration: InputDecoration(
      //   filled: true,
      //   fillColor: Colors.white,
      //   hintText: 'Text',
      //   contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      //   border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0)),
      // ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: const Text("Details"),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                  padding: EdgeInsets.only(top: 15, left: 10),
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
                              fontSize: 15,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, left: 10),
                  child: DropdownButton<String>(
                    value: _chosenValue,
                    //elevation: 5,
                    style: const TextStyle(color: Colors.black),

                    items: <String>[
                      'Cash',
                      'Balance',
                      'Other (OVO, DANA, Shopee Pay, QRes'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    hint: const Text(
                      "Please choose ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _chosenValue = value!;
                        print(_chosenValue);
                        print("BELA DAN");
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, left: 10),
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Padding(
                  padding: const EdgeInsets.only(left: 100),
                  child: Row(
                    children: [
                      MaterialButton(
                          onPressed: () {
                            //globals.waybill = waybillNumber;
                            //Navigator.pushNamed(context, '/test'); //dialogConfirm();
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PrintReceipt()));
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.3,
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
                                child: Text('Proses Resi',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 14))),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
