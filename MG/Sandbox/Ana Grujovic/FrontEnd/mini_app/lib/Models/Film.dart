class Film {
  int id;
  String naziv;
  int godina;

  Film(naziv, godina) {
    this.naziv = naziv;
    this.godina = godina;
  }

  Film.id(id, naziv, godina) {
    this.id = id;
    this.naziv = naziv;
    this.godina = godina;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['naziv'] = naziv;
    map['godina'] = godina;
    return map;
  }

  Film.fromObject(dynamic o) {
    this.id = o['id'];
    this.naziv = o['naziv'];
    this.godina = o['godina'];
  }
}