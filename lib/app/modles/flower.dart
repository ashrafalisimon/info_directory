class Flower {
  int? id;
  String? name;
  String? description;
  String? image;

  Flower({this.id, this.name, this.description, this.image});

  Flower.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
  }
}
