class SearchModel {
  List<String> data = [
    'Bread',
    'Hot Dog',
    'Ketchup',
    'Mustard',
    'Pickles',
    'Cheese',

  ];

  List<String> getSearchResults(String query) {
    return data
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}