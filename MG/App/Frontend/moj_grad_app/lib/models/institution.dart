class Institution {
  int id;
  String name;
  String username;
  String password;
  String email;
  String phone;
  int cityId;
  String profilePhoto;
  int userTypeID;
  String address;
  double longitude;
  double latitude;
  bool isVerified;


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

 String get getProfilePhoto => profilePhoto;

 set setProfilePhoto(String profilePhoto) => this.profilePhoto = profilePhoto;

  Institution(name, username, password, email, phone, cityId, profilePhoto, userTypeID, address, longitude, latitude,isVerified) {
    this.name = name;
    this.username = username;
    this.password = password;
    this.email = email;
    this.phone = phone;
    this.cityId = cityId;
    this.profilePhoto = profilePhoto;
    this.userTypeID = userTypeID;
    this.address = address;
    this.longitude = longitude;
    this.latitude = latitude;
    this.isVerified = isVerified;
  }

  Institution.id(id, name, username, password, email, phone, cityId, profilePhoto, userTypeID, address, longitude, latitude,isVerified) {
    this.id = id;
    this.name = name;
    this.username = username;
    this.password = password;
    this.email = email;
    this.phone = phone;
    this.cityId = cityId;
    this.profilePhoto = profilePhoto;
    this.userTypeID = userTypeID;
    this.address = address;
    this.longitude = longitude;
    this.latitude = latitude;
    this.isVerified = isVerified;
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
    map['profilePhotoPath'] = profilePhoto;
    map['userTypeID'] = userTypeID;
    map['address'] = address;
    map['longitude'] = longitude;
    map['latitude'] = latitude;
    map['isVerified'] = isVerified;
    return map;
  }

  Institution.fromObject(dynamic o) {
    this.id = o['id'];
    this.name = o['name'];
    this.username = o['username'];
    this.password = o['password'];
    this.email = o['email'];
    this.phone = o['phone'];
    this.cityId = o['cityID'];
    this.profilePhoto = o['profilePhotoPath'];
    this.userTypeID = o['userTypeID'];
    this.address = o['address'];
    this.longitude = o['longitude'];
    this.latitude = o['latitude'];
    this.isVerified = o['isVerified'];
  }
  
  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };
}
