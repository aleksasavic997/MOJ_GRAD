class UserReport
{
  int id;
  int reportedUserID;
  int userID;

  UserReport(int reportedUserID, int userID)
  {
    this.reportedUserID = reportedUserID;
    this.userID = userID;
  }

  UserReport.id(int id, int reportedUserID, int userID)
  {
    this.id = id;
    this.reportedUserID = reportedUserID;
    this.userID = userID;
  }

  Map<String, dynamic> toMap() 
  {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['reportedUserID'] = reportedUserID;
    map['userID'] = userID;
    return map;
  }

  UserReport.fromObject(dynamic o) 
  {
    this.id = o['id'];
    this.reportedUserID = o['reportedUserID'];
    this.userID = o['userID'];
  }
  
}