class PostInfo {
  int id;
  int userId;
  String title;
  String description;
  int categoryId;
  DateTime time;
  String location;
  int typeId;
  String imagePath;
  double longitude;
  double latitude;
  int cityID;

  String username;
  int reactionsNumber;
  String typeName;
  int commentsNumber;
  String categoryName;
  String userProfilePhoto;
  int reportCount;
  int isReacted;
  int isReported;
  String timePassed;

  bool get getIsReacted {
    if (isReacted == 1)
      return true;
    else
      return false;
  }

  bool get getIsReported {
    if (isReported == 1)
      return true;
    else
      return false;
  }

  PostInfo(
      userId,
      title,
      description,
      categoryId,
      time,
      location,
      typeId,
      username,
      reactionsNumber,
      typeName,
      commentsNumber,
      categoryName,
      imagePath,
      userProfilePhoto,
      longitude,
      latitude,
      cityID,
      reportCount,
      isReacted,
      isReported,
      timePassed) {
    this.userId = userId;
    this.title = title;
    this.description = description;
    this.categoryId = categoryId;
    this.time = time;
    this.location = location;
    this.typeId = typeId;
    this.username = username;
    this.reactionsNumber = reactionsNumber;
    this.typeName = typeName;
    this.commentsNumber = commentsNumber;
    this.categoryName = categoryName;
    this.imagePath = imagePath;
    this.userProfilePhoto = userProfilePhoto;
    this.longitude = longitude;
    this.latitude = latitude;
    this.cityID = cityID;
    this.reportCount = reportCount;
    this.isReacted = isReacted;
    this.isReported = isReported;
    this.timePassed = timePassed;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) map['id'] = id;
    map['userID'] = userId;
    map['title'] = title;
    map['description'] = description;
    map['categoryID'] = categoryId;
    map['time'] = time.toIso8601String();
    map['location'] = location;
    map['typeID'] = typeId;
    map['username'] = username;
    map['reactionsNumber'] = reactionsNumber;
    map['typeName'] = typeName;
    map['commentsNumber'] = commentsNumber;
    map['categoryName'] = categoryName;
    map['imagePath'] = imagePath;
    map['userProfilePhoto'] = userProfilePhoto;
    map['longitude'] = longitude;
    map['latitude'] = latitude;
    map['cityID'] = cityID;
    map['reportCount'] = reportCount;
    map['isReacted'] = isReacted;
    map['isReported'] = isReported;
    map['timePassed'] = timePassed;
    return map;
  }

  PostInfo.fromObject(dynamic o) {
    this.id = o['id'];
    this.userId = o['userID'];
    this.title = o['title'];
    this.description = o['description'];
    this.categoryId = o['categoryID'];
    //DateTime date = DateTime.tryParse(o['time']);
    this.time = DateTime.tryParse(o['time']);
    this.location = o['location'];
    this.typeId = o['typeID'];
    this.username = o['username'];
    this.reactionsNumber = o['reactionsNumber'];
    this.typeName = o['typeName'];
    this.commentsNumber = o['commentsNumber'];
    this.categoryName = o['categoryName'];
    this.imagePath = o['imagePath'];
    this.userProfilePhoto = o['userProfilePhoto'];
    this.longitude = o['longitude'];
    this.latitude = o['latitude'];
    this.cityID = o['cityID'];
    this.reportCount = o['reportCount'];
    this.isReacted = o['isReacted'];
    this.isReported = o['isReported'];
    this.timePassed = o['timePassed'];
  }
}
