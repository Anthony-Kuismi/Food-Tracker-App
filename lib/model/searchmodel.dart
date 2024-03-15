import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchModel {

  Future<Map<String, dynamic>> fetchNutritionData(String _query) async {
    String query = _query;
    String apiKey = 'B/1b9kr1FV1w0HGz8Faffg==Duj02SZx1cDKhUk0';
    var response = await http.get(
      Uri.parse('https://api.calorieninjas.com/v1/nutrition?query=$query'),
      headers: {"X-Api-Key": apiKey},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load nutrition data');
    }
  }

  Future<List<String>> getSearchResults(String query) {
    return fetchNutritionData(query).then((Map<String, dynamic> searchResult) {
      List<dynamic> items = searchResult['items'];
      print(items.map((item) => item['name'] as String).toList());
      return items.map((item) => item['name'] as String).toList();
    }).catchError((error) {
      print(error);
      return <String>[];
    });
  }


    /*return data
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();*/
}