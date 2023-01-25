class DataModel {
//  final dynamic status;
  final dynamic id;
  final dynamic groupName;

//  final dynamic description;
//  final dynamic created_date;
//  final dynamic v;

  DataModel(this.groupName, this.id);

  DataModel.fromJson(Map jsonMap)
      : groupName = jsonMap['name'],
        id = jsonMap['_id'];

  Map toMapData() {
    var mapGroup = new Map<String, dynamic>();
    mapGroup["name"] = groupName;
    mapGroup['_id'] = id;
    return mapGroup;
  }
}
