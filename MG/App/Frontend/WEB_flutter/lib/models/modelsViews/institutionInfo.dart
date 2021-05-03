class InstitutionInfo {
  int id;
  String name;
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
  int userTypeID;
  String address;
  bool isVerified;
  int postCount;
  
 bool get getIsVerified => isVerified;

 set setIsVerified(bool isVerified) => this.isVerified = isVerified;

 int get getReportCount => reportCount;

 set setReportCount(int reportCount) => this.reportCount = reportCount;
  
 int get getId => id;

 set setId(int id) => this.id = id;

 String get getName => name;

 set setName(String name) => this.name = name;

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

  InstitutionInfo(name, username, password, email, phone, cityId, points, cityName, rankName, profilePhoto, reportCount, userTypeID, address,  isVerified, postCount) {
    this.name = name;
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
    this.address = address;
    this.isVerified = isVerified;
    this.postCount = postCount;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) map['id'] = id;
    map['name'] = name;
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
    map['address'] = address;
    map['isVerified'] = isVerified;
    map['postCount'] = postCount;
    return map;
  }

  InstitutionInfo.fromObject(dynamic o) {
    this.id = o['id'];
    this.name = o['name'];
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
    this.address = o['address'];
    this.isVerified = o['isVerified'];
    this.postCount = o['postCount'];
  }

}