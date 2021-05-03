import 'package:http/http.dart' as http;

class APIServices{
  static String url = "http://10.0.2.2:54317/api/Users";

  static Future fetchComponent() async {
    return await http.get(url);
  }
}