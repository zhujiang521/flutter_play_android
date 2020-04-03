import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:play/utils/data_utils.dart';

class NetUtils {
  // get请求的封装，传入的两个参数分别是请求URL和请求参数，请求参数以map的形式传入，会在方法体中自动拼接到URL后面
  static Future<String> get(String url, {Map<String, String> params}) async {
    if (params != null && params.isNotEmpty) {
      // 如果参数不为空，则将参数拼接到URL后面
      StringBuffer sb = StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }
    var header = await DataUtils.getHeader();
    http.Response res = await http.get(url,headers: header);
    return res.body;
  }

  // post请求
  static Future<String> post(String url, {Map<String, String> params}) async {
    var header = await DataUtils.getHeader();
    print("网络请求POST：$url");
    http.Response res = await http.post(url, body: params,headers: header);
    return res.body;
  }

}
