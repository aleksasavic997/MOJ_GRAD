class CommentInfo {
  int id;
  int postId;
  int userId;

  String content;
  String username;
  int commentLikes;
  int commentDislikes;
  int isLiked;
  String profilePhoto;

  bool get isLike {
    if (isLiked == 1)
      return true;
    else
      return false;
  }

  bool get isDislike {
    if (isLiked == -1)
      return true;
    else
      return false;
  }

  CommentInfo(id, postId, userId, content, username, commentLikes,
      commentDislikes, isLiked, profilePhoto) {
    this.id = id;
    this.postId = postId;
    this.userId = userId;
    this.content = content;
    this.username = username;
    this.commentLikes = commentLikes;
    this.commentDislikes = commentDislikes;
    this.isLiked = isLiked;
    this.profilePhoto = profilePhoto;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) map['id'] = id;
    map['postId'] = postId;
    map['userId'] = userId;
    map['content'] = content;
    map['username'] = username;
    map['commentLikes'] = commentLikes;
    map['commentDislikes'] = commentDislikes;
    map['isLiked'] = isLiked;
    map['profilePhoto'] = profilePhoto;
    return map;
  }

  CommentInfo.fromObject(dynamic o) {
    this.id = o['id'];
    this.postId = o['postId'];
    this.userId = o['userID'];
    this.content = o['content'];
    this.username = o['username'];
    this.commentLikes = o['commentLikes'];
    this.commentDislikes = o['commentDislikes'];
    this.isLiked = o['isLiked'];
    this.profilePhoto = o['profilePhoto'];
  }
}
