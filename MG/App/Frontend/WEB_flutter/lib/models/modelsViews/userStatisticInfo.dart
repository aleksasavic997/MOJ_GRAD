class UserStatisticInfo
{
  int numberOfCitizens;
  int numberOfInstitutions;
  int cityID;
  String cityName;
  DateTime time;
  int day;
  int month;
  int year;
  int totalNumber;

  UserStatisticInfo(numberOfCitizens, numberOfInstitutions, cityID, cityName, time, day, month, year, totalNumber)
  {
    this.numberOfCitizens = numberOfCitizens;
	this.numberOfInstitutions = numberOfInstitutions;
	this.cityID = cityID;
	this.cityName = cityName;
	this.time = time;
	this.day = day;
	this.month = month;
	this.year = year;
	this.totalNumber = totalNumber;
  }

  Map<String, dynamic> toMap() 
  {
    var map = Map<String, dynamic>();
    map['numberOfCitizens'] = numberOfCitizens;
    map['numberOfInstitutions'] = numberOfInstitutions;
	map['cityID'] = cityID;
	map['cityName'] = cityName;
	map['time'] = time.toIso8601String();
	map['day'] = day;
	map['month'] = month;
	map['year'] = year;
	map['totalNumber'] = totalNumber;
    return map;
  }

  UserStatisticInfo.fromObject(dynamic o) 
  {
    this.numberOfCitizens = o['numberOfCitizens'];
    this.numberOfInstitutions = o['numberOfInstitutions'];
	this.cityID = o['cityID'];
	this.cityName = o['cityName'];
	this.time = DateTime.tryParse(o['time']);
	this.day = o['day'];
	this.month = o['month'];
	this.year = o['year'];
	this.totalNumber = o['totalNumber'];
  }
  
}