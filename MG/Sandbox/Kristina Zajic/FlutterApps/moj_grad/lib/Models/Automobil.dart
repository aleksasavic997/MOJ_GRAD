class Automobil
{
  int id;
  String naziv;
  String model;

  Automobil(String naziv,String model)
  {
    this.naziv=naziv;
    this.model=model;
  }

  Automobil.id(int id,String naziv,String model)
  {
    this.id=id;
    this.naziv=naziv;
    this.model=model;
  }

  Map<String,dynamic> toMap()
  {
    var map=Map<String,dynamic>();
    map['naziv']=naziv;
    map['model']=model;
    map['id']=id;

    return map;
    }

  Automobil.fromObject(dynamic o)
  {
    this.id=o['id'];
    this.naziv=o['naziv'];
    this.model=o['model'];
  }
}