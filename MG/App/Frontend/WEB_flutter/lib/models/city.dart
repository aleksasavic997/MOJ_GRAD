class City
{
  int id;
  String name;

  City(name)
  {
    this.name = name;
  }

  City.id(id, name)
  {
    this.id = id;
    this.name = name;
  }

  Map<String, dynamic> toMap() 
  {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    return map;
  }

  City.fromObject(dynamic o) 
  {
    this.id = o['id'];
    this.name = o['name'];
  }
  
}