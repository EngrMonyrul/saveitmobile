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
    // TODO: implement initState
    super.initState();
    getPermission();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<HomePageProvider>(
          builder: (context, value, child) {
            return FadeIn(
              duration: const Duration(seconds: 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  Text('NOTE: Copy A Video Link & Press On That Button To Download\nDonwnloaded In: SAVEiT',
                      textAlign: TextAlign.center),
                  SizedBox(height: MediaQuery.of(context).size.height * .35),
                  CupertinoButton(
                    onPressed: () {
                      getText(provider: value);
                      downloadMethod(context: context, provider: value);
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
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
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
