import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saveitmobile/views/homePage/provider/home_page_provider.dart';
import 'package:saveitmobile/views/videoPlayer/video_player_views.dart';

class HistoryPageView extends StatefulWidget {
  const HistoryPageView({super.key});

  @override
  State<HistoryPageView> createState() => _HistoryPageViewState();
}

class _HistoryPageViewState extends State<HistoryPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text('History', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Consumer<HomePageProvider>(builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: value.historyValues.length,
            itemBuilder: (context, index) {
              return CupertinoButton(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VideoPlayerScreen(videoPath: value.historyValues[index].path)));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(5, 5),
                      ),
                    ],
                  ),
                  child: ListTile(
                      leading: value.historyValues[index].icon,
                      title: Text(value.historyValues[index].name),
                      subtitle: Text(value.historyValues[index].path),
                      trailing: InkWell(
                        onTap: () async {
                          Directory directory = Directory(value.historyValues[index].path);
                          if (await directory.exists()) {
                            directory.delete(recursive: true);
                            value.setHistoryValues();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.grey)),
                          child: Icon(CupertinoIcons.delete),
                        ),
                      )),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
