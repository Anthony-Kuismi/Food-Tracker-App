import 'package:flutter/material.dart';
import 'dart:async';
import 'package:food_tracker_app/viewmodel/searchbar-viewmodel.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchViewModel _viewModel = SearchViewModel();
  List<String> searchResults = [];

  void onQueryChanged(String query) async {
    List<String> results = await _viewModel.getSearchResults(query);
    setState(() {
      searchResults = results;
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
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(searchResults[index]),
                );
              },
            ),
          ),
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