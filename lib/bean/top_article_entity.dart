import 'package:play/bean/article_entity.dart';
import 'package:play/generated/json/base/json_convert_content.dart';

class TopArticleEntity with JsonConvert<TopArticleEntity> {
	List<ArticleDataData> data;
	int errorCode;
	String errorMsg;
}

class TopArticleData with JsonConvert<TopArticleData> {
	String apkLink;
	int audit;
	String author;
	bool canEdit;
	int chapterId;
	String chapterName;
	bool collect;
	int courseId;
	String desc;
	String descMd;
	String envelopePic;
	bool fresh;
	int id;
	String link;
	String niceDate;
	String niceShareDate;
	String origin;
	String prefix;
	String projectLink;
	int publishTime;
	int selfVisible;
	int shareDate;
	String shareUser;
	int superChapterId;
	String superChapterName;
	List<dynamic> tags;
	String title;
	int type;
	int userId;
	int visible;
	int zan;
}
