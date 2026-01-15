import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_simpsons/data/model/simpsonModel.dart';
import 'package:the_simpsons/data/model/simpsonResponse.dart';
import 'package:http/http.dart' as http;
import 'package:the_simpsons/data/model/simpsonsResponse.dart';

class Repository {
  Future<Simpsonresponse> fetchSimpsonReponseInfo(String id) async {
    final response = await http.get(
      Uri.parse("https://thesimpsonsapi.com/api/characters/$id"),
    );

    if (response.statusCode == 200) {
      var decodedJson = jsonDecode(response.body);
      Simpsonresponse simpsonresponse = Simpsonresponse.fromJson(decodedJson);
      return simpsonresponse;
    } else {
      throw Exception("Ha ocurrido un error");
    }
  }

  Future<Simpsonsresponse> fetchSimpsonReponseInfoByNameTest(
    String name,
  ) async {
    final response = await http.get(
      Uri.parse("https://thesimpsonsapi.com/api/characters"),
    );

    if (response.statusCode == 200) {
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

  Future<Simpsonmodel> fetchSimpsonReponseInfoByName(String name) async {
    http.Response response;
    name = name.toLowerCase().trim();
    String charaName;
    int i = 1;

    do {
      response = await http.get(
        Uri.parse("https://thesimpsonsapi.com/api/characters?page=$i"),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final Simpsonsresponse simpsonsResponse = Simpsonsresponse.fromJson(data);
        final List<Simpsonmodel> characters = simpsonsResponse.results;
        for (int i = 0; i < characters.length; i++) {
            charaName = characters[i].name.toLowerCase().trim();
          if (levenshtein(charaName, name) > 0.5) {
            return characters[i];
          }
        }
      } else {
        throw Exception("Ha ocurrico un error");
      }

      i++;
    } while (true);
  }

  double levenshtein(String s, String t) {
    if (s == t) return 0;
    if (s.isEmpty) return t.length.toDouble();
    if (t.isEmpty) return s.length.toDouble();

    List<List<int>> matrix = List.generate(
      s.length + 1,
      (_) => List.filled(t.length + 1, 0),
    );

    for (int i = 0; i <= s.length; i++) matrix[i][0] = i;
    for (int j = 0; j <= t.length; j++) matrix[0][j] = j;

    for (int i = 1; i <= s.length; i++) {
      for (int j = 1; j <= t.length; j++) {
        int cost = s[i - 1] == t[j - 1] ? 0 : 1;
        matrix[i][j] = [
          matrix[i - 1][j] + 1,
          matrix[i][j - 1] + 1,
          matrix[i - 1][j - 1] + cost,
        ].reduce((a, b) => a < b ? a : b);
      }
    }

    int maxLength = s.length > t.length ? s.length : t.length;

    return 1 - (matrix[s.length][t.length] / maxLength);
  }
}
