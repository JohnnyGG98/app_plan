import 'package:url_launcher/url_launcher.dart';

abrirURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'No logramos abrir el url: $url';
  }
}

abrirEmail(email) async {
  if(await canLaunch(email)){
    await launch(email);
  } else {
    throw 'No logramos abrir el email: $email';
  }
}

abrir(param) async {
  if(await canLaunch(param)){
    await launch(param);
  } else {
    throw 'No logramos abrir: $param';
  }
}