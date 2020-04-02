import 'package:play/bean/coin_entity.dart';

coinEntityFromJson(CoinEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = new CoinData().fromJson(json['data']);
	}
	if (json['errorCode'] != null) {
		data.errorCode = json['errorCode']?.toInt();
	}
	if (json['errorMsg'] != null) {
		data.errorMsg = json['errorMsg']?.toString();
	}
	return data;
}

Map<String, dynamic> coinEntityToJson(CoinEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	data['errorCode'] = entity.errorCode;
	data['errorMsg'] = entity.errorMsg;
	return data;
}

coinDataFromJson(CoinData data, Map<String, dynamic> json) {
	if (json['curPage'] != null) {
		data.curPage = json['curPage']?.toInt();
	}
	if (json['datas'] != null) {
		data.datas = new List<CoinDataData>();
		(json['datas'] as List).forEach((v) {
			data.datas.add(new CoinDataData().fromJson(v));
		});
	}
	if (json['offset'] != null) {
		data.offset = json['offset']?.toInt();
	}
	if (json['over'] != null) {
		data.over = json['over'];
	}
	if (json['pageCount'] != null) {
		data.pageCount = json['pageCount']?.toInt();
	}
	if (json['size'] != null) {
		data.size = json['size']?.toInt();
	}
	if (json['total'] != null) {
		data.total = json['total']?.toInt();
	}
	return data;
}

Map<String, dynamic> coinDataToJson(CoinData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['curPage'] = entity.curPage;
	if (entity.datas != null) {
		data['datas'] =  entity.datas.map((v) => v.toJson()).toList();
	}
	data['offset'] = entity.offset;
	data['over'] = entity.over;
	data['pageCount'] = entity.pageCount;
	data['size'] = entity.size;
	data['total'] = entity.total;
	return data;
}

coinDataDataFromJson(CoinDataData data, Map<String, dynamic> json) {
	if (json['coinCount'] != null) {
		data.coinCount = json['coinCount']?.toInt();
	}
	if (json['date'] != null) {
		data.date = json['date']?.toInt();
	}
	if (json['desc'] != null) {
		data.desc = json['desc']?.toString();
	}
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['reason'] != null) {
		data.reason = json['reason']?.toString();
	}
	if (json['type'] != null) {
		data.type = json['type']?.toInt();
	}
	if (json['userId'] != null) {
		data.userId = json['userId']?.toInt();
	}
	if (json['userName'] != null) {
		data.userName = json['userName']?.toString();
	}
	return data;
}

Map<String, dynamic> coinDataDataToJson(CoinDataData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['coinCount'] = entity.coinCount;
	data['date'] = entity.date;
	data['desc'] = entity.desc;
	data['id'] = entity.id;
	data['reason'] = entity.reason;
	data['type'] = entity.type;
	data['userId'] = entity.userId;
	data['userName'] = entity.userName;
	return data;
}