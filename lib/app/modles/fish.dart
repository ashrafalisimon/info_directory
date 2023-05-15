class Fish {
  int? id;
  String? name;
  String? description;
  String? image;

  Fish({this.id, this.name, this.description, this.image});

  Fish.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
  }
}
