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
  Map<String, bool> searchResults = {};

  void onQueryChanged(String query) async {
    List<String> results = await _viewModel.getSearchResults(query);
    setState(() {
     searchResults = _viewModel.getChecklistMap(results);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Food Items'),
      ),
      body: Column(
        children: [
          SearchBar(onQueryChanged: onQueryChanged),
          Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8.0),
                children: searchResults.keys.map((String key) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CheckboxListTile(
                      title: Text(
                          key,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                      ),
                      checkColor: Theme.of(context).colorScheme.onPrimary,
                      activeColor: Theme.of(context).colorScheme.secondary,
                      value: searchResults[key],
                      onChanged: (bool? value){
                        setState(() {
                          searchResults[key] = value ?? true;
                        });
                          _viewModel.updateSelectedFoods(searchResults);
                      },
                    ),
                  );
                }).toList(),
              ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              _viewModel.sendSelectedFoods();
            },
            icon: const Icon(Icons.add, size: 18),
            label: const Text("Add Selected Foods"),
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

    searchTimer = Timer(const Duration(milliseconds: 500), () {
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