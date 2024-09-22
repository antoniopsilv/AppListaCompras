import 'package:flutter/material.dart';

class cellDelete extends StatelessWidget {

  final String label;
  final String text;

  cellDelete(this.label,this.text);

  @override
  Widget build(BuildContext) {
    return
      Align(
        alignment: Alignment.topLeft,
        child: Text( label+" : "+text,
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      );
  }
}