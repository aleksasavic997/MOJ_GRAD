/*
class NotificationInfo {
  int id;
  String content;
  int userId;
  int postId;
  DateTime time;
  int isRead;

  String postTitle;
  String timePassed;

  
  NotificationInfo(content, userId, postId, time, isRead, postTitle, timePassed)
  {
    this.content = content;
    this.userId = userId;
    this.postId = postId;
    this.time = time;
    this.isRead = isRead;
    this.postTitle = postTitle;
    this.timePassed = timePassed;
  }

  Map<String, dynamic> toMap() 
  {
    var map = Map<String, dynamic>();
    if(id != null)
      map['id'] = id;
    map['content'] = content;
    map['userId'] = userId;
    map['postId'] = postId;
    map['time'] = time.toIso8601String();
    map['isRead'] = isRead;
    map['postTitle'] = postTitle;
    map['timePassed'] = timePassed;
    return map;
  }

  NotificationInfo.fromObject(dynamic o) 
  {
    this.id = o['id'];
    this.content = o['content'];
    this.userId = o['userID'];
    this.postId = o['postId'];
    this.time = o['time'];
    this.isRead = o['isRead'];
    this.postTitle = o['postTitle'];
    this.timePassed = o['timePassed'];
  }

}*/

class NotificationInfo {
  int id;
  String content;
  int userId;
 int get getUserId => userId;

 set setUserId(int userId) => this.userId = userId;
  int postId;
  DateTime time;
  int type;
  String timePassed;

  
  NotificationInfo(type, content, time, userId, postId, timePassed)
  {
    this.content = content;
    this.userId = userId;
    this.postId = postId;
    this.time = time;
    this.timePassed = timePassed;
    this.type = type;
  }

  NotificationInfo.id(id, type, content, time, userId, postId, timePassed)
  {
    this.id = id;
    this.content = content;
    this.userId = userId;
    this.postId = postId;
    this.time = time;
    this.timePassed = timePassed;
    this.type = type;
  }

  Map<String, dynamic> toMap() 
  {
    var map = Map<String, dynamic>();
    if(id != null)
      map['id'] = id;
    map['content'] = content;
    map['userID'] = userId;
    map['postID'] = postId;
    map['time'] = time.toIso8601String();
    map['timePassed'] = timePassed;
    map['type'] = type;
    return map;
  }

  NotificationInfo.fromObject(dynamic o) 
  {
    this.id = o['id'];
    this.content = o['content'];
    this.userId = o['userID'];
    this.postId = o['postID'];
    this.time = DateTime.tryParse(o['time']);
    this.timePassed = o['timePassed'];
    this.type = o['type'];
  }

}