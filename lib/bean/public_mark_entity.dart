import 'package:play/generated/json/base/json_convert_content.dart';

class PublicMarkEntity with JsonConvert<PublicMarkEntity> {
	List<PublicMarkData> data;
	int errorCode;
	String errorMsg;
}

class PublicMarkData with JsonConvert<PublicMarkData> {
	List<dynamic> children;
	int courseId;
	int id;
	String name;
	int order;
	int parentChapterId;
	bool userControlSetTop;
	int visible;
}
