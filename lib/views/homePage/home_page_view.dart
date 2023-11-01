import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ripple_wave/ripple_wave.dart';
import 'package:saveitmobile/views/contactPage/contact_page_view.dart';
import 'package:saveitmobile/views/historyPage/history_page_view.dart';
import 'package:saveitmobile/views/homePage/functions/download_function.dart';
import 'package:saveitmobile/views/homePage/functions/get_permission_function.dart';
import 'package:saveitmobile/views/homePage/functions/get_text_function.dart';
import 'package:saveitmobile/views/homePage/provider/home_page_provider.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  void initState() {
    final homePageProvider = Provider.of<HomePageProvider>(context, listen: false);
    // TODO: implement initState
    super.initState();
    getPermission();
    homePageProvider.setHistoryValues();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<HomePageProvider>(
          builder: (context, value, child) {
            return FadeIn(
              duration: const Duration(seconds: 3),
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  Text(value.downloadedMsg, textAlign: TextAlign.center),
                  SizedBox(
                    height: value.downloading
                        ? MediaQuery.of(context).size.height * 0.1
                        : MediaQuery.of(context).size.height * .3,
                  ),
                  SizedBox(
                    child: value.downloading
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                height: MediaQuery.of(context).size.height * .47,
                                width: MediaQuery.of(context).size.width,
                                child: CircularProgressIndicator(
                                  value: value.downloadProgress / 100,
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    value.downloadProgress == 0
                                        ? 'Recognising File'
                                        : '${value.downloadProgress.toStringAsFixed(2)}%',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  CupertinoButton(
                                    color: Colors.blue,
                                    onPressed: () {
                                      value.setCancelToken();
                                      value.setDownloaderNil();
                                      value.setDownloading(value: false);
                                    },
                                    child: Text('Cancel'),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : CupertinoButton(
                            onPressed: () {
                              getText(provider: value);
                              if (value.downloadLink.contains('youtube') || value.downloadLink.contains('youtu.be')) {
                                value.setDownloading(value: true);
                                downloadMethod(context: context, provider: value);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    duration: Duration(seconds: 1),
                                    content: Center(child: Text('Copy YouTube Video Link'))));
                              }
                            },
                            child: RippleWave(
                              color: Colors.lightBlue,
                              duration: Duration(seconds: 1),
                              repeat: true,
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    CupertinoIcons.cloud_download,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CupertinoButton(
                        onPressed: () {
                          value.setSelectedItem(value: 1);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * .1,
                          width: MediaQuery.of(context).size.width / 4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              color: value.selectedItem == 1 ? Colors.lightBlueAccent : Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(5, 5),
                                ),
                              ]),
                          child: Icon(CupertinoIcons.play_arrow,
                              size: 30, color: value.selectedItem == 1 ? Colors.white : Colors.blue),
                        ),
                      ),
                      CupertinoButton(
                        onPressed: () {
                          value.setSelectedItem(value: 2);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * .1,
                          width: MediaQuery.of(context).size.width / 4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              color: value.selectedItem == 2 ? Colors.lightBlueAccent : Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(-5, 5),
                                ),
                              ]),
                          child: Icon(CupertinoIcons.music_note_list,
                              size: 30, color: value.selectedItem == 2 ? Colors.white : Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(5, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ContactPageView()));
                          },
                          child: Icon(
                            CupertinoIcons.person_alt_circle,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 10,
                            ),
                            children: [
                              TextSpan(text: 'SAVE'),
                              TextSpan(text: 'i', style: TextStyle(color: Colors.red)),
                              TextSpan(text: 'T'),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            getPermission();
                            value.setHistoryValues();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryPageView()));
                          },
                          child: Icon(Icons.history, size: 30, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
