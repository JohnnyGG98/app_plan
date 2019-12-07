class ConsApi {

  //static String path = "http://35.202.33.238/api/";

  static String path = "http://192.168.1.10/pera-public/api/";
  //static String path = "http://192.168.137.126/pera-public/api/";

}

bool esResValida(String res) {
  if (res.contains('statuscode')) {
    if (res.contains('200')) {
      return true;
    } else {
      return false; 
    }
  } else {
    return false; 
  }
}