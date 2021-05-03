class UserType
{
  int id;
  String name;

  UserType(name)
  {
    this.name = name;
  }

  Map<String, dynamic> toMap() 
  {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    return map;
  }

  UserType.fromObject(dynamic o) 
  {
    this.id = o['id'];
    this.name = o['name'];
  }
  
}