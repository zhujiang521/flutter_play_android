import 'package:play/generated/json/base/json_convert_content.dart';

class RankEntity with JsonConvert<RankEntity> {
	RankData data;
	int errorCode;
	String errorMsg;
}

class RankData with JsonConvert<RankData> {
	int curPage;
	List<RankDataData> datas;
	int offset;
	bool over;
	int pageCount;
	int size;
	int total;
}

class RankDataData with JsonConvert<RankDataData> {
	int coinCount;
	int level;
	int rank;
	int userId;
	String username;
}
