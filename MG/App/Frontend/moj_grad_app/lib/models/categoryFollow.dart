class CategoryFollow
{
  int id;
  int userID;
  int categoryID;

  CategoryFollow(userID, categoryID)
  {
    this.userID = userID;
    this.categoryID = categoryID;
  }

  Map<String, dynamic> toMap() 
  {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['userID'] = userID;
    map['categoryID'] = categoryID;
    return map;
  }

  CategoryFollow.fromObject(dynamic o) 
  {
    this.id = o['id'];
    this.userID = o['userID'];
    this.categoryID = o['categoryID'];
  }
  
}