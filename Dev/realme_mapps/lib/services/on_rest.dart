import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

class OnRest {
  OnRest._privateConstructor();
  String apiAddress = "https://demoapi.smekbm.com";
  static final OnRest instance = OnRest._privateConstructor();

  Future loginApp(String username, String password) async {
    final http.Response response = await http.post(
      apiAddress + '/api/auth/signin',
      headers: <String, String>{
        'Content-Type': 'application/json',
        //'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "username": username,
        "password": password,
        //"options": {"nativeApp": true}
      }),
    );
    print(response.body);
    //print(response);
    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      return ('error');
    }
  }

  Future verifyAccessTokens(String username, String _jwt) async {
    print(username);
    final http.Response response =
        await http.post(apiAddress + '/api/auth/check',
            headers: <String, String>{
              'Content-Type': 'application/json',
              HttpHeaders.authorizationHeader: _jwt,
            },
            body: jsonEncode({
              "username": username,
              //"options": {"nativeApp": true}
            }));
    print(response);
    if (response.statusCode == 200) {
      print("spartaaa");
      return jsonDecode(response.body);
    } else {
      print("error nic");
      return ('error');
    }
  }

  Future registerFcm(String username, String fcmToken, String _jwt) async {
    final http.Response response = await http.post(
      apiAddress + '/api/ki/registerfcm',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'x-access-token': _jwt
      },
      body: jsonEncode(<String, String>{
        "username": username,
        "fcmtoken": fcmToken,
      }),
    );
    print(response);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return ('error');
    }
  }

  Future findNewTodo(String username, String employeeRole, String employeeArea,
      String _jwt) async {
    //print(_jwt);
    // print("findNewTodo");
    // print(username);
    // print(employeeRole);
    // print(employeeArea);
    final http.Response response = await http.post(
      apiAddress + '/api/po/get/todotask',
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: _jwt,
      },
      body: jsonEncode({
        "username": username,
        "role": employeeRole,
        "area": employeeArea,
      }),
    );
    //print(response);
    if ((response.statusCode == 200)) {
      //print(response.body);
      var haduh = jsonDecode(response.body);
      //print(haduh);
      if (haduh[0].containsKey("success")) {
        print("emptyyy");
        return [];
      } else {
        return jsonDecode(response.body);
      }
    } else {
      print("error nic");
      return ('error');
    }
  }

  Future approvalWithCondition(
      String docNumber,
      String currentPlace,
      String conditions,
      String comment,
      String tasks,
      String username,
      String _jwt) async {
    final http.Response response = await http.post(
      apiAddress + '/api/po/send/todotask',
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: _jwt,
      },
      body: jsonEncode({
        "docNumber": docNumber,
        "current_place": currentPlace,
        "condition": conditions,
        "comment": comment,
        "task": tasks,
        "username": username,
      }),
    );
    if ((response.statusCode == 200)) {
      var haduh = jsonDecode(response.body);
      if (haduh[0].containsKey("success")) {
        print("emptyyy");
        return [];
      } else {
        return jsonDecode(response.body);
      }
    } else {
      print("error nic");
      return ('error');
    }
  }

  Future uploadData(String docNumber, String currentPlace, String conditions,
      String comment, String tasks, String username, String _jwt) async {
    final http.Response response = await http.post(
      apiAddress + '/api/po/free-comment/attachments',
      headers: {
        'Content-Type': 'multipart/formdata',
        HttpHeaders.authorizationHeader: _jwt,
      },
      body: jsonEncode({
        "docNumber": docNumber,
        "current_place": currentPlace,
        "condition": conditions,
        "comment": comment,
        "task": tasks,
        "username": username,
      }),
    );
    //print(response);
    if ((response.statusCode == 200)) {
      var haduh = jsonDecode(response.body);
      if (haduh[0].containsKey("success")) {
        print("emptyyy");
        return [];
      } else {
        return jsonDecode(response.body);
      }
    } else {
      print("error nic");
      return ('error');
    }
  }

  Future<String> uploadFreeForm(filename) async {
    var url = Uri.parse(apiAddress + '/api/po/free-comment/attachments');
    var request = http.MultipartRequest('POST', url)
      ..files.add(await http.MultipartFile.fromPath('files', filename.path));
    // var request = http.MultipartRequest('POST', url);
    // filename.foreach((filenameEach) async => {
    //       request.files
    //           .add(await http.MultipartFile.fromPath('files', filenameEach))
    //     });
    //request.fields['waybillnum'] = waybillNum;

    var res = await request.send();
    print("upload freeform");
    print(res);
    return res.reasonPhrase;
  }

  Future freeComment(
      String docNumber, currentPlace, usernameGlobal, valz, String _jwt) async {
    final http.Response response = await http.post(
      apiAddress + '/api/po/send/todotask',
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: _jwt,
      },
      body: jsonEncode({
        "docNumber": docNumber,
        "current_place": currentPlace,
        "username": usernameGlobal,
        "value": valz
      }),
    );
    //print(response);
    if (response.statusCode == 200) {
      print("upload freecomment");
      print(response.body);
      print("upload freecomment2");
      return jsonDecode(response.body);
    } else {
      print("error nic");
      return ('error');
    }
  }

  Future approvalApply(String docNumber, String currentPlace, String conditions,
      String comment, String tasks, String username, String _jwt) async {
    final http.Response response = await http.post(
      apiAddress + '/api/po/send/todotask',
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: _jwt,
      },
      body: jsonEncode({
        "docNumber": docNumber,
        "current_place": currentPlace,
        "condition": conditions,
        "comment": comment,
        "task": tasks,
        "username": username,
      }),
    );
    //print(response);
    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      print("error nic");
      return ('error');
    }
  }

  Future approvalReject(
      String docNumber,
      String currentPlace,
      String conditions,
      String comment,
      String tasks,
      String username,
      String _jwt) async {
    final http.Response response = await http.post(
      apiAddress + '/api/po/get/todotask/reject',
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: _jwt,
      },
      body: jsonEncode({
        "docNumber": docNumber,
        "current_place": currentPlace,
        "condition": conditions,
        "comment": comment,
        "task": tasks,
        "username": username,
      }),
    );
    //print(response);
    if ((response.statusCode == 200)) {
      //print(response.body);
      var haduh = jsonDecode(response.body);
      //print(haduh);
      if (haduh[0].containsKey("success")) {
        print("emptyyy");
        return [];
      } else {
        return jsonDecode(response.body);
      }
    } else {
      print("error nic");
      return ('error');
    }
  }

  Future approvalReturn(
      String docNumber,
      String currentPlace,
      String conditions,
      String comment,
      String tasks,
      String username,
      String _jwt) async {
    final http.Response response = await http.post(
      apiAddress + '/api/po/return/todotask',
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: _jwt,
      },
      body: jsonEncode({
        "docNumber": docNumber,
        "current_place": currentPlace,
        "condition": conditions,
        "comment": comment,
        "task": tasks,
        "username": username,
      }),
    );
    //print(response);
    if ((response.statusCode == 200)) {
      //print(response.body);
      var haduh = jsonDecode(response.body);
      //print(haduh);
      if (haduh[0].containsKey("success")) {
        print("emptyyy");
        return [];
      } else {
        return jsonDecode(response.body);
      }
    } else {
      print("error nic");
      return ('error');
    }
  }

  Future approvalCommentOnly(String username, String employeeRole,
      String employeeArea, String _jwt) async {
    final http.Response response = await http.post(
      apiAddress + '/api/po/get/todotask',
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: _jwt,
      },
      body: jsonEncode({
        "username": username,
        "role": employeeRole,
        "area": employeeArea,
      }),
    );
    //print(response);
    if ((response.statusCode == 200)) {
      //print(response.body);
      var haduh = jsonDecode(response.body);
      //print(haduh);
      if (haduh[0].containsKey("success")) {
        print("emptyyy");
        return [];
      } else {
        return jsonDecode(response.body);
      }
    } else {
      print("error nic");
      return ('error');
    }
  }

  Future findNewCC(String username, String _jwt) async {
    //print(_jwt);
    // print("findNewTodo");
    // print(username);
    // print(employeeRole);
    // print(employeeArea);
    final http.Response response = await http.post(
      apiAddress + '/api/po/get/cc',
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: _jwt,
      },
      body: jsonEncode({
        "username": username,
      }),
    );
    //print(response);
    if ((response.statusCode == 200)) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      print("error nic");
      return ('error');
    }
  }

  Future findCompletedTask(String username, String _jwt) async {
    //print(_jwt);
    // print("findNewTodo");
    // print(username);
    // print(employeeRole);
    // print(employeeArea);
    final http.Response response = await http.post(
      apiAddress + '/api/po/get/completed',
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: _jwt,
      },
      body: jsonEncode({
        "username": username,
      }),
    );
    //print(response);
    if ((response.statusCode == 200)) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      print("error nic");
      return ('error');
    }
  }

  Future retrieveApprovalFlow(String docNumber, String _jwt) async {
    final http.Response response = await http.post(
      apiAddress + '/api/po/getflow',
      headers: <String, String>{
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: _jwt,
      },
      body: jsonEncode(<String, String>{
        "docNumber": docNumber,
      }),
    );
    print("somewhat");
    print(response.body);
    if (response.statusCode == 200) {
      print("somewhat");
      print(response.body);

      return jsonDecode(response.body);
    } else {
      return ('error');
    }
  }

  Future confirmOrderCourier(
      String username, String waybillNum, String _jwt, String photoName) async {
    print("uuu" + username);
    final http.Response response = await http.post(
      apiAddress + '/api/ki/waybill/confirmwaybill',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'x-access-token': _jwt
        //'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "userid": username,
        "waybill_number": waybillNum,
        "image": photoName
      }),
    );
    print(response);
    if (response.statusCode == 200) {
      print("somewhat");

      return jsonDecode(response.body);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      //throw Exception('Failed!');
      return ('error');
    }
  }

  /*
  Future submitSubscription({File file,String filename,String token})async{
    ///MultiPart request
    var request = http.MultipartRequest(
        'POST', Uri.parse("https://your api url with endpoint"),

    );
    Map<String,String> headers={
      "Authorization":"Bearer $token",
      "Content-type": "multipart/form-data"
    };
    request.files.add(
        http.MultipartFile(
           'file',
            file.readAsBytes().asStream(),
            file.lengthSync(),
            filename: filename,
          contentType: MediaType('image','jpeg'),
        ),
    );
    request.headers.addAll(headers);
    request.fields.addAll({
      "name":"test",
      "email":"test@gmail.com",
      "id":"12345"
    });
    print("request: "+request.toString());
    var res = await request.send();
    print("This is response:"+res.toString());
    return res.statusCode;
  }
}
*/
  Future<String> uploadImage(filename, waybillNum) async {
    var url = Uri.parse(apiAddress + '/api/ki/waybill/fileupload');
    var request = http.MultipartRequest('POST', url)
      ..fields['waybillnum'] = waybillNum
      ..files.add(await http.MultipartFile.fromPath('files', filename));
    //request.fields['waybillnum'] = waybillNum;

    var res = await request.send();
    print(res);
    return res.reasonPhrase;
  }
}
