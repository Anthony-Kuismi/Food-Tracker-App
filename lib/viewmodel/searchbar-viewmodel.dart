import 'package:flutter/cupertino.dart';
import 'package:food_tracker_app/model/searchmodel.dart';

class SearchViewModel extends ChangeNotifier {
  final SearchModel _searchModel = SearchModel();

  List<String> getSearchResults(String query) {
    return _searchModel.getSearchResults(query);
  }
}