import 'package:play/bean/article_entity.dart';
import 'package:play/generated/json/base/json_convert_content.dart';

class ProjectListEntity with JsonConvert<ProjectListEntity> {
	ProjectListData data;
	int errorCode;
	String errorMsg;
}

class ProjectListData with JsonConvert<ProjectListData> {
	int curPage;
	List<ArticleDataData> datas;
	int offset;
	bool over;
	int pageCount;
	int size;
	int total;
}
