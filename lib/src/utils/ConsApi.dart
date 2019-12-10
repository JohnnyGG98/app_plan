import 'dart:convert';

import 'package:http/http.dart' as http;

class ConsApi {

  static String path = "http://34.69.91.44/api/";

  //static String path = "http://192.168.1.10/pera-public/api/";
  //static String path = "http://192.168.137.126/pera-public/api/";

}

bool esResValida(http.Response res) {
  String body = res.body;

  print('Statuscode directo: ' + res.statusCode.toString());
  print(res.toString());

  if (body.contains('statuscode')) {
    Map<String, dynamic> decodedRes = json.decode(res.body);
    if (decodedRes['statuscode'] == 200) {
      return true;
    } else {
      print('Error: \n' + body);
      return false; 
    }
  } else {
    return false; 
  }
}