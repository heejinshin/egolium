import 'package:egolium/chatgpt/column_graph.dart';
import 'package:egolium/component/bottom_bar.dart';
import 'package:flutter/material.dart';
import '../component/appbar.dart';




class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Home_menu',
      theme: ThemeData(
        primarySwatch: Colors.indigo
      ),
    home: HomePageComponent(),
    );
  }

}

class HomePageComponent extends StatefulWidget{
  const HomePageComponent({Key? key}) : super(key: key);

  @override
  _HomePageComponentState createState() => _HomePageComponentState();



}

class _HomePageComponentState extends State<HomePageComponent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: Icon(Icons.arrow_back_outlined),
        title: Text('MY ID Balance \$298.98'),
        actions: [Icon(Icons.menu)],
      ),
      extendBodyBehindAppBar: true,
      bottomNavigationBar: MyBottomBar(),
      body: GraphArea(),
    );
  }
}




