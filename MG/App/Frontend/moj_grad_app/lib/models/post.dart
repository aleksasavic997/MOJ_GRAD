class Post
{
  int id;
  int userId;
  String title;
  String description;
  int categoryId;
  DateTime time;
  String location;
  int typeId;
  String imagePath;
  int cityID;
  double longitude;
  double latitude;

  Post(userId, title, description, categoryId, time, location, typeId, imagePath, longitude, latitude,cityID)
  {
    this.userId = userId;
    this.title = title;
    this.description = description;
    this.categoryId = categoryId;
    this.time = time;
    this.location = location;
    this.typeId = typeId;
    this.imagePath = imagePath;
    this.longitude = longitude;
    this.latitude = latitude;
    this.cityID = cityID;
  }

    Post.id(id,userId, title, description, categoryId, time, location, typeId, imagePath, longitude, latitude,cityID)
  {
    this.id = id;
    this.userId = userId;
    this.title = title;
    this.description = description;
    this.categoryId = categoryId;
    this.time = time;
    this.location = location;
    this.typeId = typeId;
    this.imagePath = imagePath;
    this.longitude = longitude;
    this.latitude = latitude;
    this.cityID = cityID;
  }

  Map<String, dynamic> toMap() 
  {
    var map = Map<String, dynamic>();
    if(id != null)
      map['id'] = id;
    map['userID'] = userId;
    map['title'] = title;
    map['description'] = description;
    map['categoryID'] = categoryId;
    map['time'] = time.toIso8601String();
    map['location'] = location;
    map['typeID'] = typeId;
    map['imagePath'] = imagePath;
    map['longitude'] = longitude;
    map['latitude'] = latitude;
    map['cityID'] = cityID;
    return map;
  }

  Post.fromObject(dynamic o) 
  {
    this.id = o['id'];
    this.userId = o['userID'];
    this.title = o['title'];
    this.description = o['description'];
    this.categoryId = o['categoryID'];
    this.time = DateTime.tryParse(o['time']);
    this.time = o['time'];
    this.location = o['location'];
    this.typeId = o['typeID'];
    this.imagePath = o['imagePath'];
    this.longitude = o['longitude'];
    this.latitude = o['latitude'];
    this.cityID = o['cityID'];
  }
  
}