import 'package:play/generated/json/base/json_convert_content.dart';

class CoinEntity with JsonConvert<CoinEntity> {
	CoinData data;
	int errorCode;
	String errorMsg;
}

class CoinData with JsonConvert<CoinData> {
	int curPage;
	List<CoinDataData> datas;
	int offset;
	bool over;
	int pageCount;
	int size;
	int total;
}

class CoinDataData with JsonConvert<CoinDataData> {
	int coinCount;
	int date;
	String desc;
	int id;
	String reason;
	int type;
	int userId;
	String userName;
}
