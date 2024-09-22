import 'package:flutter/material.dart';

class padding extends StatelessWidget {

  final double top;
  final double botton;

  padding(this.top, this.botton);

  @override
  Widget build(BuildContext) {
    return
      Padding(
        padding: EdgeInsets.only(
          top: top,
          bottom: botton,
        ),
      );
  }
}
