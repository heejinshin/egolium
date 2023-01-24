import 'package:egolium/lockscreen/pattern_lock/set_pattern.dart';
import 'package:egolium/lockscreen/pattern_lock/util.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:egolium/lockscreen/pattern_lock/set_pattern.dart';
import 'check_pattern.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';




class PatternLock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pattern Lock Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      routes: {
        "/check_pattern": (BuildContext context) => CheckPattern(),
        "/set_pattern": (BuildContext context) => SetPattern(),

      },
      home: Scaffold(
        appBar: AppBar(
          title: Text("Pattern Lock Demo"),
        ),
        body: HomeWidget(),
      ),
    );
  }
}

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  // SetPattern pattern = new SetPattern();

  List<int>? pattern = SetPattern().pattern;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'This is demo of "Pattern Lock" Flutter library',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 4),
          InkWell(
            child: Text(
              'https://github.com/qwert2603/pattern_lock',
              style: TextStyle(fontSize: 16, color: Colors.deepOrange),
            ),
            onTap: () => launchUrl("https://github.com/qwert2603/pattern_lock"),
          ),
          SizedBox(height: 4),
          InkWell(
            child: Text(
              'https://pub.dev/packages/pattern_lock',
              style: TextStyle(fontSize: 16, color: Colors.deepOrange),
            ),
            onTap: () => launchUrl("https://pub.dev/packages/pattern_lock"),
          ),
          SizedBox(height: 24),

          if (pattern != null) ...[
            SizedBox(height: 16),
            MaterialButton(
              color: Colors.green,
              child:
              Text("Check Pattern", style: TextStyle(color: Colors.white)),
              onPressed: () async {
                final result = await Navigator.pushNamed(
                  context,
                  "/check_pattern",
                  arguments: pattern,
                );
                if (result == true) {
                  context.replaceSnackbar(
                    content: Text(
                      "it's correct",
                      style: TextStyle(color: Colors.green),
                    ),
                  );
                }
              },
            ),
          ],
          SizedBox(height: 24),

        ],
      ),
    );
  }
}