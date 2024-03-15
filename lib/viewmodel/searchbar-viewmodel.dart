import 'package:flutter/cupertino.dart';
import 'package:food_tracker_app/model/searchmodel.dart';

class SearchViewModel extends ChangeNotifier {
  final SearchModel _searchModel = SearchModel();

  Future<List<String>> getSearchResults(String query) {
    return _searchModel.getSearchResults(query);
  }

  Map<String, bool> getChecklistMap(List<String> results){
    return _searchModel.getChecklistMap(results);
  }

  void updateSelectedFoods(Map<String, bool> checklist){
    _searchModel.updateSelectedFoods(checklist);
  }

  void sendSelectedFoods(){
    _searchModel.sendSelectedFoods();
  }
}