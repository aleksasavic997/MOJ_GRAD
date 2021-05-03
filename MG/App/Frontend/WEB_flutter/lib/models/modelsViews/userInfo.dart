class UserInfo {
  int id;
  String name;
  String lastname;
  String username;
  String password;
  String email;
  String phone;
  int cityId;
  int points;
  String cityName;
  String rankName;
  String profilePhoto;
  int reportCount;
  int postCount;
  int userTypeID;
  int isReported;
  bool isLogged;

  String get fullName => this.name + " " + this.lastname; //kada se kuca prvo ime pa prezime
  String get fullLastName => this.lastname + " " + this.name; //kada se kuca prvo prezime pa ime


  UserInfo(name, lastname, username, password, email, phone, cityId, points, cityName, rankName, reportCount, profilePhoto, postCount,  userTypeID, isReported, isLogged) {
    this.name = name;
    this.lastname = lastname;
    this.username = username;
    this.password = password;
    this.email = email;
    this.phone = phone;
    this.cityId = cityId;
    this.points = points;
    this.cityName = cityName;
    this.rankName = rankName;
    this.reportCount = reportCount;
    this.profilePhoto = profilePhoto;
	  this.postCount = postCount;
    this.userTypeID = userTypeID;
    this.isReported = isReported;
    this.isLogged = isLogged;  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) map['id'] = id;
    map['name'] = name;
    map['lastname'] = lastname;
    map['username'] = username;
    map['password'] = password;
    map['email'] = email;
    map['phone'] = phone;
    map['cityID'] = cityId;
    map['points'] = points;
    map['cityName'] = cityName;
    map['rankName'] = rankName;
    map['reportCount'] = reportCount;
    map['profilePhotoPath'] = profilePhoto;
  	map['postCount'] = postCount;
    map['userTypeID'] = userTypeID;
    map['isReported'] = isReported;
    map['isLogged'] = isLogged;
    return map;
  }

  UserInfo.fromObject(dynamic o) {
    this.id = o['id'];
    this.name = o['name'];
    this.lastname = o['lastname'];
    this.username = o['username'];
    this.password = o['password'];
    this.email = o['email'];
    this.phone = o['phone'];
    this.cityId = o['cityID'];
    this.points = o['points'];
    this.cityName = o['cityName'];
    this.rankName = o['rankName'];
    this.reportCount = o['reportCount'];
    this.profilePhoto = o['profilePhotoPath'];
	  this.postCount = o['postCount'];
    this.userTypeID = o['userTypeID'];
    this.isReported = o['isReported'];
    this.isLogged = o['isLogged'];
  }

}