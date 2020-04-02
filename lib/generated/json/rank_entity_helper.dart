import 'package:play/bean/rank_entity.dart';

rankEntityFromJson(RankEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = new RankData().fromJson(json['data']);
	}
	if (json['errorCode'] != null) {
		data.errorCode = json['errorCode']?.toInt();
	}
	if (json['errorMsg'] != null) {
		data.errorMsg = json['errorMsg']?.toString();
	}
	return data;
}

Map<String, dynamic> rankEntityToJson(RankEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	data['errorCode'] = entity.errorCode;
	data['errorMsg'] = entity.errorMsg;
	return data;
}

rankDataFromJson(RankData data, Map<String, dynamic> json) {
	if (json['curPage'] != null) {
		data.curPage = json['curPage']?.toInt();
	}
	if (json['datas'] != null) {
		data.datas = new List<RankDataData>();
		(json['datas'] as List).forEach((v) {
			data.datas.add(new RankDataData().fromJson(v));
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

Map<String, dynamic> rankDataToJson(RankData entity) {
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

rankDataDataFromJson(RankDataData data, Map<String, dynamic> json) {
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

Map<String, dynamic> rankDataDataToJson(RankDataData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['coinCount'] = entity.coinCount;
	data['level'] = entity.level;
	data['rank'] = entity.rank;
	data['userId'] = entity.userId;
	data['username'] = entity.username;
	return data;
}