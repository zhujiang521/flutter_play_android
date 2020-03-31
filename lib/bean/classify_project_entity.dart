import 'package:play/generated/json/base/json_convert_content.dart';

class ClassifyProjectEntity with JsonConvert<ClassifyProjectEntity> {
	List<ClassifyProjectData> data;
	int errorCode;
	String errorMsg;
}

class ClassifyProjectData with JsonConvert<ClassifyProjectData> {
	List<dynamic> children;
	int courseId;
	int id;
	String name;
	int order;
	int parentChapterId;
	bool userControlSetTop;
	int visible;
}
