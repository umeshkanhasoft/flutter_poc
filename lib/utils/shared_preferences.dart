import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static final SharedPreferencesService _instance =
      SharedPreferencesService._internal();

  factory SharedPreferencesService() => _instance;

  SharedPreferencesService._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setIsLogin(bool value) async {
    await _prefs?.setBool('isLogin', value);
  }

  Future<bool?> isLogin() async {
    return _prefs?.getBool('isLogin');
  }

  Future<String?> getLoginUser() async {
    return _prefs?.getString('loginUser');
  }

  Future<void> setLoginUser(String loginUser) async {
    await _prefs?.setString('loginUser', loginUser);
  }

  Future<void> setFcmToken(String fcmToken) async {
    await _prefs?.setString('fcmToken', fcmToken);
  }

  Future<String?> getFcmToken() async {
    return _prefs?.getString('fcmToken');
  }

  Future<void> setSessionId(String fcmToken) async {
    await _prefs?.setString('sessionId', fcmToken);
  }

  Future<String?> getSessionId() async {
    return _prefs?.getString('sessionId');
  }

  Future<void> setCurrentChatId(String request) async {
    await _prefs?.setString('currentChatId', request);
  }

  Future setCreatePostRequest(String req) async {
    await _prefs?.setString('create_post', req);
  }

  Future<String?> getCreatePostRequest() async {
    return _prefs?.getString('create_post');
  }

  Future<String?> getCurrentChatId() async {
    return _prefs?.getString('currentChatId');
  }

  Future<void> setReconnectBattle(String battleRequest) async {
    await _prefs?.setString('battleRequest', battleRequest);
  }

  Future<String?> getReconnectBattle() async {
    return _prefs?.getString('battleRequest');
  }

  clear() async {
    await _prefs?.clear();
  }
}
