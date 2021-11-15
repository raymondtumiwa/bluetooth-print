import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/models/pickup.dart';
import 'dart:async';
import 'dart:core';
// import 'globals.dart' as globals;
import 'custom_exception.dart';
// import 'package:onmapps/model/response_get_ServiceList.dart';
// import 'package:onmapps/model/response_post_checkPrice.dart';
import 'dart:convert';
import './globals.dart' as globals;

class OnRest {
  OnRest._privateConstructor();
  String apiAddress = "https://demoapi.ondelivery.id/";
  String apiSat = "https://apisat.ondelivery.id";
  String apiUS = "https://demousapi.onindonesia.id";
  // String apiAddress = "http://192.168.30.8:4220/";
  // String apiAddress = "http://192.168.30.185:3100/api";
  static final OnRest instance = OnRest._privateConstructor();
  // static var employeeName;
  // static var employeeCode;
  // static var employeePosition;
  // static var id;
  // static var getLat = [];
  // static var getLong = [];

  Future<bool> pingServerApiSat() async {
    // print(argument.toJson());
    final http.Response response =
        await http.get(Uri.parse(apiSat), headers: <String, String>{
      'Content-Type': 'application/json',
    });
    print(response.statusCode);
    print(response.body);
    switch (response.statusCode) {
      case 200:
        return true;
      default:
        return _response(response);
    }
  }

  Future<bool> pingServerApiOndel() async {
    // print(argument.toJson());
    final http.Response response =
        await http.get(Uri.parse(apiAddress), headers: <String, String>{
      'Content-Type': 'application/json',
    });
    print(response.statusCode);
    print(response.body);
    switch (response.statusCode) {
      case 200:
        return true;
      default:
        return _response(response);
    }
  }

