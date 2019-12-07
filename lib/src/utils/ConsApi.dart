import 'package:http/http.dart' as http;

class ConsApi {

  //static String path = "http://35.202.33.238/api/";

  static String path = "http://192.168.1.10/pera-public/api/";
  //static String path = "http://192.168.137.126/pera-public/api/";

}

bool esResValida(http.Response res) {
  String body = res.body;

  print('Statuscode directo: ' + res.statusCode.toString());

  if (body.contains('statuscode')) {
    if (body.contains('200')) {
      return true;
    } else {
      print('Error: \n' + body);
      return false; 
    }
  } else {
    return false; 
  }
}