class Message{
  final String user;
  final String message;
  final String userId;
  final bool isMe;
  Message({required this.isMe,required this.userId,required this.user, required this.message,});

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'message': message,
      'userId': userId,
    };
  }

}