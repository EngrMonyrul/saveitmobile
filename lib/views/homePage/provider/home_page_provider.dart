import 'package:flutter/material.dart';

class HomePageProvider extends ChangeNotifier {
  String _downloadLink = '';

  String get downloadLink => _downloadLink;

  void setDownloadLink({required String link}) {
    _downloadLink = link;
    notifyListeners();
  }
}
