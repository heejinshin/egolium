import 'package:egolium/chatgpt/column_graph.dart';
import 'package:egolium/pfp/pfp_card.dart';
import 'package:egolium/pfp/pfp_page.dart';
import 'package:flutter/material.dart';
import 'home/home_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: TestPage()
    );
  }
}

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder:(context)=>PfpPage()));
          }, child: Text("test pfp page")),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder:(context)=>ColumnGraph()));
          }, child: Text("GraphArea"))
        ],
      ),
    );
  }
}


