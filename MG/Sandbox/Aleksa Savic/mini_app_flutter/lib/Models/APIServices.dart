import 'package:http/http.dart' as http;

class APIServices {
  static String festivaliURL = "http://10.0.2.2:56233/api/Festivals";

  static Future fetchFestivali() async {
    return await http.get(festivaliURL);
  }
}
