import 'package:the_simpsons/data/model/dto_search_model.dart';
import 'package:the_simpsons/data/model/simpson_model.dart';

class Searchsimpsonservice {
  static List<Dtosearchmodel> searchMostSimilarMatches(List<Dtosearchmodel> matches,List<Simpsonmodel> characters, String name, int responses){
    name = normalize(name);
    String charaName;
    double similarity;
    for (int i = 0; i < characters.length; i++) {
      charaName = normalize(characters[i].name);
      if (name.length > charaName.length + 3) {
        continue;
      }

      if (charaName == name) {
        similarity = 1.0;
      } else if (charaName.contains(name)) {
        similarity = 0.8;
      } else {
        similarity = levenshtein(charaName, name);
      }

      if (similarity >= 0.6) {
        if (matches.length <= responses) {
          matches.add(
            Dtosearchmodel(similarity: similarity, simpsonmodel: characters[i]),
          );
        } else {
          for (int j = 0; j < responses; j++) {
            if (similarity > matches[j].similarity) {
              matches[i] = Dtosearchmodel(
                similarity: similarity,
                simpsonmodel: characters[i],
              );
            }
          }
        }
      }
    }
    matches.sort((a, b) => a!.similarity.compareTo(b!.similarity));
    return matches;
  }
}




  String normalize(String s) {
    return s.toLowerCase().replaceAll(RegExp(r'[^a-z\s]'), '').trim();
  }

  double levenshtein(String s, String t) {
    if (s == t) return 1.0;
    if (s.isEmpty) return t.length.toDouble();
    if (t.isEmpty) return s.length.toDouble();

    List<List<int>> matrix = List.generate(
      s.length + 1,
      (_) => List.filled(t.length + 1, 0),
    );

    for (int i = 0; i <= s.length; i++) {
      matrix[i][0] = i;
    }
    for (int j = 0; j <= t.length; j++) {
      matrix[0][j] = j;
    }

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