class Category
{
  int id;
  String name;

  Category(name)
  {
    this.name = name;
  }

  Category.id(int id, String name)
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

  Category.fromObject(dynamic o) 
  {
    this.id = o['id'];
    this.name = o['name'];
  }
  
}