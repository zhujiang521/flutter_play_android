import 'package:play/bean/login_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataUtils {

  static const String SP_COLOR_THEME_INDEX = "colorThemeIndex";

  //用户信息字段
  static const String SP_USERNAME = 'username';
  static const String SP_PASSWORD = 'password';
  
  static const String SP_IS_LOGIN = "isLogin";
  static const String SP_admin = "admin";
  static const String SP_chapterTops = "chapterTops";
  static const String SP_collectIds = "collectIds";
  static const String SP_email = "email";
  static const String SP_icon = "icon";
  static const String SP_id = "id";
  static const String SP_nickname = "nickname";
  static const String SP_password = "password";
  static const String SP_publicName = "publicName";
  static const String SP_token = "token";
  static const String SP_type = "type";
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
      ..setBool(SP_admin, loginData.admin)
//      ..setStringList(SP_chapterTops, loginData.chapterTops)
//      ..setStringList(SP_collectIds, loginData.collectIds)
      ..setString(SP_email, loginData.email)
      ..setString(SP_icon, loginData.icon)
      ..setInt(SP_id, loginData.id)
      ..setString(SP_nickname, loginData.nickname)
      ..setString(SP_password, loginData.password)
      ..setString(SP_publicName, loginData.publicName)
      ..setString(SP_token, loginData.token)
      ..setInt(SP_type, loginData.type)
      ..setString(SP_username, loginData.username)
      ..setBool(SP_IS_LOGIN, true);
  }


  static Future<void> clearLoginInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp
      ..setBool(SP_admin, false)
      ..setStringList(SP_chapterTops, null)
      ..setStringList(SP_collectIds, null)
      ..setString(SP_email, '')
      ..setString(SP_icon, "")
      ..setInt(SP_id, -1)
      ..setString(SP_nickname, '')
      ..setString(SP_password, '')
      ..setString(SP_publicName, '')
      ..setString(SP_token, '')
      ..setInt(SP_type, -1)
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
    user.admin = sp.getBool(SP_admin);
//    user.chapterTops = sp.getStringList(SP_chapterTops);
//    user.collectIds = sp.getStringList(SP_collectIds);
    user.email = sp.getString(SP_email);
    user.icon = sp.getString(SP_icon);
    user.id = sp.getInt(SP_id);
    user.nickname = sp.getString(SP_nickname);
    user.password = sp.getString(SP_password);
    user.publicName = sp.getString(SP_publicName);
    user.token = sp.getString(SP_token);
    user.type = sp.getInt(SP_type);
    user.username = sp.getString(SP_username);
    return user;
  }

}
