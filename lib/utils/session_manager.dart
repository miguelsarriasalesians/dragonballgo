import 'dart:convert';

import 'package:dragonballgo/resources/shared_preferences_consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  Future<SharedPreferences> getPrefs() async =>
      await SharedPreferences.getInstance();

  Future<String> getCountry() async =>
      await (await getPrefs()).getString(SharedPreferencesConsts.COUNTRY);

  setCountry(String country) async {
    (await getPrefs()).setString(SharedPreferencesConsts.COUNTRY, country);
    print('Country saved succesfully');
  }

  Future<dynamic> getToken() async =>
      await (await getPrefs()).getString(SharedPreferencesConsts.TOKEN);

  setToken(String token) async {
    (await getPrefs())
        .setString(SharedPreferencesConsts.TOKEN, jsonEncode(token));
    print('Auth token saved');
  }

  Future<bool> removeKey(String constant) async =>
      await (await getPrefs()).remove(constant);
}
