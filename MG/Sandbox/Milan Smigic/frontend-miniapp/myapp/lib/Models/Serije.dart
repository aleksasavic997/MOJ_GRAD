class Serije
{
  int id;
  String naziv;

  Serije(naziv)
  {
    this.naziv = naziv;
  }

  Serije.id(id, naziv)
  {
    this.id = id;
    this.naziv = naziv;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['naziv'] = naziv;
    return map;
  }

  Serije.fromObject(dynamic o) {
    this.id = o['id'];
    this.naziv = o['naziv'];
  }

}