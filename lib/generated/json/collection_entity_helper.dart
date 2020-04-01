import 'package:play/bean/collection_entity.dart';

collectionEntityFromJson(CollectionEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = new CollectionData().fromJson(json['data']);
	}
	if (json['errorCode'] != null) {
		data.errorCode = json['errorCode']?.toInt();
	}
	if (json['errorMsg'] != null) {
		data.errorMsg = json['errorMsg']?.toString();
	}
	return data;
}

Map<String, dynamic> collectionEntityToJson(CollectionEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	data['errorCode'] = entity.errorCode;
	data['errorMsg'] = entity.errorMsg;
	return data;
}

collectionDataFromJson(CollectionData data, Map<String, dynamic> json) {
	if (json['curPage'] != null) {
		data.curPage = json['curPage']?.toInt();
	}
	if (json['datas'] != null) {
		data.datas = new List<CollectionDataData>();
		(json['datas'] as List).forEach((v) {
			data.datas.add(new CollectionDataData().fromJson(v));
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

Map<String, dynamic> collectionDataToJson(CollectionData entity) {
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

collectionDataDataFromJson(CollectionDataData data, Map<String, dynamic> json) {
	if (json['author'] != null) {
		data.author = json['author']?.toString();
	}
	if (json['chapterId'] != null) {
		data.chapterId = json['chapterId']?.toInt();
	}
	if (json['chapterName'] != null) {
		data.chapterName = json['chapterName']?.toString();
	}
	if (json['courseId'] != null) {
		data.courseId = json['courseId']?.toInt();
	}
	if (json['desc'] != null) {
		data.desc = json['desc']?.toString();
	}
	if (json['envelopePic'] != null) {
		data.envelopePic = json['envelopePic']?.toString();
	}
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['link'] != null) {
		data.link = json['link']?.toString();
	}
	if (json['niceDate'] != null) {
		data.niceDate = json['niceDate']?.toString();
	}
	if (json['origin'] != null) {
		data.origin = json['origin']?.toString();
	}
	if (json['originId'] != null) {
		data.originId = json['originId']?.toInt();
	}
	if (json['publishTime'] != null) {
		data.publishTime = json['publishTime']?.toInt();
	}
	if (json['title'] != null) {
		data.title = json['title']?.toString();
	}
	if (json['userId'] != null) {
		data.userId = json['userId']?.toInt();
	}
	if (json['visible'] != null) {
		data.visible = json['visible']?.toInt();
	}
	if (json['zan'] != null) {
		data.zan = json['zan']?.toInt();
	}
	return data;
}

Map<String, dynamic> collectionDataDataToJson(CollectionDataData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['author'] = entity.author;
	data['chapterId'] = entity.chapterId;
	data['chapterName'] = entity.chapterName;
	data['courseId'] = entity.courseId;
	data['desc'] = entity.desc;
	data['envelopePic'] = entity.envelopePic;
	data['id'] = entity.id;
	data['link'] = entity.link;
	data['niceDate'] = entity.niceDate;
	data['origin'] = entity.origin;
	data['originId'] = entity.originId;
	data['publishTime'] = entity.publishTime;
	data['title'] = entity.title;
	data['userId'] = entity.userId;
	data['visible'] = entity.visible;
	data['zan'] = entity.zan;
	return data;
}