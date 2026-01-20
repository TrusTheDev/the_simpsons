class Simpsonmodel {
  final int id;
  final String name;
  final int? age;
  final String? gender;
  final String portaitPath;
  final List<String> phrases;

  Simpsonmodel({required this.name, required this.age, required this.gender, required this.phrases, required this.id, required this.portaitPath});

  factory Simpsonmodel.fromJson(Map<String, dynamic> json){
    return Simpsonmodel(
      id: json['id'],
      name: json['name'], 
      age: json['age'], 
      gender: json['gender'], 
      portaitPath: json['portaitPath'],
      phrases: List<String>.from(json['phrases'] ?? []),

      );
  }
}