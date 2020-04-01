abstract class AppUrls {
  static const String BASE_URL = 'https://www.wanandroid.com/';

  // 首页banner
  static const String GET_BANNER = BASE_URL + 'banner/json';

  // 首页文章列表
  static const String GET_ARTICLE_LIST = BASE_URL + 'article/list/';

  // 首页置顶文章列表
  static const String GET_TOP_ARTICLE_LIST = BASE_URL + 'article/top/json';

  // 首页搜索热词
  static const String GET_SEARCH_HOT_KEY = BASE_URL + 'hotkey/json';

  //搜索 https://www.wanandroid.com/article/query/0/json
  static const String POST_QUERY_KEY = BASE_URL + 'article/query/';

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

  // 收藏站内文章 lg/collect/1165/json
  static const String POST_COLLECT_ARTICLE = BASE_URL + 'lg/collect/';

  // 取消收藏站内文章 lg/collect/1165/json
  static const String POST_UNCOLLECT_ARTICLE = BASE_URL + 'lg/uncollect_originId/';

  // 收藏文章列表
  static const String GET_COLLECT_ARTICLE = BASE_URL + 'lg/collect/list/';

}
