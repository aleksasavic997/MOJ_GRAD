class Sponsor
{
  int id;
  String name;
  String description;
  String imagePath;
  String facebookLink;
  String twitterLink;
  String youTubeLink;
  String instagramLink;
  String websiteLink;

  Sponsor(name, description, imagePath, facebookLink, twitterLink, youTubeLink, instagramLink, websiteLink)
  {
    this.name = name;
    this.description = description;
    this.imagePath = imagePath;
    this.facebookLink = facebookLink;
	this.twitterLink = twitterLink;
	this.youTubeLink = youTubeLink;
	this.instagramLink = instagramLink;
	this.websiteLink = websiteLink;
  }

  Sponsor.id(id, name, description, imagePath, facebookLink, twitterLink, youTubeLink, instagramLink, websiteLink)
  {
    this.id = id;
    this.name = name;
    this.description = description;
    this.imagePath = imagePath;
    this.facebookLink = facebookLink;
	this.twitterLink = twitterLink;
	this.youTubeLink = youTubeLink;
	this.instagramLink = instagramLink;
	this.websiteLink = websiteLink;
  }

  Map<String, dynamic> toMap() 
  {
    var map = Map<String, dynamic>();
   if(id!=null) map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['imagePath'] = imagePath;
    map['facebookLink'] = facebookLink;
	map['twitterLink'] = twitterLink;
	map['youTubeLink'] = youTubeLink;
	map['instagramLink'] = instagramLink;
	map['websiteLink'] = websiteLink;
    return map;
  }

  Sponsor.fromObject(dynamic o) 
  {
    this.id = o['id'];
    this.name = o['name'];
    this.description = o['description'];
    this.imagePath = o['imagePath'];
    this.facebookLink = o['facebookLink'];
	this.twitterLink = o['twitterLink'];
	this.youTubeLink = o['youTubeLink'];
	this.instagramLink = o['instagramLink'];
	this.websiteLink = o['websiteLink'];
  }
  
}