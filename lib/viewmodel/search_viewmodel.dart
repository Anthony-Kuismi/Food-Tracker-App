import 'package:flutter/cupertino.dart';
import 'package:food_tracker_app/model/search_model.dart';

class SearchViewModel extends ChangeNotifier {
  final SearchModel _searchModel = SearchModel();

  List<String> getSearchResults(){
    return _searchModel.searchResults;
  }

  void updateQuery(String newQuery){
    _searchModel.query = newQuery;
    updateSearchResults();
  }

  void updateSearchResults(){
    if(_searchModel.query.isNotEmpty){
      _searchModel.searchResults = _searchModel.data
          .where((item) => item.toLowerCase().contains(_searchModel.query.toLowerCase()))
          .toList();
    }else{
      _searchModel.searchResults = _searchModel.data;
    }
    notifyListeners();
  }

  SearchViewModel() {
    updateQuery("");
    updateSearchResults();
  }
}
