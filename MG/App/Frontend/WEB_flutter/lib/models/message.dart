class Message
{
  int id;
  int senderID;
  int receiverID;
  String content;
  DateTime time;
  bool isRead;

  Message(senderID, receiverID, content, time, isRead)
  {
    this.senderID = senderID;
    this.receiverID = receiverID;
	this.content = content;
	this.time = time;
	this.isRead = isRead;
  }

  Message.id(id, senderID, receiverID, content, time, isRead)
  {
    this.id = id;
    this.senderID = senderID;
    this.receiverID = receiverID;
	this.content = content;
	this.time = time;
	this.isRead = isRead;
  }

  Map<String, dynamic> toMap() 
  {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['senderID'] = senderID;
    map['receiverID'] = receiverID;
	map['content'] = content;
	map['time'] = time.toIso8601String();
	map['isRead'] = isRead;
    return map;
  }

  Message.fromObject(dynamic o) 
  {
    this.id = o['id'];
    this.senderID = o['senderID'];
    this.receiverID = o['receiverID'];
	this.content = o['content'];
	this.time = DateTime.tryParse(o['time']);
	this.isRead = o['isRead'];
  }
  
}