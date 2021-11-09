import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:oktoast/oktoast.dart';

class PrintReceipt extends StatefulWidget {
  // MyHomePage({Key? key, required this.title}) : super(key: key);
  // final String title;

  @override
  _PrintReceiptState createState() => _PrintReceiptState();
}

class _PrintReceiptState extends State<PrintReceipt> {
  PrinterBluetoothManager printerManager = PrinterBluetoothManager();
  List<PrinterBluetooth> _devices = [];
  var addressGroup = [];

  @override
  void initState() {
    super.initState();
    _startScanDevices();
    printerManager.scanResults.listen((devices) async {
      // print('UI: Devices found ${devices.length}');
      setState(() {
        _devices = devices;
      });
    });
    String address =
        'Jl. Boulevard Raya, RT.11/RW.18, Gedung Menara satu, Kec. Klp. Gading, Kota Jkt Utara, Daerah Khusus Ibukota Jakarta 14240';
    // if (address.length > 25) {
    //   cutAddress = address.substring(0, 25);
    //   String addressLeft = address.substring(26, address.length);
    //   print(cutAddress);
    //   if (addressLeft.length > 25) {
    //     String addressLeft1 = addressLeft.substring(0, 25);
    //     String addressleft2 = addressLeft.substring(26, addressLeft.length);
    //     print(addressLeft1);
    //   }
    // }

    print(122 / 25);
    for (var i = 0; i < address.length / 40; i++) {
      int total = 0;
      total = total + i;
      print(total);
      String tempStr = "";
      if (address.length > 40 * (i + 1)) {
        tempStr = address.substring(40 * i, 40 * (i + 1));
      } else {
        tempStr = address.substring(40 * i, address.length);
      }
      print(tempStr);
      addressGroup.add(tempStr);
      // address = tempStr + "-" + address.substring(26*(i+1), address.length);
      print(address);
    }
    // print(address);
    print(addressGroup);
  }

  void _startScanDevices() {
    setState(() {
      _devices = [];
    });
    printerManager.startScan(Duration(seconds: 2));
  }

  void _stopScanDevices() {
    printerManager.stopScan();
  }

  Future<List<int>> demoReceipt(
      PaperSize paper, CapabilityProfile profile) async {
    final Generator ticket = Generator(paper, profile);

    final Generator generator = Generator(paper, profile);

    List<int> bytes = [];

    final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
    bytes += generator.barcode(Barcode.upcA(barData), width: 1, height: 1);
    // try {
    //   const String qrData = 'example.com';
    //   const double qrSize = 50;
    //   final uiImg = await QrPainter(
    //     data: qrData,
    //     version: QrVersions.auto,
    //     gapless: false,
    //   ).toImageData(qrSize);
    //   final dir = await getTemporaryDirectory();
    //   final pathName = '${dir.path}/qr_tmp.png';
    //   final qrFile = File(pathName);
    //   final imgFile = await qrFile.writeAsBytes(uiImg!.buffer.asUint8List());
    //   final img = decodeImage(imgFile.readAsBytesSync());

    //   bytes += ticket.image(img!);
    // } catch (e) {
    //   print(e);
    // }

    // Print image
    // final ByteData data = await rootBundle.load('assets/rabbit_black.jpg');
    // final Uint8List imageBytes = data.buffer.asUint8List();
    // final Image? image = decodeImage(imageBytes);
    // bytes += ticket.image(image!);

    bytes += ticket.text('GROCERYLY',
        styles: PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size1,
          width: PosTextSize.size1,
        ),
        linesAfter: 1);

    bytes += ticket.text('889  Watson Lane',
        styles: PosStyles(align: PosAlign.center));
    bytes += ticket.text('New Braunfels, TX',
        styles: PosStyles(align: PosAlign.center));
    bytes += ticket.text('Tel: 830-221-1234',
        styles: PosStyles(align: PosAlign.center));
    // bytes += ticket.text('Web: www.example.com',
    //     styles: PosStyles(align: PosAlign.center), linesAfter: 1);

