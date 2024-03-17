import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:food_tracker_app/model/search_model.dart';
import 'package:food_tracker_app/service/food_selection.dart';
import 'package:food_tracker_app/service/navigator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/food.dart';

class SearchViewModel extends ChangeNotifier {
  final SearchModel _searchModel = SearchModel();
  final NavigatorService navigatorService;
  final FoodSelectionService foodSelectionService;
  bool _disposed = false;
  Timer? searchTimer;

  SearchViewModel(this.navigatorService, this.foodSelectionService);

  List<String> get searchResults =>  _searchModel.searchResults;
  List<String> get selectedFoods => foodSelectionService.selections.toList();

  void updateQuery(String newQuery){
    _searchModel.query = newQuery;
    if (searchTimer?.isActive ?? false) {
      searchTimer?.cancel();
    }
    searchTimer = Timer(const Duration(milliseconds: 500), () {
      updateSearchResults();
    });
  }

  void reset(){
    _searchModel.searchResults=[];
    _searchModel.query='';
  }

  String cleanQuerySegment(String querySegment) {
    List<String> wordsToRemove = ['and', 'also', 'plus', 'another'];
    String pattern = '\\b(${wordsToRemove.join('|')})\\b';
    pattern += '|,';
    String cleanedSegment = querySegment.replaceAll(RegExp(pattern, caseSensitive: false), '');
    cleanedSegment = cleanedSegment.replaceAll(RegExp('\\s+'), ' ').trim();
    return cleanedSegment;
  }
  List<String> segmentQuery(String query, dynamic data) {
    List<dynamic> items = data?['items'] ?? [];
    List foodItems = items
        .where((item) => query.toLowerCase().contains(item['name'].toLowerCase()))
        .map((item) => item['name'].toLowerCase())
        .toList();
    List<String> out = [];

    if (foodItems.isEmpty) {
      return [query];
    }

    int? segmentPointer = 0;
    for (var foodItem in foodItems) {
      int itemIndex = query.toLowerCase().indexOf(foodItem, segmentPointer!);
      if (itemIndex >= 0) {
        String segment = '${query.substring(segmentPointer, itemIndex).trim()} ${query.substring(itemIndex, (itemIndex + foodItem.length) as int?)}';
        out.add(cleanQuerySegment(segment));
        segmentPointer = (itemIndex + foodItem.length) as int?;
      }
    }
    return out;
  }

  void entitleData(String query, dynamic data) {
    List<String> querySegments = segmentQuery(query, data);
    int minLen = min(data?['items'].length ?? 0, querySegments.length);
    for (var i = 0; i < minLen; i++) {
      data['items'][i]['title'] = querySegments[i];
    }
    if ((data?['items'].length ?? 0) == 1 && querySegments.isNotEmpty) {
      data['items'][0]['title'] = querySegments.first;
    }
  }

  Future<dynamic> fetchData() async{
    String apiKey = 'B/1b9kr1FV1w0HGz8Faffg==Duj02SZx1cDKhUk0';
    if(_searchModel.query.isNotEmpty) {
      print('\n----\nAPI CALL\n----\n');
      var response = await http.get(
        Uri.parse(
            'https://api.calorieninjas.com/v1/nutrition?query=${_searchModel.query}'),
        headers: {'X-Api-Key': apiKey},
      );
      if (response.statusCode == 200) {
        dynamic out = jsonDecode(response.body);
        return out;
      } else {
        throw Exception('Failed to load nutrition data');
      }
    }
  }

  Future<void> updateSearchResults() async{
    if(_searchModel.query.isNotEmpty){
      return fetchData().then((dynamic data){
        entitleData(_searchModel.query, data);
        _searchModel.data = data;
        List<dynamic> items = data?['items'];
        _searchModel.searchResults = items
            .where((item) => _searchModel.query.toLowerCase().contains(item['name'].toLowerCase()))
            .map((item) => item['title'] as String)
            .toList();
        if(!_disposed){
          notifyListeners();
        }
      });
    }
  }

  void toggleSelection(bool? isSelected, food){
    if (isSelected ?? false) {
      foodSelectionService.addSelectedFood(food);
    } else {
      foodSelectionService.removeSelectedFood(food);
    }
    if(!_disposed){
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
