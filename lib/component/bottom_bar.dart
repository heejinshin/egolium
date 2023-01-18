import 'package:flutter/material.dart';
import 'package:flutter_svg/parser.dart';
import 'package:flutter_svg/svg.dart';

class MyBottomBar extends StatefulWidget {
  @override
  initState() {
    final SvgParser parser = SvgParser();
    try {
      parser.parse('assets/icons/bottomnav/menu.svg', warningsAsErrors: true);
      print('SVG is supported');
    } catch (e) {
      print('SVG contains unsupported features');
    }
  }
  State<MyBottomBar> createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/bottomnav/menu.svg', width: 25, color: Colors.black,height: 25,),
                label: 'menu'
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/bottomnav/pfp.svg',  width: 25, color: Colors.black,height: 25,),
              label: 'pfp',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/bottomnav/did.svg', width: 25, color: Colors.black,height: 25,),
              label: 'did',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/bottomnav/wallet.svg', width: 25, color: Colors.black,height: 25,),
              label: 'wallet',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/bottomnav/settings.svg', width: 25, color: Colors.black,height: 25,),
              label: 'Account',
            ),
          ],
        )
    );
  }
}
