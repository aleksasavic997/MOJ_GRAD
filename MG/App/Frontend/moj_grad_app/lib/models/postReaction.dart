class PostReaction
{
  int id;
  int postID;
  int userID;
  DateTime time;
  bool isRead;

  PostReaction(int postID, int userID, DateTime time, bool isRead)
  {
    this.postID = postID;
    this.userID = userID;
    this.time = time;
    this.isRead = isRead;
  }

  PostReaction.id(int id, int postID, int userID, DateTime time, bool isRead)
  {
    this.id = id;
    this.postID = postID;
    this.userID = userID;
    this.time = time;
    this.isRead = isRead;
  }

  Map<String, dynamic> toMap() 
  {
    var map = Map<String, dynamic>();
    if(id != null)
      map['id'] = id;
    map['postID'] = postID;
    map['userID'] = userID;
    map['time'] = time.toIso8601String();
    map['isRead'] = isRead;
    return map;
  }

  PostReaction.fromObject(dynamic o) 
  {
    this.id = o['id'];
    this.postID = o['postID'];
    this.userID = o['userID'];
    this.time = DateTime.tryParse(o['time']);
    this.isRead = o['isRead'];
  }
  
}