    bytes += ticket.hr();
    bytes += ticket.hr();
    bytes += ticket.hr();
    bytes += ticket.hr();
    bytes += ticket.row([
      PosColumn(text: 'Qty', width: 1),
      PosColumn(text: 'Item', width: 7),
      PosColumn(
          text: 'Price', width: 2, styles: PosStyles(align: PosAlign.right)),
      PosColumn(
          text: 'Total', width: 2, styles: PosStyles(align: PosAlign.right)),
    ]);

    bytes += ticket.row([
      PosColumn(text: '2', width: 1),
      PosColumn(text: 'ONION RINGS', width: 7),
      PosColumn(
          text: '0.99', width: 2, styles: PosStyles(align: PosAlign.right)),
      PosColumn(
          text: '1.98', width: 2, styles: PosStyles(align: PosAlign.right)),
    ]);
    bytes += ticket.row([
      PosColumn(text: '1', width: 1),
      PosColumn(text: 'PIZZA', width: 7),
      PosColumn(
          text: '3.45', width: 2, styles: PosStyles(align: PosAlign.right)),
      PosColumn(
          text: '3.45', width: 2, styles: PosStyles(align: PosAlign.right)),
    ]);
    bytes += ticket.row([
      PosColumn(text: '1', width: 1),
      PosColumn(text: 'SPRING ROLLS', width: 7),
      PosColumn(
          text: '2.99', width: 2, styles: PosStyles(align: PosAlign.right)),
      PosColumn(
          text: '2.99', width: 2, styles: PosStyles(align: PosAlign.right)),
    ]);
    bytes += ticket.row([
      PosColumn(text: '3', width: 1),
      PosColumn(text: 'CRUNCHY STICKS', width: 7),
      PosColumn(
          text: '0.85', width: 2, styles: PosStyles(align: PosAlign.right)),
      PosColumn(
          text: '2.55', width: 2, styles: PosStyles(align: PosAlign.right)),
    ]);
    bytes += ticket.hr();

    bytes += ticket.row([
      PosColumn(
          text: 'TOTAL',
          width: 6,
          styles: PosStyles(
            height: PosTextSize.size2,
            width: PosTextSize.size2,
          )),
      PosColumn(
          text: '\$10.97',
          width: 6,
          styles: PosStyles(
            align: PosAlign.right,
            height: PosTextSize.size2,
            width: PosTextSize.size2,
          )),
    ]);

    bytes += ticket.hr(ch: '=', linesAfter: 1);

