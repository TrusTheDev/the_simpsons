class Simpsonsmodel {
  final List<dynamic> results;


  Simpsonsmodel({required this.results});

  factory Simpsonsmodel.fromJson(Map<String, dynamic> json){
    return Simpsonsmodel(results: json["results"]);
    
  }
}