class MenuItem {
  int id;
  String name;
  int price;

//Constuctor
  MenuItem({required this.id, required this.name, required this.price});

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'],
      name: json['name'],
      price: json['price'],
    );
  }
}
