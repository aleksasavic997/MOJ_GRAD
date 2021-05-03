class Comment {
  int id;
  int postID;
  int userID;
  String content;
  DateTime time;
  bool isRead;

  Comment(int postID, int userID, String content, DateTime time, bool isRead) {
    this.postID = postID;
    this.userID = userID;
    this.content = content;
    this.time = time;
    this.isRead = isRead;
  }

  Comment.id(int id, int postID, int userID, String content, DateTime time,
      bool isRead) {
    this.id = id;
    this.postID = postID;
    this.userID = userID;
    this.content = content;
    this.time = time;
    this.isRead = isRead;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) map['id'] = id;
    map['postID'] = postID;
    map['userID'] = userID;
    map['content'] = content;
    map['time'] = time.toIso8601String();
    map['isRead'] = isRead;
    return map;
  }

  Comment.fromObject(dynamic o) {
    this.id = o['id'];
    this.postID = o['postID'];
    this.userID = o['userID'];
    this.content = o['content'];
    this.time = DateTime.tryParse(o['time']);
    this.isRead = o['isRead'];
  }
}
