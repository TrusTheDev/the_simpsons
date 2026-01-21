import 'dart:convert';
import 'package:the_simpsons/data/model/dto_search_model.dart';
import 'package:the_simpsons/data/model/simpson_model.dart';
import 'package:the_simpsons/data/model/simpson_simple_response.dart';
import 'package:http/http.dart' as http;
import 'package:the_simpsons/data/model/simpsons_response.dart';
import 'package:the_simpsons/searchService/search_simpsonservice.dart';

class Repository {
  Future<SimpsonSimpleResponse> fetchSimpsonReponseInfo(String id) async {
    final response = await http.get(
      Uri.parse("https://thesimpsonsapi.com/api/characters/$id"),
    );

    if (response.statusCode == 200) {
      var decodedJson = jsonDecode(response.body);
      SimpsonSimpleResponse simpsonresponse = SimpsonSimpleResponse.fromJson(decodedJson);
      return simpsonresponse;
    } else {
      throw Exception("Ha ocurrido un error");
    }
  }

  Future<List<Dtosearchmodel>> fetchSimpsonResponses(String name, int responses) async {
    http.Response response;
    int i = 1;
    List<Dtosearchmodel> matches= [];
    do {
      response = await http.get(Uri.parse("https://thesimpsonsapi.com/api/characters?page=$i"));
      if(response.statusCode == 200){
        final Map<String, dynamic> data = jsonDecode(response.body);
        final Simpsonsresponse simpsonsResponse = Simpsonsresponse.fromJson(
          data,
        );
        final List<Simpsonmodel> characters = simpsonsResponse.results;
        
        matches = Searchsimpsonservice.searchMostSimilarMatches(matches, characters, name, responses);
      if(characters.isEmpty){
        return matches;
      }
      } else {
        throw Exception("Ha ocurrico un error");
      }
      i++;
    } while (true);
  }
}
