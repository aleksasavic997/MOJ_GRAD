class CategoryStatistic
{
  int id;
  String name;
  int challengeNumber;
  int solutionNumber;
  int postNumber;
  int reactionNumber;

  CategoryStatistic(name, challengeNumber, solutionNumber, postNumber, reactionNumber)
  {
    this.name = name;
	this.challengeNumber = challengeNumber;
	this.solutionNumber = solutionNumber;
	this.postNumber = postNumber;
	this.reactionNumber = reactionNumber;
  }

  CategoryStatistic.id(id, name, challengeNumber, solutionNumber, postNumber, reactionNumber)
  {
    this.id = id;
    this.name = name;
	this.challengeNumber = challengeNumber;
	this.solutionNumber = solutionNumber;
	this.postNumber = postNumber;
	this.reactionNumber = reactionNumber;
  }

  Map<String, dynamic> toMap() 
  {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
	map['challengeNumber'] = challengeNumber;
	map['solutionNumber'] = solutionNumber;
	map['postNumber'] = postNumber;
	map['reactionNumber'] = reactionNumber;
    return map;
  }

  CategoryStatistic.fromObject(dynamic o) 
  {
    this.id = o['id'];
    this.name = o['name'];
	this.challengeNumber = o['challengeNumber'];
	this.solutionNumber = o['solutionNumber'];
	this.postNumber = o['postNumber'];
	this.reactionNumber = o['reactionNumber'];
  }
  
}