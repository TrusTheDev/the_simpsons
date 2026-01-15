import 'dart:convert';

import 'package:the_simpsons/data/model/simpsonResponse.dart';
import 'package:http/http.dart' as http;

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

    Future<Simpsonresponse> fetchSimpsonReponseInfoByName(String name) async {
    final response = await http.get(Uri.parse("https://thesimpsonsapi.com/api/characters"));

    if(response.statusCode == 200){
      var decodedJson = jsonDecode(response.body);
      Simpsonresponse simpsonresponse = Simpsonresponse.fromJson(decodedJson);
      return simpsonresponse;
    } else {
      throw Exception("Ha ocurrido un error");
    }
  }
}