class Follow
{
  int id;
  int userFollowID;
  int followedUserID;
  DateTime time;
  bool isRead;

  Follow(userFollowID, followedUserID, DateTime time, bool isRead)
  {
    this.userFollowID = userFollowID;
    this.followedUserID = followedUserID;
    this.time = time;
    this.isRead = isRead;
  }

  Map<String, dynamic> toMap() 
  {
    var map = Map<String, dynamic>();
    if(id != null)
      map['id'] = id;
    map['userFollowID'] = userFollowID;
    map['followedUserID'] = followedUserID;
    map['time'] = time.toIso8601String();
    map['isRead'] = isRead;
    return map;
  }

  Follow.fromObject(dynamic o) 
  {
    this.id = o['id'];
    this.userFollowID = o['userFollowID'];
    this.followedUserID = o['followedUserID'];
    this.time = DateTime.tryParse(o['time']);
    this.isRead = o['isRead'];
  }
  
}