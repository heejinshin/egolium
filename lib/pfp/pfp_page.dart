import 'package:egolium/component/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/parser.dart';
import 'package:flutter_svg/svg.dart';

class PfpPage extends StatefulWidget {
  const PfpPage({Key? key}) : super(key: key);

  @override
  State<PfpPage> createState() => _PfpPageState();

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
}

class _PfpPageState extends State<PfpPage> {
  List<String> items = [
    "All PFPs",
    "PFP",
    "NFT",
    "Collectibles",
    "Photograph",
  ];

  // List<String> colors = [
  //   "pink"
  //   "blue"
  //   "purple"
  //   "white"
  // ];

  int current = 0;

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: Icon(Icons.arrow_back_outlined),
        title: Text('MY ID Balance \$298.98'),
        actions: [Icon(Icons.menu)],
      ),
      bottomNavigationBar:

      BottomNavigationBar(
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/bottomnav/menu.svg', width: 25, color: Colors.black,height: 25,),
              label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/bottomnav/pfp.svg',  width: 25, color: Colors.black,height: 25,),
            label: 'PFP/NFT',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/bottomnav/did.svg', width: 25, color: Colors.black,height: 25,),
            label: 'DID',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/bottomnav/wallet.svg', width: 25, color: Colors.black,height: 25,),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/bottomnav/settings.svg', width: 25, color: Colors.black,height: 25,),
            label: 'Account',
          ),
        ],
      ),
      body: Stack(
        children: [
          //background
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/image/auth_background.png')
                )
            ),
          ),
          //menu
          Container(
            margin: const EdgeInsets.only(top: 100.0),
          child: Column(
            children: [
              SizedBox(
                height: 60,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: items.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        current = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: EdgeInsets.all(5),
                      width: 80,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                          color: current == index? Colors.black87 : Colors.black54),
                      child: Center(
                        child: Text(
                          style: TextStyle(color: Colors.white),
                          items[index],
                        ),
                      ),
                    ),
                  );
                }),
              )
            ],
          ),
        ),
          //cards
          Container(
            margin: EdgeInsets.only(left: 20, top: 180),
            child: Text("PFP/NFT Storage",
            style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),),
          Stack(
            children: [
              Container(
              margin: EdgeInsets.only(left: 20, top: 250),
              width: 200,
              height: 260,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromRGBO(255, 195, 184, 10)
              ),
            ),
              Container(
                margin: EdgeInsets.only(left: 20, top: 410),
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                    color: Color.fromRGBO(136, 139, 145, 10)
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, top: 530),
                width: 200,
                height: 260,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(174, 226, 247, 10)
                ),
              ),
              //pink박스 위에 하트 버튼 stack 한것
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20)
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, top: 700),
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                    color: Color.fromRGBO(136, 139, 145, 10)
                ),
              ),
            ]
          )
        ]
      ),
    );
  }
}
