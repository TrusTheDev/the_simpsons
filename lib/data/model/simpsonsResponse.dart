import 'package:the_simpsons/data/model/simpsonModel.dart';

class Simpsonsresponse {
  final List<Simpsonmodel> results;
  Simpsonsresponse({required this.results});

  factory Simpsonsresponse.fromJson(Map<String, dynamic> json){
    return Simpsonsresponse(results: (json["results"] as List).map((e) => Simpsonmodel.fromJson(e)).toList());
  
  }
}