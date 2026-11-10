class DetailsModel {
  final String id;
  final String title;
  final String content;
  final String userId;
  final List<String>? tags;
  final bool isPinned;

  DetailsModel({
    required this.id,
    required this.title,
    required this.content,
    required this.userId,
    this.tags,
    this.isPinned = false,
  });

  factory DetailsModel.fromJson(Map<String, dynamic> json) {
    return DetailsModel(
      id:json['_id'],
      title: json['title'],
      content: json['content'],
      userId: json['userId'],
      tags: json['tags'],
      isPinned: json['isPinned'],
    );
  }
}
