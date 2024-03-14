import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:food_tracker_app/viewmodel/search_viewmodel.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SearchViewModel>(context,listen:false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Search Bar Tutorial'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: TextField(
              onChanged: (newQuery) => viewModel.updateQuery(newQuery),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: Consumer<SearchViewModel>(
              builder: (context, viewModel, child) {
                return ListView.builder(
                  itemCount: viewModel.searchResults.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(viewModel.searchResults[index]),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
