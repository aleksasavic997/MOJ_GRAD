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


  bool get getIsReported {
    if (isReported == 1)
      return true;
    else
      return false;
  }

  int get getReportCount => reportCount;

  set setReportCount(int reportCount) => this.reportCount = reportCount;

  int get getId => id;

  set setId(int id) => this.id = id;

  String get getName => name;

  set setName(String name) => this.name = name;

  String get getLastname => lastname;

  set setLastname(String lastname) => this.lastname = lastname;

  String get getUsername => username;

  set setUsername(String username) => this.username = username;

  String get getPassword => password;

  set setPassword(String password) => this.password = password;

  String get getEmail => email;

  set setEmail(String email) => this.email = email;

  String get getPhone => phone;

  set setPhone(String phone) => this.phone = phone;

  int get getCityId => cityId;

  set setCityId(int cityId) => this.cityId = cityId;

  int get getPoints => points;

  set setPoints(int points) => this.points = points;

  String get getCityName => cityName;

  set setCityName(String cityName) => this.cityName = cityName;

  String get getRankName => rankName;

  set setRankName(String rankName) => this.rankName = rankName;

  String get getProfilePhoto => profilePhoto;

  set setProfilePhoto(String profilePhoto) => this.profilePhoto = profilePhoto;

  UserInfo(name, lastname, username, password, email, phone, cityId, points,
      cityName, rankName, profilePhoto, reportCount, userTypeID, isReported, isLogged, postCount) {
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
    this.profilePhoto = profilePhoto;
    this.reportCount = reportCount;
    this.userTypeID = userTypeID;
    this.isReported = isReported;
    this.isLogged = isLogged;
	this.postCount = postCount;
  }

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
    map['profilePhotoPath'] = profilePhoto;
    map['reportCount'] = reportCount;
    map['userTypeID'] = userTypeID;
    map['isReported'] = isReported;
    map['isLogged'] = isLogged;
	map['postCount'] = postCount;
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
    this.profilePhoto = o['profilePhotoPath'];
    this.reportCount = o['reportCount'];
    this.userTypeID = o['userTypeID'];
    this.isReported = o['isReported'];
    this.isLogged = o['isLogged'];
	this.postCount = o['postCount'];
  }
}
