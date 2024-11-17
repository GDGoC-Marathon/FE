class Comment {
  final int? id;
  final String writer;
  final String content;
  final int menuId;

  Comment({
    this.id,
    required this.writer,
    required this.content,
    required this.menuId,
  });

  // JSON 변환
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'writer': writer,
      'content': content,
      'menu_id': menuId,
    };
  }

  // JSON을 객체로 변환
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      writer: json['writer'],
      content: json['content'],
      menuId: json['menu_id'],
    );
  }
}
