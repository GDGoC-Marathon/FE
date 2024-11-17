class Today {
  final int? id;
  final int count;
  final String imgUrl;
  final int menuId;

  Today({
    this.id,
    required this.count,
    required this.imgUrl,
    required this.menuId,
  });

  // JSON 변환
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'count': count,
      'img_url': imgUrl,
      'menu_id': menuId,
    };
  }

  // JSON을 객체로 변환
  factory Today.fromJson(Map<String, dynamic> json) {
    return Today(
      id: json['id'],
      count: json['count'],
      imgUrl: json['img_url'],
      menuId: json['menu_id'],
    );
  }
}
