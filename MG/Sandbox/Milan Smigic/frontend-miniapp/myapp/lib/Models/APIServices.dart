import 'package:http/http.dart' as http;

class APIServices {
  static String serijeURL = "http://10.0.2.2:56856/api/Serijes";

  static Future fetchSerije() async {
    return await http.get(serijeURL);
  }
}