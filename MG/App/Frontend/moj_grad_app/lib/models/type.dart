class Type
{
  int id;
  String name;

  Type(name)
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

  Type.fromObject(dynamic o) 
  {
    this.id = o['id'];
    this.name = o['name'];
  }
  
}