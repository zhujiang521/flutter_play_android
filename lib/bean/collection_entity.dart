import 'package:play/generated/json/base/json_convert_content.dart';

class CollectionEntity with JsonConvert<CollectionEntity> {
	CollectionData data;
	int errorCode;
	String errorMsg;
}

class CollectionData with JsonConvert<CollectionData> {
	int curPage;
	List<CollectionDataData> datas;
	int offset;
	bool over;
	int pageCount;
	int size;
	int total;
}

class CollectionDataData with JsonConvert<CollectionDataData> {
	String author;
	int chapterId;
	String chapterName;
	int courseId;
	String desc;
	String envelopePic;
	int id;
	String link;
	String niceDate;
	String origin;
	int originId;
	int publishTime;
	String title;
	int userId;
	int visible;
	int zan;
}
