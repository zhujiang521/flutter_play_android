abstract class AppUrls {
  static const String BASE_URL = 'https://www.wanandroid.com/';

  // 首页banner
  static const String GET_BANNER = BASE_URL + 'banner/json';

  // 首页文章列表
  static const String GET_ARTICLE_LIST = BASE_URL + 'article/list/';

  // 首页搜索热词
  static const String GET_SEARCH_HOT_KEY = BASE_URL + 'hotkey/json';

  // 项目分类
  static const String GET_PROJECT_CLASSIFY = BASE_URL + 'project/tree/json';

  // 项目分类列表
  static const String GET_PROJECT_CLASSIFY_LIST = BASE_URL + 'project/list/';

  // 公众号
  static const String GET_PUBLIC_NUMBER = BASE_URL + 'wxarticle/chapters/json';

  // 公众号文章列表
  static const String GET_PUBLIC_NUMBER_LIST = BASE_URL + 'wxarticle/list/';

  // 登录
  static const String POST_LOGIN = BASE_URL + 'user/login';

  // 注册
  static const String POST_REGISTER = BASE_URL + 'user/register';

  // 登录退出
  static const String GET_LOGOUT = BASE_URL + 'user/logout/json';

}
