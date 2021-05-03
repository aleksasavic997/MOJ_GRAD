class Follow
{
  int id;
  int userFollowID;
  int followedUserID;

  Follow(userFollowID, followedUserID)
  {
    this.userFollowID = userFollowID;
    this.followedUserID = followedUserID;
  }

  Map<String, dynamic> toMap() 
  {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['userFollowID'] = userFollowID;
    map['followedUserID'] = followedUserID;
    return map;
  }

  Follow.fromObject(dynamic o) 
  {
    this.id = o['id'];
    this.userFollowID = o['userFollowID'];
    this.followedUserID = o['followedUserID'];
  }
  
}