import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plan/src/utils/ConsApi.dart';

class UsuarioPV {

  Future<bool> login (String usuario, String password) async {
    final data = {
      'user' : usuario,
      'pass': password,
      'login': 'true'
    };

    print('DATA: ');
    print(data);

    final res = await http.post(
      ConsApi.path + 'v1/usuario/login/',
      body: data
    );

    Map<String, dynamic> decodedRes = json.decode(res.body);

    if (decodedRes['statuscode'] == 200) {
      return true;
    } else {
      print(decodedRes);
      print('***************');
      return false;
    }
  }

}