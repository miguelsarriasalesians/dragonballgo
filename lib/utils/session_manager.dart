import 'package:dragonballgo/resources/shared_preferences_consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  Future<SharedPreferences> getPrefs() async =>
      await SharedPreferences.getInstance();

  Future<String> getCountry() async =>
      (await getPrefs()).getString(SharedPreferencesConsts.COUNTRY);

  setCountry(String country) async {
    (await getPrefs()).setString(SharedPreferencesConsts.COUNTRY, country);
    print('Country saved succesfully');
  }

  Future<dynamic> getToken() async {
    String token = (await getPrefs()).getString(SharedPreferencesConsts.TOKEN);
    return token != null ? token.replaceAll("\"", "") : null;
  }

  setToken(String token) async {
    (await getPrefs()).setString(SharedPreferencesConsts.TOKEN, token);
    print('Auth token saved');
  }

  Future<bool> removeKey(String constant) async =>
      await (await getPrefs()).remove(constant);

  Future<dynamic> getUserData() async {
    String userData =
        (await getPrefs()).getString(SharedPreferencesConsts.USER);
    return userData != null ? userData.replaceAll("\"", "") : null;
  }

  setUserData(String userData) async {
    (await getPrefs()).setString(SharedPreferencesConsts.USER, userData);
    print('Auth token saved');
  }
}
