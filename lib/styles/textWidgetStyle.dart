

import 'package:flutter/material.dart';
import 'package:flutter_app8/values/myConstants.dart';

class MyTextWidgetLabel extends StatelessWidget {
  final String type;
  final String data;
  final Color color;
  final double size;
  MyTextWidgetLabel(this.data, this.type,this.color,this.size);

  @override
  Widget build(BuildContext context) {
    if (type == 'label') {
      return Padding(
        padding: EdgeInsetsDirectional.only(start: 32.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.height/1.3,

          child: Text(
            data,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: color,
                fontSize: size,
                fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
    else
      {
      return new Text(
          data,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: color,
              fontSize: size,
              fontWeight: FontWeight.bold),
        );
      }
    return Text("");
  }
}
