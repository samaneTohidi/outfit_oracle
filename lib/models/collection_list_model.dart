/// collections : [{"id":823,"title":"{\"en\":\"Modern Minimalist Mix\",\"ar\":\"المعاصر البسيط\"}","image":"https://i.pinimg.com/236x/89/02/25/89022507b1129fe66c69fd75482fcc55.jpg","rule_count":16,"tag_count":12,"created_at":"2024-03-03T08:45:11.474749Z","modified_at":"2024-05-16T06:13:22.274348Z"},{"id":822,"title":"{\"en\":\"Casual Elegance in Neutral Tones\",\"ar\":\"الأناقة الكاجوال بالألوان المحايدة\"}","image":"https://i.pinimg.com/236x/9d/f8/ee/9df8ee74402a396f80625ef07a70853a.jpg","rule_count":14,"tag_count":15,"created_at":"2024-03-03T08:44:57.00634Z","modified_at":"2024-04-28T06:10:36.058283Z"},{"id":821,"title":"{\"en\":\"Contemporary Chic with a Traditional Twist\",\"ar\":\"عنوان: الأناقة العصرية بلمسة تقليدية\"}","image":"https://i.pinimg.com/236x/72/72/33/72723310acdd5c67ed9a071827446615.jpg","rule_count":13,"tag_count":15,"created_at":"2024-03-03T08:44:49.297575Z","modified_at":"2024-05-13T14:49:11.79755Z"},{"id":820,"title":"{\"en\":\"Modern Layered Elegance\",\"ar\":\"الأناقة العصرية المتدرجة\"}","image":"https://i.pinimg.com/236x/4a/9d/cb/4a9dcb9fa84a547f616e4ceac077b771.jpg","rule_count":19,"tag_count":13,"created_at":"2024-03-03T08:44:35.249777Z","modified_at":"2024-04-28T06:16:52.342004Z"},{"id":819,"title":"{\"en\":\"Modern Elegance with a Classic Touch\",\"ar\":\"الأناقة العصرية مع لمسة كلاسيكية\"}","image":"https://i.pinimg.com/236x/e1/f7/01/e1f70113945b3bc5e362648f22923292.jpg","rule_count":14,"tag_count":14,"created_at":"2024-03-03T08:44:21.368048Z","modified_at":"2024-04-28T06:17:17.192245Z"},{"id":818,"title":"{\"en\":\"Casual Contrast\",\"ar\":\"عنوان: كاجوال متباين\"}","image":"https://i.pinimg.com/236x/1a/1c/73/1a1c73c301b6f74b99a93a40b29073a2.jpg","rule_count":14,"tag_count":14,"created_at":"2024-03-03T08:44:09.419464Z","modified_at":"2024-05-15T08:19:14.288021Z"},{"id":817,"title":"{\"en\":\"Chic Professionalism\",\"ar\":\"الأناقة المهنية\"}","image":"https://i.pinimg.com/236x/06/8b/5f/068b5ff30b273b098172bf3c87541447.jpg","rule_count":20,"tag_count":16,"created_at":"2024-03-03T08:43:58.951271Z","modified_at":"2024-04-28T06:18:15.012044Z"},{"id":816,"title":"{\"en\":\"Modern Minimalist Elegance\",\"ar\":\"الأناقة البسيطة الحديثة\"}","image":"https://i.pinimg.com/236x/47/9f/62/479f62a921ad89dddc20637e08588e04.jpg","rule_count":15,"tag_count":15,"created_at":"2024-03-03T08:43:22.322646Z","modified_at":"2024-04-28T06:18:52.204725Z"},{"id":815,"title":"{\"en\":\"Modern Neutral Tones Ensemble\",\"ar\":\"طقم الألوان المحايدة العصري\"}","image":"https://i.pinimg.com/236x/4d/84/a1/4d84a1134c88d199580b40570169f7d3.jpg","rule_count":19,"tag_count":13,"created_at":"2024-03-03T08:43:11.294546Z","modified_at":"2024-04-28T06:19:36.50687Z"},{"id":814,"title":"{\"en\":\"Earthy Modesty\",\"ar\":\"الأناقة الأرضية\"}","image":"https://i.pinimg.com/236x/ec/b5/89/ecb589e30aa62fbe773b56628490de5f.jpg","rule_count":14,"tag_count":12,"created_at":"2024-03-03T08:42:56.058708Z","modified_at":"2024-04-28T06:20:13.685713Z"}]
/// count_all : 603

class CollectionListModel {
  CollectionListModel({
      List<Collections>? collections, 
      int? countAll,}){
    _collections = collections;
    _countAll = countAll;
}

  CollectionListModel.fromJson(dynamic json) {
    if (json['collections'] != null) {
      _collections = [];
      json['collections'].forEach((v) {
        _collections?.add(Collections.fromJson(v));
      });
    }
    _countAll = json['count_all'];
  }
  List<Collections>? _collections;
  int? _countAll;
CollectionListModel copyWith({  List<Collections>? collections,
  int? countAll,
}) => CollectionListModel(  collections: collections ?? _collections,
  countAll: countAll ?? _countAll,
);
  List<Collections>? get collections => _collections;
  int? get countAll => _countAll;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_collections != null) {
      map['collections'] = _collections?.map((v) => v.toJson()).toList();
    }
    map['count_all'] = _countAll;
    return map;
  }

}

/// id : 823
/// title : "{\"en\":\"Modern Minimalist Mix\",\"ar\":\"المعاصر البسيط\"}"
/// image : "https://i.pinimg.com/236x/89/02/25/89022507b1129fe66c69fd75482fcc55.jpg"
/// rule_count : 16
/// tag_count : 12
/// created_at : "2024-03-03T08:45:11.474749Z"
/// modified_at : "2024-05-16T06:13:22.274348Z"

class Collections {
  Collections({
      int? id, 
      String? title, 
      String? image, 
      int? ruleCount, 
      int? tagCount, 
      String? createdAt, 
      String? modifiedAt,}){
    _id = id;
    _title = title;
    _image = image;
    _ruleCount = ruleCount;
    _tagCount = tagCount;
    _createdAt = createdAt;
    _modifiedAt = modifiedAt;
}

  Collections.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _image = json['image'];
    _ruleCount = json['rule_count'];
    _tagCount = json['tag_count'];
    _createdAt = json['created_at'];
    _modifiedAt = json['modified_at'];
  }
  int? _id;
  String? _title;
  String? _image;
  int? _ruleCount;
  int? _tagCount;
  String? _createdAt;
  String? _modifiedAt;
Collections copyWith({  int? id,
  String? title,
  String? image,
  int? ruleCount,
  int? tagCount,
  String? createdAt,
  String? modifiedAt,
}) => Collections(  id: id ?? _id,
  title: title ?? _title,
  image: image ?? _image,
  ruleCount: ruleCount ?? _ruleCount,
  tagCount: tagCount ?? _tagCount,
  createdAt: createdAt ?? _createdAt,
  modifiedAt: modifiedAt ?? _modifiedAt,
);
  int? get id => _id;
  String? get title => _title;
  String? get image => _image;
  int? get ruleCount => _ruleCount;
  int? get tagCount => _tagCount;
  String? get createdAt => _createdAt;
  String? get modifiedAt => _modifiedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['image'] = _image;
    map['rule_count'] = _ruleCount;
    map['tag_count'] = _tagCount;
    map['created_at'] = _createdAt;
    map['modified_at'] = _modifiedAt;
    return map;
  }

}