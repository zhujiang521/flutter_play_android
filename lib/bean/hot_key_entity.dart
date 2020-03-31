import 'package:play/generated/json/base/json_convert_content.dart';

class HotKeyEntity with JsonConvert<HotKeyEntity> {
	List<HotKeyData> data;
	int errorCode;
	String errorMsg;
}

class HotKeyData with JsonConvert<HotKeyData> {
	int id;
	String link;
	String name;
	int order;
	int visible;
}
