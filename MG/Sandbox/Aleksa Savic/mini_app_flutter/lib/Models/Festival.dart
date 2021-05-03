class Festival{
  int idFest;
  String nazivFestivala;

  Festival(nazivFestivala)
  {
    this.nazivFestivala=nazivFestivala;
  }

  Festival.idFest(idFest,nazivFestivala)
  {
    this.idFest=idFest;
    this.nazivFestivala=nazivFestivala;
  }

  Map<String, dynamic> toMap(){
    var map=Map<String,dynamic>();
    map['idFest']=idFest;
    map['nazivFestivala']=nazivFestivala;
    return map;
  }

  Festival.fromObject(dynamic o){
    this.idFest=o['idFest'];
    this.nazivFestivala=o['nazivFestivala'];
  }
}

