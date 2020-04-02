import 'package:play/bean/coin_user_entity.dart';

coinUserEntityFromJson(CoinUserEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = new CoinUserData().fromJson(json['data']);
	}
	if (json['errorCode'] != null) {
		data.errorCode = json['errorCode']?.toInt();
	}
	if (json['errorMsg'] != null) {
		data.errorMsg = json['errorMsg']?.toString();
	}
	return data;
}

Map<String, dynamic> coinUserEntityToJson(CoinUserEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	data['errorCode'] = entity.errorCode;
	data['errorMsg'] = entity.errorMsg;
	return data;
}

coinUserDataFromJson(CoinUserData data, Map<String, dynamic> json) {
	if (json['coinCount'] != null) {
		data.coinCount = json['coinCount']?.toInt();
	}
	if (json['level'] != null) {
		data.level = json['level']?.toInt();
	}
	if (json['rank'] != null) {
		data.rank = json['rank']?.toInt();
	}
	if (json['userId'] != null) {
		data.userId = json['userId']?.toInt();
	}
	if (json['username'] != null) {
		data.username = json['username']?.toString();
	}
	return data;
}

Map<String, dynamic> coinUserDataToJson(CoinUserData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['coinCount'] = entity.coinCount;
	data['level'] = entity.level;
	data['rank'] = entity.rank;
	data['userId'] = entity.userId;
	data['username'] = entity.username;
	return data;
}