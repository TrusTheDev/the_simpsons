import 'dart:convert';

import 'package:the_simpsons/data/model/simpsonModel.dart';
import 'package:the_simpsons/data/model/simpsonResponse.dart';
import 'package:http/http.dart' as http;
import 'package:the_simpsons/data/model/simpsonsResponse.dart';

class Repository{
  Future<Simpsonresponse> fetchSimpsonReponseInfo(String id) async {
    final response = await http.get(Uri.parse("https://thesimpsonsapi.com/api/characters/$id"));

    if(response.statusCode == 200){
      var decodedJson = jsonDecode(response.body);
      Simpsonresponse simpsonresponse = Simpsonresponse.fromJson(decodedJson);
      return simpsonresponse;
    } else {
      throw Exception("Ha ocurrido un error");
    }
  }

    Future<Simpsonsresponse> fetchSimpsonReponseInfoByNameTest(String name) async {
    final response = await http.get(Uri.parse("https://thesimpsonsapi.com/api/characters"));

    if(response.statusCode == 200){
      final Map<String, dynamic> data = jsonDecode(response.body);
      print("antes de mapear");
      final Simpsonsresponse simpsonsResponse = Simpsonsresponse.fromJson(data);
      print("mapeado");

      final List<Simpsonmodel> characters = simpsonsResponse.results;
      
      return simpsonsResponse;
    } else {
      throw Exception("Ha ocurrido un error");
    }
  }
}