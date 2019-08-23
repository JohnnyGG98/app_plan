import 'package:url_launcher/url_launcher.dart';

abrirURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'No logramos abrir el url: $url';
  }
}

abrirEmail(String email) async {
  String urlemail = 'mailto:$email?subject=Mensaje&body=PLAN';
  if(await canLaunch(urlemail)){
    await launch(urlemail);
  } else {
    throw 'No logramos abrir el email: $urlemail';
  }
}

abrir(param) async {
  if(await canLaunch(param)){
    await launch(param);
  } else {
    throw 'No logramos abrir: $param';
  }
}