class Dogadjaj{
  int id;
  int kategorija;
  String naslov;
  String danOdrzavanja;
  String mestoOdrzavanja;
  String vremeOdrzavanja;

  Dogadjaj({this.naslov, this.kategorija ,this.danOdrzavanja, this.mestoOdrzavanja, this.vremeOdrzavanja});

  Map<String, dynamic>napraviMap(){
    Map map=Map<String, dynamic>();
    map['id']=id;
    map['kategorija']=kategorija;
    map['naslov']=naslov;
    map['danOdrzavanja']=danOdrzavanja;
    map['mestoOdrzavanja']=mestoOdrzavanja;
    map['vremeOdrzavanja']=vremeOdrzavanja;
    return map;
  }

  Dogadjaj.fromObject(dynamic obj){
    this.id=obj['id'];
    this.kategorija=obj['kategorija'];
    this.naslov=obj['naslov'];
    this.danOdrzavanja=obj['danOdrzavanja'];
    this.mestoOdrzavanja=obj['mestoOdrzavanja'];
    this.vremeOdrzavanja=obj['vremeOdrzavanja'];
  }
}