  Future loginApp(
    String username,
    String password,
  ) async {
    final http.Response response = await http.post(
      Uri.parse(apiAddress + 'auth/signin'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"username": username, "password": password}),
    );
    print(response.statusCode);
    print("courrrrr");
    return _response(response);
  }

  Future<dynamic> getAppVersion() async {
    print('INSITE APPVERSION CHECKING');
    print('qweqweqewqweqwewe');

    Uri coba = Uri.parse(apiAddress + 'mondeliv/get-supported-versions');
    final http.Response response = await http.get(coba,
        headers: <String, String>{'Content-Type': 'application/json'});
    print('12312312313213123');

    print(response.statusCode);
    if (response.statusCode == 200) {
      print('CHECKING APP VERSION');
      print(response.body.runtimeType);
      return response.body;
    } else {
      return {"message": "Error"};
    }
  }

  Future checkSesion() async {
    final http.Response response = await http.get(
      Uri.parse(apiAddress + 'mondeliv/check-session'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: globals.token
      },
    );
    return _response(response);
  }

  Future listDelivery(String agentLoc, String courierId, String waybill) async {
    print('FLEEEEET');
    print(agentLoc);
    final http.Response response = await http.post(
      Uri.parse(apiAddress + 'mondeliv/listDelivery'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: globals.token
      },
      body: jsonEncode({
        "agent_loc_id": agentLoc,
        "courier_id": courierId,
        "waybill": waybill
      }),
    );
    print(response.statusCode);
    print(response);
    return _response(response);
  }

  Future listConfirm(String agentLoc, String courierId) async {
    print('FLEEEEET');
    print(agentLoc);
    final http.Response response = await http.post(
      Uri.parse(apiAddress + 'mondeliv/list-confirmed-delivery'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: globals.token
      },
      body: jsonEncode({"agent_loc_id": agentLoc, "courier_id": courierId}),
    );
    print(response.statusCode);
    print(response);
    return _response(response);
  }

  Future<dynamic> uploadProblem(filename, waybillNumber, status, reason) async {
    print(filename);
    print(waybillNumber);
    print(status);
    print(reason);

    print("UPLOAD SETELAH INI");

    Uri coba = Uri.parse(apiAddress + 'mondeliv/image_upload_delivery');
    print(coba);
    var request = http.MultipartRequest('POST', coba)
      ..fields['waybill_number'] = waybillNumber
      ..fields['status'] = status
      ..fields['reason'] = reason;
    request..files.add(await http.MultipartFile.fromPath('files', filename));
    var res = await request.send();
    var resStr = await res.stream.bytesToString();
    // var respone = await http.Response.fromStream(res);
    print('REQUEST FILENAME');
    print(resStr);
    // print(respone);
    print('REQUEST DONE');
    return jsonDecode(resStr);
  }

  Future<BookingDetail> getBookingDetail(String bookingId) async {
    final http.Response response = await http.get(
      Uri.parse(
          apiSat + '/booking/delivery/agent/detail?booking_id=' + bookingId),
      headers: <String, String>{
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: globals.token,
      },
    );
    switch (response.statusCode) {
      case 200:
        return BookingDetail.fromJson(jsonDecode(response.body));
      default:
        return _response(response);
    }
  }

  Future<StatusDriver> getStatusDriver() async {
    final http.Response response = await http.get(
      Uri.parse(apiSat + '/booking/delivery/driver/job'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: globals.token,
      },
    );
    switch (response.statusCode) {
      case 200:
        var decoded = jsonDecode(response.body);
        if (decoded['booking_id'] != null) {
          return StatusDriver.fromJson(jsonDecode(response.body));
        } else {
          return StatusDriver.fromJson({"booking_id": ""});
        }
      default:
        return _response(response);
    }
  }

  Future<bool> assignDriverJob(String bookingId) async {
    final http.Response response = await http.post(
        Uri.parse(apiSat + '/booking/delivery/driver/job/assign'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: globals.token,
        },
        body: jsonEncode({"booking_id": bookingId}));
    switch (response.statusCode) {
      case 200:
        return true;
      default:
        return _response(response);
    }
  }

  Future<bool> cancelDriverJob(String message) async {
    final http.Response response = await http.post(
        Uri.parse(apiSat + '/booking/delivery/driver/job/cancel'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: globals.token,
        },
        body: jsonEncode({"message": message}));
    switch (response.statusCode) {
      case 200:
        return true;
      default:
        return _response(response);
    }
  }

  Future<bool> revokeBooking(String message) async {
    final http.Response response = await http.post(
        Uri.parse(apiSat + '/booking/delivery/driver/job/revoke'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: globals.token,
        },
        body: jsonEncode({"message": message}));

    switch (response.statusCode) {
      case 200:
        return true;
      default:
        return _response(response);
    }
  }

  Future<CheckPriceRespone> checkPrice(CheckPriceBody argument) async {
    // print(argument.toJson());
    final http.Response response =
        await http.post(Uri.parse(apiAddress + '/check-fee-waybill'),
            headers: <String, String>{
              'Content-Type': 'application/json',
              HttpHeaders.authorizationHeader: globals.token,
            },
            body: jsonEncode(argument.toJson()));
    // print("SCSS");

    switch (response.statusCode) {
      case 200:
        return CheckPriceRespone.fromJson(jsonDecode(response.body));
      default:
        return _response(response);
    }
  }

  Future<List<ContentList>> contentListType() async {
    // print(argument.toJson());
    final http.Response response = await http.get(
        Uri.parse(apiAddress + '/waybill/content_list'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: globals.token,
        });
    // print("SCSS");

    switch (response.statusCode) {
      case 200:
        return (jsonDecode(response.body) as List)
            .map((e) => ContentList.fromJson(e))
            .toList();
      default:
        return _response(response);
    }
  }

  Future<CheckOutDriverRespone> checkoutDriver(
      CheckOutDriverBody argument) async {
    print(argument.toJson());
    final http.Response response =
        await http.post(Uri.parse(apiUS + '/agent/payment-checkout'),
            headers: <String, String>{
              'Content-Type': 'application/json',
              HttpHeaders.authorizationHeader: globals.token,
            },
            body: jsonEncode(argument.toJson()));
    print("SCSS");
    print(response.body);

    switch (response.statusCode) {
      case 200:
        return CheckOutDriverRespone.fromJson(jsonDecode(response.body));
      default:
        return _response(response);
    }
  }

  Future<WaybilCreateRespone> createWaybill(WaybillCreateBody argument) async {
    // print(argument.toJson());
    final http.Response response =
        await http.post(Uri.parse(apiAddress + '/waybill/content_list'),
            headers: <String, String>{
              'Content-Type': 'application/json',
              HttpHeaders.authorizationHeader: globals.token,
            },
            body: jsonEncode(argument.toJson()));
    // print("SCSS");

    switch (response.statusCode) {
      case 200:
        return WaybilCreateRespone.fromJson(jsonDecode(response.body));
      default:
        return _response(response);
    }
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 204:
        return null;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw InvalidToken(response.body.toString());
      case 404:
        throw UnauthorizedException(response.body.toString());
      case 500:
        throw InvalidParameter(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }
}
