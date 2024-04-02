import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../model/food.dart';
import '../food_view.dart';

class NutritionRow extends StatefulWidget{
  final String label;
  var value;
  final String measurement;

  NutritionRow(this.label, this.value, this.measurement, {super.key});

  @override
  NutritionRowState createState() => NutritionRowState();
}

class NutritionRowState extends State<NutritionRow>{
  void updateValue(newValue){
    setState(() {
      widget.value = newValue;
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        showDialog(
            context: context, 
            builder: (BuildContext context){
              TextEditingController controller = TextEditingController();
              return AlertDialog(
                title: Text('Editing ${widget.label}'),
                content: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Enter New Value',
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      double? newValue = double.tryParse(controller.text);
                      if (newValue != null) {
                        updateValue(newValue);
                      }
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            }
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${widget.label}${widget.value}${widget.measurement}'),
          const Padding(
            padding: EdgeInsets.fromLTRB(6,4,0,0),
            child: Icon(
              Icons.edit
            ),
          ),
        ]
      ),
    );
  }
}