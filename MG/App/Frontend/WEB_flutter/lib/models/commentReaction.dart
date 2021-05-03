class CommentReaction {
  int id;
  int commentID;
  int userID;
  int type;
  DateTime time;
  bool isRead;

  CommentReaction(commentID, userID, type, DateTime time, bool isRead) {
    this.commentID = commentID;
    this.userID = userID;
    this.type = type;
    this.time = time;
    this.isRead = isRead;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) 
      map['id'] = id;
    map['commentID'] = commentID;
    map['userID'] = userID;
    map['type'] = type;
    map['time'] = time.toIso8601String();
    map['isRead'] = isRead;
    return map;
  }

  CommentReaction.fromObject(dynamic o) {
    this.id = o['id'];
    this.commentID = o['commentID'];
    this.userID = o['userID'];
    this.type = o['type'];
    this.time = DateTime.tryParse(o['time']);
    this.isRead = o['isRead'];
  }
}
