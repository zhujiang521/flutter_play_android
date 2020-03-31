import 'package:play/bean/login_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataUtils {

  static const String SP_COLOR_THEME_INDEX = "colorThemeIndex";

  //用户信息字段
  static const String SP_USERNAME = 'username';
  static const String SP_PASSWORD = 'password';
  
  static const String SP_IS_LOGIN = "isLogin";
  static const String SP_ADMIN = "admin";
  static const String SP_CHAPTERTOPS = "chapterTops";
  static const String SP_COLLECTIDS = "collectIds";
  static const String SP_EMAIL = "email";
  static const String SP_ICON = "icon";
  static const String SP_ID = "id";
  static const String SP_NICKNAME = "nickname";
  static const String SP_password = "password";
  static const String SP_PUBLICNAME = "publicName";
  static const String SP_TOKEN = "token";
  static const String SP_TYPE = "type";
  static const String SP_username = "username";

  // 设置选择的主题色
  static setColorTheme(int colorThemeIndex) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt(SP_COLOR_THEME_INDEX, colorThemeIndex);
  }

  static Future<int> getColorThemeIndex() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getInt(SP_COLOR_THEME_INDEX);
  }

  //是否登录
  static Future<bool> isLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isLogin = sp.getBool(SP_IS_LOGIN);
    return isLogin != null && isLogin;
  }

  static Future<void> saveLoginInfo(LoginData loginData) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp
      ..setBool(SP_ADMIN, loginData.admin)
//      ..setStringList(SP_chapterTops, loginData.chapterTops)
//      ..setStringList(SP_collectIds, loginData.collectIds)
      ..setString(SP_EMAIL, loginData.email)
      ..setString(SP_ICON, loginData.icon)
      ..setInt(SP_ID, loginData.id)
      ..setString(SP_NICKNAME, loginData.nickname)
      ..setString(SP_password, loginData.password)
      ..setString(SP_PUBLICNAME, loginData.publicName)
      ..setString(SP_TOKEN, loginData.token)
      ..setInt(SP_TYPE, loginData.type)
      ..setString(SP_username, loginData.username)
      ..setBool(SP_IS_LOGIN, true);
  }


  static Future<void> clearLoginInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp
      ..setBool(SP_ADMIN, false)
      ..setStringList(SP_CHAPTERTOPS, null)
      ..setStringList(SP_COLLECTIDS, null)
      ..setString(SP_EMAIL, '')
      ..setString(SP_ICON, "")
      ..setInt(SP_ID, -1)
      ..setString(SP_NICKNAME, '')
      ..setString(SP_password, '')
      ..setString(SP_PUBLICNAME, '')
      ..setString(SP_TOKEN, '')
      ..setInt(SP_TYPE, -1)
      ..setString(SP_username, '')
      ..setBool(SP_IS_LOGIN, false);
  }


  //获取用户信息
  static Future<LoginData> getUserInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isLogin = sp.getBool(SP_IS_LOGIN);
    if (isLogin == null || !isLogin) {
      return null;
    }
    LoginData user = new LoginData();
    user.admin = sp.getBool(SP_ADMIN);
//    user.chapterTops = sp.getStringList(SP_chapterTops);
//    user.collectIds = sp.getStringList(SP_collectIds);
    user.email = sp.getString(SP_EMAIL);
    user.icon = sp.getString(SP_ICON);
    user.id = sp.getInt(SP_ID);
    user.nickname = sp.getString(SP_NICKNAME);
    user.password = sp.getString(SP_password);
    user.publicName = sp.getString(SP_PUBLICNAME);
    user.token = sp.getString(SP_TOKEN);
    user.type = sp.getInt(SP_TYPE);
    user.username = sp.getString(SP_username);
    return user;
  }

}
