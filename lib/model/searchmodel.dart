import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:food_tracker_app/model/meal.dart';
import 'package:food_tracker_app/viewmodel/meal_viewmodel.dart';

class SearchModel {
  List<String> selectedFoods = [];

  void sendSelectedFoods(){

    // for(var food in selectedFoods){
    //   print(food);
    // }
  }

  Map<String, bool> getChecklistMap(List<String> results){
    Map<String, bool> checklist = {
      for (var result in results) result : selectedFoods.contains(result) 
    };
    return checklist;
  }

  void updateSelectedFoods(Map<String, bool> checklist){
    for(MapEntry<String,bool> entry in checklist.entries){
      if(entry.value==true&&!selectedFoods.contains(entry.key)){
       selectedFoods.add(entry.key);
      }else if(entry.value==false && selectedFoods.contains(entry.key)){
        selectedFoods.remove(entry.key);
      }
    }
  }

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
}