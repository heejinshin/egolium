import 'package:egolium/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';

import 'lockscreen/face_auth.dart';

class StartPage extends StatefulWidget {
   StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();

}

class _StartPageState extends State<StartPage> {
  String mining_data = '32.093';



  @override
  Widget build(BuildContext context)  {

    // final bool canAuthenticateWithBiometrics =  auth.canCheckBiometrics;
    // final bool canAuthenticate = canAuthenticateWithBiometrics || auth.isDeviceSupported();

    return Stack(
      children: [
        Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: CurrentTime(),
            actions: [TextButton(onPressed: (){},
                child:Text("${mining_data}"))],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //image
            Container(
              margin: EdgeInsets.only(top: 200),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/image/authentic.png"),
                  fit: BoxFit.coverche
                )
              ),
            ),
            //banner...
            Container(),
            //Pattern
            Container(),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder:(context)=>FaceAuth()));
            }, child: Text("In other way"))
          ],
        ),
      ],
    );
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(""), fit: BoxFit.cover)),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(

            elevation: 0.0,
            backgroundColor: Colors.transparent,
            leading: CurrentTime(),
            title: Text('MY ID Balance \$298.98'),
            actions: [Icon(Icons.menu)],
          ),
        ),

    );
  }
}

class CurrentTime extends StatefulWidget {
  const CurrentTime({Key? key}) : super(key: key);

  @override
  _CurrentTimeState createState() => _CurrentTimeState();
}

class _CurrentTimeState extends State<CurrentTime> {
  TimeOfDay _timeOfDay = TimeOfDay.now();
  var formatter = DateFormat.MMMMEEEEd().format(DateTime.now());
  var day = DateFormat.yMEd().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    String _period = _timeOfDay.period == DayPeriod.am ? "AM" : "PM";
    return Row(
      children: [
        Text("${_timeOfDay.hour}:${_timeOfDay.minute}",
          style: Theme.of(context).textTheme.headline2,
        ),
        Text("${day}")
      ],
    );
  }
}










