class Simpsonresponse {
  final int id;
  final String name;
  Simpsonresponse({required this.name, required this.id});

  factory Simpsonresponse.fromJson(Map<String, dynamic> json){
    return Simpsonresponse(name: json['name'], id: json['id']);
    
  }
}