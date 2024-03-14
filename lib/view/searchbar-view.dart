import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:food_tracker_app/viewmodel/searchbar-viewmodel.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchViewModel _viewModel = SearchViewModel();
  Map<String, bool> searchResults = {
    'foo': true,
    'bar': false,
  };

  void onQueryChanged(String query) async {
    List<String> results = await _viewModel.getSearchResults(query);
    _viewModel.updateSelectedFoods(searchResults);
    setState(() {
     searchResults = _viewModel.getChecklistMap(results);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Food Items'),
      ),
      body: Column(
        children: [
          SearchBar(onQueryChanged: onQueryChanged),
          Expanded(
              child: ListView(
                children: searchResults.keys.map((String key) {
                  return CheckboxListTile(
                    title: Text(key),
                    value: searchResults[key],
                    onChanged: (bool? value){
                      setState(() {
                        searchResults[key] = value ?? true;
                      });
                    },
                  );
                }).toList(),          ),
          )
        ],
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  final Function onQueryChanged;

  SearchBar({required this.onQueryChanged});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String query = '';
  Timer? searchTimer;

  void onQueryChanged(String newQuery) {
    setState(() {
      query = newQuery;
    });

    if (searchTimer?.isActive ?? false) {
      searchTimer?.cancel();
    }

    searchTimer = Timer(const Duration(seconds: 2), () {
      widget.onQueryChanged(newQuery);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: TextField(
        onChanged: onQueryChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}