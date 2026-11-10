class NotepadResponseModel {
  final String id;
  final String title;
  final String content;
  final String userId;
  final List<String>? tags;
  final bool isPinned;

  NotepadResponseModel({
    required this.id,
    required this.title,
    required this.content,
    required this.userId,
    this.tags, 
    this.isPinned = false,
  });

  factory NotepadResponseModel.fromJson(Map<String, dynamic> json) {
    return NotepadResponseModel(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      title: json['title'],
      content: json['content'],
      userId: json['userId'],
      tags: json['tags'],
      isPinned: json['isPinned'],
    );
  }
}
