class Simpsonmodel {
  final int id;
  final String name;
  final String portaitPath;

  Simpsonmodel({required this.name, required this.id, required this.portaitPath});

  factory Simpsonmodel.fromJson(Map<String, dynamic> json){
    return Simpsonmodel(
      id: json['id'],
      name: json['name'], 
      portaitPath: json['portrait_path'],

      );
  }
}