class Simpsonmodel {
  final String name;
  final int? age;
  final String? gender;
  final List<String> phrases;

  Simpsonmodel({required this.name, required this.age, required this.gender, required this.phrases});

  factory Simpsonmodel.fromJson(Map<String, dynamic> json){
    return Simpsonmodel(
      name: json['name'], 
      age: json['age'], 
      gender: json['gender'], 
      phrases: List<String>.from(json['phrases'] ?? [])
      );
  }
}