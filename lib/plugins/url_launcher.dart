import '../util/utility.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {

  // url => 'https://flutter.dev'
  static Future<bool> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      return false;
    }
    return true;
  }

  // number +593999123757
  static callNumber(String number){
    String url = 'tel:$number';
    launchURL(url);
  }

  // phone 0999123456
  static launchWS(String phone, String text, context) async {
    if (phone == null || phone.length != 10){
      Utility.showToast(context, 'Número de contacto invalido');
      return;
    }
    String parsePhone = '593${phone.substring(1)}';
    String url = 'https://api.whatsapp.com/send?phone=$parsePhone&text=$text';
    await launchURL(url);
  }

}