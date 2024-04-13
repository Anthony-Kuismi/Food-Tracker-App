import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../viewmodel/daily_viewmodel.dart';

class DailyView extends StatelessWidget {
  late DailyViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<DailyViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Summary', style: TextStyle(color: Colors.black)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: FutureProvider(
          create: (BuildContext context) {
            viewModel.init();
            return null;
          },
          builder: (context,snapshot){
            return SingleChildScrollView(
              child: Column(
                children: [
                  Text('${DateFormat('HH:mm MM-dd-yyyy').format(viewModel.timestamp)}')
                ],
              ),
            );
          },
        initialData: [],
      )
    );
  }
}