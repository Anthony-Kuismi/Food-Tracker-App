import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:food_tracker_app/model/search_model.dart';
import 'package:food_tracker_app/service/food_selection.dart';
import 'package:food_tracker_app/service/navigator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchViewModel extends ChangeNotifier {
  final SearchModel _searchModel = SearchModel();
  final NavigatorService navigatorService;
  final FoodSelectionService foodSelectionService;
  bool _disposed = false;


  SearchViewModel(this.navigatorService, this.foodSelectionService);

  List<String> get searchResults =>  _searchModel.searchResults;
  List<String> get selectedFoods => foodSelectionService.selections.toList();
  Timer? searchTimer;


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


  Future<dynamic> fetchData() async{
    String apiKey = 'B/1b9kr1FV1w0HGz8Faffg==Duj02SZx1cDKhUk0';
    if(_searchModel.query.isNotEmpty) {
      var response = await http.get(
        Uri.parse(
            'https://api.calorieninjas.com/v1/nutrition?query=${_searchModel.query}'),
        headers: {'X-Api-Key': apiKey},
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load nutrition data');
      }
    }
  }

  Future<void> updateSearchResults() async{
    if(_searchModel.query.isNotEmpty){
      return fetchData().then((dynamic data){
        _searchModel.data = data;
        List<dynamic> items = data?['items'];
        _searchModel.searchResults = items
            .where((item) => _searchModel.query.toLowerCase().contains(item['name'].toLowerCase()))
            .map((item) => item['name'] as String)
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
