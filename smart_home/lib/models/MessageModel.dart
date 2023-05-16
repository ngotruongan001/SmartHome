class MessageModel {
  MessageModel({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.status,
  });
  String id;
  String title;
  String body;
  String createdAt;
  String status;
  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
      id: json["_id"],
      title: json["title"],
      body: json["body"],
      createdAt: json["createdAt"],
      status: json["status"]
  );
}