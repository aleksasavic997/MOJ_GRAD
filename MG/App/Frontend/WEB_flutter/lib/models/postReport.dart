class PostReport
{
  int id;
  int postID;
  int userID;

  PostReport(int postID, int userID)
  {
    this.postID = postID;
    this.userID = userID;
  }

  PostReport.id(int id, int postID, int userID)
  {
    this.id = id;
    this.postID = postID;
    this.userID = userID;
  }

  Map<String, dynamic> toMap() 
  {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['postID'] = postID;
    map['userID'] = userID;
    return map;
  }

  PostReport.fromObject(dynamic o) 
  {
    this.id = o['id'];
    this.postID = o['postID'];
    this.userID = o['userID'];
  }
  
}