    bytes += ticket.row([
      PosColumn(
          text: 'Cash',
          width: 7,
          styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
      PosColumn(
          text: '\$15.00',
          width: 5,
          styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
    ]);
    bytes += ticket.row([
      PosColumn(
          text: 'Change',
          width: 7,
          styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
      PosColumn(
          text: '\$4.03',
          width: 5,
          styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
    ]);

    bytes += ticket.feed(2);
    bytes += ticket.text('Thank you!',
        styles: PosStyles(align: PosAlign.center, bold: true));

    final now = DateTime.now();
    final formatter = DateFormat('MM/dd/yyyy H:m');
    final String timestamp = formatter.format(now);
    bytes += ticket.text(timestamp,
        styles: PosStyles(align: PosAlign.center), linesAfter: 2);

    // Print QR Code from image
    // try {
    //   const String qrData = 'example.com';
    //   const double qrSize = 100;
    //   final uiImg = await QrPainter(
    //     data: qrData,
    //     version: QrVersions.auto,
    //     gapless: false,
    //   ).toImageData(qrSize);
    //   final dir = await getTemporaryDirectory();
    //   final pathName = '${dir.path}/qr_tmp.png';
    //   final qrFile = File(pathName);
    //   final imgFile = await qrFile.writeAsBytes(uiImg!.buffer.asUint8List());
    //   final img = decodeImage(imgFile.readAsBytesSync());

    //   bytes += ticket.image(img!);
    // } catch (e) {
    //   print(e);
    // }

    // Print QR Code using native function
    // bytes += ticket.qrcode('example.com');

    ticket.feed(2);
    ticket.cut();
    return bytes;
  }

  Future<List<int>> testTicket(
      PaperSize paper, CapabilityProfile profile) async {
    final Generator generator = Generator(paper, profile);
    List<int> bytes = [];
    // bytes += generator.reset();
    // bytes += generator.text('ONDELIVERY',
    //     styles: PosStyles(
    //       align: PosAlign.left,
    //     ));
    final List<dynamic> barData = [
      '{',
      'B',
      'J',
      'K',
      'T',
      '1',
      '0',
      '0',
      '5',
      '0',
      '2',
      'R',
      '1',
      '2',
      '1',
      'B',
      '4',
      '0',
      '0',
      '2',
    ];

    // bytes += generator.barcode(Barcode.code39(barData),height:100);

    bytes += generator.barcode(Barcode.code128(barData), width: 1, height: 50);
    // bytes += generator.barcode(Barcode.code39(barData),  height:50);
    bytes += generator.row([
      PosColumn(
          text: 'ONDELIVERY',
          width: 3,
          styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: '23 Oktober 1998 22:53',
          width: 9,
          styles: PosStyles(align: PosAlign.left, bold: true)),
    ]);
    // bytes += generator.barcode(Barcode.code128(barData),height: 1);

    bytes += generator.row([
      PosColumn(
          text: 'Sender',
          width: 3,
          styles: PosStyles(align: PosAlign.left, bold: true)),

      // PosColumn(
      //     text: '0.85', width: 2, styles: PosStyles(align: PosAlign.right)),
      PosColumn(
          text: 'Raymond Tumiwa',
          width: 9,
          styles: PosStyles(
            align: PosAlign.left,
          )),
    ]);

    bytes += generator.row([
      PosColumn(
          text: 'Phone',
          width: 3,
          styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: '08951273689',
          width: 9,
          styles: PosStyles(
            align: PosAlign.left,
          )),
    ]);

    bytes += generator.row([
      PosColumn(
          text: 'Receiver',
          width: 3,
          styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: 'Abdulah Ahmad',
          width: 9,
          styles: PosStyles(
            align: PosAlign.left,
          )),
    ]);
    bytes += generator.row([
      PosColumn(
          text: 'Phone',
          width: 3,
          styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: '08951273689',
          width: 9,
          styles: PosStyles(
            align: PosAlign.left,
          )),
    ]);

    // bytes += generator.row([
    //   PosColumn(
    //     text: 'Alamat',
    //     width: 11,
    //     styles: PosStyles(align: PosAlign.left, bold: true),
    //   ),
    //   PosColumn(
    //       text: '',
    //       width: 1,
    //       styles: PosStyles(
    //         align: PosAlign.right,
    //       )),
    // ]);
    String? cutAddress;

    // for(var i=0;i<)
    // bytes += generator.text(cutAddress!,
    //     styles: PosStyles(align: PosAlign.right, bold: true));
    //initial
    for (var i = 0; i < addressGroup.length; i++) {
      bytes += generator.text(addressGroup[i],
          styles: PosStyles(align: PosAlign.left, bold: true));
    }
// harun edit

// for (var i = 0; i < addressGroup.length; i++) {
//       bytes += generator.row([
//         PosColumn(
//           text: addressGroup[i],
//           width: 12,
//           styles: PosStyles(
//             align: PosAlign.left,
//           )),
//       ]);
//     }
//harun edit end
    // bytes += generator.text('---------------------',
    //     styles: PosStyles(
    //       align: PosAlign.center,
    //     ));
    // bytes += generator.feed(1);

    bytes += generator.row([
      PosColumn(
          text: 'Content Of Package',
          width: 6,
          styles: PosStyles(align: PosAlign.left, bold: true)),

      // PosColumn(
      //     text: '0.85', width: 2, styles: PosStyles(align: PosAlign.right)),
      PosColumn(
          text: 'Elektronik',
          width: 6,
          styles: PosStyles(
            align: PosAlign.left,
          )),
    ]);
    bytes += generator.row([
      PosColumn(
          text: 'QTY (ITEM)',
          width: 3,
          styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: '1 pcs',
          width: 3,
          styles: PosStyles(
            align: PosAlign.left,
          )),
      PosColumn(
          text: 'SERVICE',
          width: 3,
          styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: '9.9999.9999',
          width: 3,
          styles: PosStyles(
            align: PosAlign.left,
          )),
    ]);
    bytes += generator.row([
      PosColumn(
          text: 'Weight',
          width: 3,
          styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: '1kg',
          width: 3,
          styles: PosStyles(
            align: PosAlign.left,
          )),
      PosColumn(
          text: 'INSURANCE',
          width: 3,
          styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: '0',
          width: 3,
          styles: PosStyles(
            align: PosAlign.left,
          )),
    ]);
    bytes += generator.row([
      PosColumn(
          text: 'VOLUMETRIK',
          width: 3,
          styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: '',
          width: 3,
          styles: PosStyles(
            align: PosAlign.left,
          )),
      PosColumn(
          text: 'SURCHARGE',
          width: 3,
          styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: '0',
          width: 3,
          styles: PosStyles(
            align: PosAlign.left,
          )),
    ]);
    bytes += generator.row([
      // PosColumn(
      //     text: '',
      //     width: 3,
      //     styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: 'P: 0, L: 0, T: 0',
          width: 6,
          styles: PosStyles(
            align: PosAlign.left,
          )),
      PosColumn(
          text: 'DISCOUNT',
          width: 3,
          styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: '0',
          width: 3,
          styles: PosStyles(
            align: PosAlign.left,
          )),
    ]);
    bytes += generator.row([
      PosColumn(
          text: '',
          width: 3,
          styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: '',
          width: 3,
          styles: PosStyles(
            align: PosAlign.right,
          )),
      PosColumn(
          text: 'TOTAL',
          width: 3,
          styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: '0',
          width: 3,
          styles: PosStyles(
            align: PosAlign.left,
          )),
    ]);
    String add =
        'Notes: PT ADMINISTRASI MEDIKA TELKOM ADMINISTRASI MEDIKA TELKOM ADMINISTRASI MEDIKA TELKOM';
    print(add);
    print(add.length);
    String addCut = add.substring(0, 10);
    bytes += generator.text(add,
        styles: PosStyles(
          align: PosAlign.left,
        ));

    // bytes += generator.text('---------------------',
    //     styles: PosStyles(
    //       align: PosAlign.center,
    //     ));

    bytes += generator.row([
      // PosColumn(
      //     text: '|',
      //     width: 1,
      //     styles: PosStyles(align: PosAlign.center, bold: true)),
      PosColumn(
          text: 'JKT-JKT',
          width: 3,
          styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: 'SETIABUDI 17149',
          width: 5,
          styles: PosStyles(
            align: PosAlign.left,
          )),
      PosColumn(
          text: 'SAMEDAY SERVICE',
          width: 4,
          styles: PosStyles(
            align: PosAlign.left,
          )),
      // PosColumn(
      //     text: '|',
      //     width: 1,
      //     styles: PosStyles(align: PosAlign.center, bold: true)),
    ]);

    // try {
    //   const String qrData = 'example.com';
    //   const double qrSize = 50;
    //   final uiImg = await QrPainter(
    //     data: qrData,
    //     version: QrVersions.auto,
    //     gapless: false,
    //   ).toImageData(qrSize);
    //   final dir = await getTemporaryDirectory();
    //   final pathName = '${dir.path}/qr_tmp.png';
    //   final qrFile = File(pathName);
    //   final imgFile = await qrFile.writeAsBytes(uiImg!.buffer.asUint8List());
    //   final img = decodeImage(imgFile.readAsBytesSync());

    //   bytes += generator.image(img!);
    // } catch (e) {
    //   print(e);
    // }
    // bytes += generator.text('---------------------',
    //     styles: PosStyles(
    //       align: PosAlign.center,
    //     ));
    // bytes += generator.qrcode('example.com');

    // bytes += generator.feed(1);

    // final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
    // bytes += generator.barcode(Barcode.upcA(barData));
    // bytes += generator.text('---------------------',
    //     styles: PosStyles(
    //       align: PosAlign.center,
    //     ));

    // bytes += generator.row([

    //   PosColumn(
    //       text: 'SERVICE',
    //       width: 5,
    //       styles: PosStyles(align: PosAlign.left, bold: true)),
    //   PosColumn(
    //       text: 'SAMEDAY SERVICE',
    //       width: 7,
    //       styles: PosStyles(
    //         align: PosAlign.left,
    //       )),

    // ]);

    // bytes += generator.cut(mode: PosCutMode.partial);
    bytes += generator.cut();
    //bytes += generator.feed(1);
    // final List<int> barData1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
    bytes += generator.barcode(Barcode.code128(barData));
    bytes += generator.row([
      PosColumn(
          text: 'ONDELIVERY',
          width: 6,
          styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: 'REGULER SERVICE',
          width: 6,
          styles: PosStyles(
            align: PosAlign.left,
          )),
    ]);
    bytes += generator.row([
      PosColumn(
          text: '2 June 2021 15:45',
          width: 6,
          styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: 'Rp 9999.9999',
          width: 6,
          styles: PosStyles(
            align: PosAlign.left,
          )),
    ]);
    bytes += generator.row([
      PosColumn(
          text: 'Sender: RAYMOND TUMIWA',
          width: 6,
          styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: '',
          width: 6,
          styles: PosStyles(
            align: PosAlign.left,
          )),
    ]);
    bytes += generator.row([
      PosColumn(
          text: 'Phone: 08951273689',
          width: 6,
          styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: '',
          width: 6,
          styles: PosStyles(
            align: PosAlign.left,
          )),
    ]);
    bytes += generator.row([
      PosColumn(
          text: 'Receiver: Abdullah Ahmad',
          width: 6,
          styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: '',
          width: 6,
          styles: PosStyles(
            align: PosAlign.left,
          )),
    ]);
    bytes += generator.row([
      PosColumn(
          text: 'Phone: 08951273689',
          width: 6,
          styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: '',
          width: 6,
          styles: PosStyles(
            align: PosAlign.left,
          )),
    ]);

    bytes += generator.row([
      PosColumn(
          text: 'Insurance: ',
          width: 6,
          styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: 'No',
          width: 6,
          styles: PosStyles(
            align: PosAlign.left,
          )),
    ]);

//     bytes += generator.row([
//  PosColumn(text: 'Weight', width: 6, styles: PosStyles(align: PosAlign.left, bold: true)),

//       PosColumn(
//           text: '1 Kg', width:6, styles: PosStyles(align: PosAlign.right,) ),
//     ]);

    // PosColumn(
    //     text: 'Phone', width:2, styles: PosStyles(align: PosAlign.left, bold: true) ),
    // PosColumn(
    //     text: 'Alamat', width:2, styles: PosStyles(align: PosAlign.left, bold: true) ),

    //  bytes += generator.row([
    //   PosColumn(text: '13 Oktober 2021 22:45', width: 2, styles: PosStyles(align: PosAlign.right)),
    //   PosColumn(text: 'Raymon Tumtum', width: 2, styles: PosStyles(align: PosAlign.right)),
    //   PosColumn(text: '082938716273', width: 2, styles: PosStyles(align: PosAlign.right)),

    //   // PosColumn(
    //   //     text: '0.85', width: 2, styles: PosStyles(align: PosAlign.right)),
    //   PosColumn(
    //       text: 'Riven Darien', width: 2, styles: PosStyles(align: PosAlign.right)),
    //        PosColumn(
    //       text: '08215627387', width: 2, styles: PosStyles(align: PosAlign.right)),
    //        PosColumn(
    //       text: 'Jl. Gambir jakrata barat', width: 2, styles: PosStyles(align: PosAlign.right) ),
    // ]);
// bytes += generator.row([
//       PosColumn(text: 'Sender', width: 5,styles: PosStyles(align: PosAlign.right)),
//       PosColumn(text: '', width: 1, styles: PosStyles(align: PosAlign.right)),
//       PosColumn(text: '', width: 1, styles: PosStyles(align: PosAlign.right)),

//       // PosColumn(
//       //     text: '0.85', width: 2, styles: PosStyles(align: PosAlign.right)),
//       PosColumn(
//           text: 'QTY (ITEM) : 1', width: 5, ),
//     ]);

//     bytes += generator.row([
//       PosColumn(text: 'HIJABSANA', width: 5,),
//       PosColumn(text: '', width: 1),
//       PosColumn(text: '', width: 1),
//       // PosColumn(
//       //     text: '0.85', width: 2, styles: PosStyles(align: PosAlign.right)),
//       PosColumn(
//           text: 'TOTAL WEIGHT : 1', width: 5, ),
//     ]);
//   bytes += generator.row([
//       PosColumn(text: '08988062941', width: 5,),
//       PosColumn(text: '', width: 1),
//       PosColumn(text: '', width: 1),
//       // PosColumn(
//       //     text: '0.85', width: 2, styles: PosStyles(align: PosAlign.right)),
//       PosColumn(
//           text: 'VOLUMETRIK', width: 5, ),
//     ]);
//     bytes += generator.row([
//       PosColumn(text: 'JAKARTA DKI JAKARTA', width: 5,),
//       PosColumn(text: '', width: 1),
//       PosColumn(text: '', width: 1),
//       // PosColumn(
//       //     text: '0.85', width: 2, styles: PosStyles(align: PosAlign.right)),
//       PosColumn(
//           text: 'P:0 L:0 T:0', width: 5, styles: PosStyles(align: PosAlign.left, )),
//     ]);
    //  bytes += generator.row([
    //   PosColumn(text: 'SENDER:', width: 6, styles: PosStyles(bold: true)),
    //   PosColumn(text: '', width: 1),
    //   // PosColumn(
    //   //     text: '0.85', width: 2, styles: PosStyles(align: PosAlign.right)),
    //   PosColumn(
    //       text: 'QTY(ITEM): 1', width: 5, styles: PosStyles(align: PosAlign.left, )),
    // ]);

    //  bytes += generator.row([
    //   PosColumn(text: 'HIJABSANA', width: 6),
    //   // PosColumn(text: '', width: 5),
    //   // PosColumn(
    //   //     text: '0.85', width: 2, styles: PosStyles(align: PosAlign.right)),
    //   PosColumn(
    //       text: 'TOTAL WEIGHT:1KG', width: 6, styles: PosStyles(align: PosAlign.left, )),
    // ]);
    // bytes += generator.row([
    //   PosColumn(text: '08988062941', width: 6),
    //   // PosColumn(text: '', width: 5),
    //   // PosColumn(
    //   //     text: '0.85', width: 2, styles: PosStyles(align: PosAlign.right)),
    //   PosColumn(
    //       text: 'VOLUMETRIK:', width: 6, styles: PosStyles(align: PosAlign.center, )),
    // ]);
    // bytes += generator.row([
    //   PosColumn(text: 'JAKARTA DKI JAKARTA', width: 6),
    //   // PosColumn(text: '', width: 3),
    //   // PosColumn(
    //   //     text: '0.85', width: 2, styles: PosStyles(align: PosAlign.right)),
    //   PosColumn(
    //       text: 'P:0cm L:0cm T:0cm', width: 6, styles: PosStyles(align: PosAlign.left, )),
    //     // PosColumn(
    //     //   text: 'L:0cm', width: 1, styles: PosStyles(align: PosAlign.left, )),
    //     //   PosColumn(
    //     //   text: 'T:0cm', width: 1, styles: PosStyles(align: PosAlign.left, )),

    // ]);

    // bytes += generator.text(
    //     'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
    // bytes += generator.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
    //     styles: PosStyles(codeTable: PosCodeTable.westEur));
    // bytes += generator.text('Special 2: blåbærgrød',
    //     styles: PosStyles(codeTable: PosCodeTable.westEur));

    // bytes += generator.text('Bold text', styles: PosStyles(bold: true));
    // bytes += generator.text('Reverse text', styles: PosStyles(reverse: true));
    // bytes += generator.text('Underlined text',
    //     styles: PosStyles(underline: true), linesAfter: 1);
    // bytes +=
    //     generator.text('Align left', styles: PosStyles(align: PosAlign.left));
    // bytes += generator.text('Align center',
    //     styles: PosStyles(align: PosAlign.center));
    // bytes += generator.text('Align right',
    //     styles: PosStyles(align: PosAlign.right), linesAfter: 1);

    // bytes += generator.row([
    //   PosColumn(
    //     text: 'Date: 13 Oktober 2021',
    //     width: 4,
    //     styles: PosStyles(
    //       align: PosAlign.left,
    //       underline: true,
    //     ),
    //   ),
    //   PosColumn(
    //     text: '| ',
    //     width: 4,
    //     styles: PosStyles(align: PosAlign.right, underline: true),
    //   ),
    //   PosColumn(
    //     text: 'CONTENTS OF THE PACKAGE ',
    //     width: 4,
    //     styles: PosStyles(align: PosAlign.right, underline: true),
    //   ),
    // ]);

    // bytes += generator.text('Text size 200%',
    //     styles: PosStyles(
    //       height: PosTextSize.size2,
    //       width: PosTextSize.size2,
    //     ));

    // Print image
    // final ByteData data = await rootBundle.load('assets/logo.png');
    // final Uint8List buf = data.buffer.asUint8List();
    // final Image image = decodeImage(buf)!;
    // bytes += generator.image(image);
    // Print image using alternative commands
    // bytes += generator.imageRaster(image);
    // bytes += generator.imageRaster(image, imageFn: PosImageFn.graphics);

    // Print barcode
    // final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
    // bytes += generator.barcode(Barcode.upcA(barData));

    // Print mixed (chinese + latin) text. Only for printers supporting Kanji mode
    // bytes += generator.text(
    //   'hello ! 中文字 # world @ éphémère &',
    //   styles: PosStyles(codeTable: PosCodeTable.westEur),
    //   containsChinese: true,
    // );
    // bytes += generator.feed(1);

    // bytes += generator.cut();
    return bytes;
  }

  printerList() {
    if (_devices.length > 0)
      for (var i = 0; i < _devices.length; i++) {
        if (_devices[i].name == "M300eL") {
          return InkWell(
            onTap: () => _testPrint(_devices[i]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.print, size: 100),
                Text("Printer:"),
                Text(_devices[i].name ?? ""),
                // Text(_devices[i].address!),
                Text(
                  'Tekan Gambar Untuk Cetak',
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
          );
        } else {
          return Text('Tidak ada printer');
        }
      }
    else {
      return Text('Scanning...');
    }
    // return ListView.builder(
    //     itemCount: _devices.length,
    //     itemBuilder: (BuildContext context, int index) {
    //       return _devices[index].name == "M300eL"
    //           ? InkWell(
    //               onTap: () => _testPrint(_devices[index]),
    //               child: Column(
    //                 children: <Widget>[
    //                   Container(
    //                     height: 60,
    //                     padding: EdgeInsets.only(left: 10),
    //                     alignment: Alignment.centerLeft,
    //                     child: Row(
    //                       children: <Widget>[
    //                         Icon(Icons.print),
    //                         SizedBox(width: 10),
    //                         Expanded(
    //                           child: Column(
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             mainAxisAlignment: MainAxisAlignment.center,
    //                             children: <Widget>[
    //                               Text(_devices[index].name ?? ''),
    //                               Text(_devices[index].address!),
    //                               Text(
    //                                 'Click to print a test receipt',
    //                                 style: TextStyle(color: Colors.grey[700]),
    //                               ),
    //                             ],
    //                           ),
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                   Divider(),
    //                 ],
    //               ),
    //             )
    //           : Text('Printer tidak ditemukan');
    //     });
  }

  void _testPrint(PrinterBluetooth printer) async {
    printerManager.selectPrinter(printer);

    // TODO Don't forget to choose printer's paper
    const PaperSize paper = PaperSize.mm80;
    final profile = await CapabilityProfile.load();

    // TEST PRINT
    final PosPrintResult res = await printerManager.printTicket(
        await testTicket(
          paper,
          profile,
        ),
        queueSleepTimeMs: 100);

    // DEMO RECEIPT
    // final PosPrintResult res =
    //     await printerManager.printTicket((await demoReceipt(paper, profile)), queueSleepTimeMs: 50);

    showToast(res.msg);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver"),
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        printerList(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Material(
            borderRadius: BorderRadius.circular(30.0),
            shadowColor: Colors.lightBlueAccent.shade100,
            elevation: 5.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.blue,
              ),
              child: MaterialButton(
                minWidth: 330.0,
                height: 42.0,
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/main', (route) => false);
                },
                child: Text('Kembali', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        )
      ])),
      floatingActionButton: StreamBuilder<bool>(
        stream: printerManager.isScanningStream,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data!) {
            return FloatingActionButton(
              child: Icon(Icons.stop),
              onPressed: _stopScanDevices,
              backgroundColor: Colors.red,
            );
          } else {
            return FloatingActionButton(
              child: Icon(Icons.search),
              onPressed: _startScanDevices,
            );
          }
        },
      ),
    );
  }
}
