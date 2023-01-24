import 'package:egolium/lockscreen/pattern_lock/util.dart';
import 'package:flutter/material.dart';


class SetPattern extends StatefulWidget {
  const SetPattern({Key? key}) : super(key: key);

  @override
  State<SetPattern> createState() => _SetPatternState();
}

class _SetPatternState extends State<SetPattern> {
  List<int>? Pattern;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialButton(
        color: Colors.lightGreen,
        child: Text("Set Pattern", style: TextStyle(color: Colors.white)),
        onPressed: () async {
          final result = await Navigator.pushNamed(context, "/set_pattern");
          if (result is List<int>) {
            context.replaceSnackbar(
              content: Text("pattern is $result"),
            );
            setState(() {
              Pattern = result;
            });
          }
        },
      ),
    );
  }
}
