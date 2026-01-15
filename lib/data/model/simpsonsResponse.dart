class Simpsonsmodel {
  final List<dynamic> results;
  final String name;
  final int age;
  final String gender;
  final List<String> phrases;

  Simpsonsmodel({required this.name, required this.results, required this.age, required this.gender, required this.phrases});

  factory Simpsonsmodel.fromJson(Map<String, dynamic> json){
    return Simpsonsmodel(results: json["results"], 
    name: json["name"], 
    age: json["age"], 
    gender: json["gender"], 
    phrases: json["phrases"]);
  }
}