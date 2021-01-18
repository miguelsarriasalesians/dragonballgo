import 'package:dragonballgo/resources/shared_preferences_consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  Future<String> getCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPreferencesConsts.COUNTRY);
  }

  setCountry(String country) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPreferencesConsts.COUNTRY, country);
    print('Country saved succesfully');
  }
}
