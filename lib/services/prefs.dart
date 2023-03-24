import 'package:shared_preferences/shared_preferences.dart';

// class Prefs {
//   //singleton class to save the user last state

//   static final Prefs _instance = Prefs._internal();

//   factory Prefs() {
//     return _instance;
//   }

//   Prefs._internal() {}

//   static Future<SharedPreferences> getInstance() async {
//     return await SharedPreferences.getInstance();
//   }
// }

class UserData {
  static Future<int?> readData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt("lastIndex");
  }

  static Future<void> setData(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("lastIndex",index);
  }
}
