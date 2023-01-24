import 'package:egolium/lockscreen/pattern_lock/set_pattern.dart';
import 'package:egolium/lockscreen/pattern_lock/util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pattern_lock/pattern_lock.dart';
import '../../main.dart';
import 'package:egolium/lockscreen/pattern_lock/set_pattern.dart';


class CheckPattern extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final List<int>? pattern = SetPattern.pattern;
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
              "Draw Your pattern",
              style: TextStyle(fontSize: 26),
            ),
          ),
          Flexible(
            child: PatternLock(
              selectedColor: Colors.red,
              pointRadius: 8,
              showInput: true,
              dimension: 3,
              relativePadding: 0.7,
              selectThreshold: 25,
              fillPoints: true,
              onInputComplete: (List<int> input) {
                if (listEquals<int>(input, pattern)) {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> TestPage()));
                } else {
                  context.replaceSnackbar(
                    content: Text(
                      "wrong",
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}