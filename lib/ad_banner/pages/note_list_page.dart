import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../provider.dart';

class _NoteListPageState extends State<NoteListPage> {
  BannerAd? _bannerAd; // 로드할 광고정보를 저장할 변수

  @override
  void initState() {
    super.initState();
    adHelper().loadBanner((ad) => {
      if (_bannerAd == null)
        {
          setState(() {
            // 화면 갱신
            _bannerAd = ad;
          })
        }
    });
  }

  ...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sticky Notes'),
      ),
      // body: GridView(
      //   children: _buildCards(),
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 2,
      //     childAspectRatio: 1,
      //   ),
      //   padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
      // ),
      body: FutureBuilder(
        future: NoteManager().listNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            List<Note> notes = snapshot.data as List<Note>;
            GridView noteGrid = GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                itemCount: notes.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  return _buildCard(notes[index]);
                });

            if (_bannerAd != null) {
              return SafeArea(
                child: Column(
                  children: [
                    Expanded(child: noteGrid), // gridView의 높이가 무한히 길어지면 좀 그렇다
                    Container(
                      width: _bannerAd!.size.width.toDouble(),
                      height: _bannerAd!.size.height.toDouble(),
                      child: AdWidget(
                        ad: _bannerAd!,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return noteGrid;
            }
          }

          return Center(
            child: Text('오류가 발생했습니다'),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: _bannerAd != null
            ? adHelper().getFabPadding(context)
            : EdgeInsets.zero,
        child: FloatingActionButton(
          child: Icon(Icons.add),
          tooltip: '새 노트',
          onPressed: () {
            Navigator.pushNamed(context, NoteEditPage.rootName).then((value) {
              setState(() {});
            });
          },
        ),
      ),
    );
  }


  @override
  void dispose() {
    adHelper().dispose();
    super.dispose();
  }
  ...

class NoteListPage {
}