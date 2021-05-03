import 'package:http/http.dart' as http;


class APIServices {
  static String filmoviURL = "http://10.0.2.2:54794/api/Films";

  static Future fetchFilmovi() async {
    return await http.get(filmoviURL);
  }
}