import 'package:flutter/material.dart';

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
    );
  }
}
