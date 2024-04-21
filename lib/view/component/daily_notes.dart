import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/daily_viewmodel.dart';
import '../../viewmodel/homepage_viewmodel.dart';

class DailyNotes extends StatelessWidget {
  DateTime timestamp;
  Color? color;
  double? height;

  DailyNotes({DateTime? timestamp = null, this.color = null, this.height = null})
      : timestamp = timestamp ??
            DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    final dailyViewModel = Provider.of<DailyViewModel>(context);
    final viewModel = Provider.of<HomePageViewModel>(context);
    String displayedNotes = dailyViewModel.dailyNote;
    final controller = TextEditingController(text: viewModel.dailyNote);

    return SizedBox(
      height: MediaQuery.of(context).size.height / 4.5,
      child: GridView.count(
        crossAxisCount: 1,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 4.5),
        children: <Widget>[
          Consumer<HomePageViewModel>(
            builder: (context, viewModel, child) => GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Edit Notes'),
                      content: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          hintText: 'Enter Notes',
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            String notes = controller.text;
                            if(DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day).millisecondsSinceEpoch-timestamp.millisecondsSinceEpoch==0)viewModel.addNotes(notes);
                            dailyViewModel.dailyNote = notes;
                            Navigator.of(context).pop();
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: color??Colors.black45,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 9, bottom: 9, right: 19, left: 19),
                            child: Text(
                              'Notes',
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 9, bottom: 9, right: 19, left: 19),
                            child: const Icon(Icons.note_add),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 40,
                      left: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Notes'),
                                content: SingleChildScrollView(
                                  child: Text(
                                    displayedNotes,
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Close'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text(
                          displayedNotes.length > 20
                              ? displayedNotes.substring(0, 20) + "..."
                              : displayedNotes,
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
