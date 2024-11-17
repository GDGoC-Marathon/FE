class Menu {
  final int? id;
  final String date;
  final int price;
  final int count;
  final String area;
  final String category;

  Menu({
    this.id,
    required this.date,
    required this.price,
    required this.count,
    required this.area,
    required this.category,
  });

  // JSON 변환
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'price': price,
      'count': count,
      'area': area,
      'category': category,
    };
  }

  // JSON을 객체로 변환
  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'],
      date: json['date'],
      price: json['price'],
      count: json['count'],
      area: json['area'],
      category: json['category'],
    );
  }
}
