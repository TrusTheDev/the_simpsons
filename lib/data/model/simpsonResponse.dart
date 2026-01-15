class Simpsonresponse {
  final String name;
  Simpsonresponse({required this.name});

  factory Simpsonresponse.fromJson(Map<String, dynamic> json){
    return Simpsonresponse(name: json["name"]);
    
  }
}