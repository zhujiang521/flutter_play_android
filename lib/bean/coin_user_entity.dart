import 'package:play/generated/json/base/json_convert_content.dart';

class CoinUserEntity with JsonConvert<CoinUserEntity> {
	CoinUserData data;
	int errorCode;
	String errorMsg;
}

class CoinUserData with JsonConvert<CoinUserData> {
	int coinCount;
	int level;
	int rank;
	int userId;
	String username;
}
