import 'package:flutter/cupertino.dart';
import 'package:food_tracker_app/model/search_model.dart';

class SearchViewModel extends ChangeNotifier {
  final SearchModel _searchModel = SearchModel();
  String query = '';
  List<String> searchResults = [];
  void updateQuery(String newQuery){
    query = newQuery;
    getSearchResults();
  }
  void getSearchResults(){
    if(query.isNotEmpty){
      searchResults = _searchModel.data
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }else{
      searchResults = _searchModel.data;
    }
    notifyListeners();
  }
  SearchViewModel() {
    getSearchResults();
  }
}
