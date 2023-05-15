class Bird {
  int? id;
  String? name;
  String? description;
  String? image;

  Bird({this.id, this.name, this.description, this.image});

  Bird.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
  }
}
