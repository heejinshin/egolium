import 'package:egolium/lockscreen/pattern_lock/util.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pattern_lock/pattern_lock.dart';
import 'package:provider/provider.dart';


class SetPattern extends StatefulWidget {


  @override
  SetPatternState createState() => SetPatternState(
  );
}

class _SetPatternState extends State<SetPattern> {
  bool isConfirm = false;


  // SetPattern get pattern => _pattern;
  List<int>? _pattern;


  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Check Pattern"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Flexible(
            child: Text(
              isConfirm ? "Confirm pattern" : "Draw pattern",
              style: TextStyle(fontSize: 26),
            ),
          ),
          Flexible(
            child: PatternLock(
              selectedColor: Colors.amber,
              pointRadius: 12,
              onInputComplete: (List<int> input) {
                if (input.length < 3) {
                  context.replaceSnackbar(
                    content: Text(
                      "At least 3 points required",
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                  return;
                }
                if (isConfirm) {
                  if (listEquals<int>(input, pattern)) {
                    Navigator.of(context).pop(pattern);
                  } else {
                    context.replaceSnackbar(
                      content: Text(
                        "Patterns do not match",
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                    setState(() {
                      pattern = null;
                      isConfirm = false;
                    });
                  }
                } else {
                  setState(() {
                    pattern = input;
                    isConfirm = true;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}