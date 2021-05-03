class SavedPost
{
  int id;
  int userID;
  int postID;
  DateTime time;

  SavedPost(int postID, int userID, time)
  {
    this.postID = postID;
    this.userID = userID;
	this.time = time;
  }

  SavedPost.id(int id, int postID, int userID)
  {
    this.id = id;
    this.userID = userID;
    this.postID = postID;
	this.time = time;
  }

  Map<String, dynamic> toMap() 
  {
    var map = Map<String, dynamic>();
    if(id != null)
      map['id'] = id;
    map['userID'] = userID;
    map['postID'] = postID;
	map['time'] = time.toIso8601String();
    return map;
  }

  SavedPost.fromObject(dynamic o) 
  {
    this.id = o['id'];
	this.userID = o['userID'];
    this.postID = o['postID'];
	this.time = DateTime.tryParse(o['time']);
  }
  
}