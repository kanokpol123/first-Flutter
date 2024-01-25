import 'dart:convert';
import '../models/Menu.dart';
import 'package:http/http.dart' as http;

class MenuService {
  //call api function
  static Future<List<MenuItem>> getMenuItems() async {
    var url = Uri.parse('https://us-central1-flutter-class-buu.cloudfunctions.net/menu');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<MenuItem> menuItems = data.map((item) => MenuItem.fromJson(item)).toList();
      return menuItems;
    } else {
      throw Exception('Failed to load menu items');
    }
  }
}
