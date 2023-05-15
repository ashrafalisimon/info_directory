class Fruit {
  int? id;
  String? name;
  String? description;
  String? image;

  Fruit({this.id, this.name, this.description, this.image});

  Fruit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
  }
}
