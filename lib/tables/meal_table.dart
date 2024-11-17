class Meal {
  final int? id;
  final String name;
  final int menuId;

  Meal({
    this.id,
    required this.name,
    required this.menuId,
  });

  // JSON 변환
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'menu_id': menuId,
    };
  }

  // JSON을 객체로 변환
  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'],
      name: json['name'],
      menuId: json['menu_id'],
    );
  }
}
