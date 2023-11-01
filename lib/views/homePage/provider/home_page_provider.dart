import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:saveitmobile/models/history_model.dart';
import 'package:saveitmobile/views/homePage/functions/get_path_function.dart';

class HomePageProvider extends ChangeNotifier {
  String _downloadLink = '';
  double _downloadProgress = 0.0;
  bool _downloading = false;
  CancelToken _cancelToken = CancelToken();
  String _downloadedMsg = 'NOTE: Copy A Video Link & Press On That Button To Download\nDonwnloaded In: SAVEiT';
  int _selectedItem = 1;
  List<HistoryModel> _historyValues = [];
  bool _historyLoading = false;

  bool get historyLoading => _historyLoading;

  List<dynamic> get historyValues => _historyValues;

  int get selectedItem => _selectedItem;

  String get downloadedMsg => _downloadedMsg;

  CancelToken get cancelToken => _cancelToken;

  bool get downloading => _downloading;

  double get downloadProgress => _downloadProgress;

  String get downloadLink => _downloadLink;

  void setHistoryValues() async {
    _historyLoading = true;
    _historyValues.clear();
    final path = await getPath();
    List data = [];
    Directory directory = Directory(path);
    if (await directory.exists()) {
      data = directory.listSync(recursive: true);
    }
    for (var values in data) {
      if (values.path.contains('.mp3')) {
        HistoryModel model = HistoryModel(
          path: values.path,
          name: values.uri.pathSegments.last,
          icon: Icon(Icons.music_note),
        );
        _historyValues.add(model);
      } else if (values.path.contains('.mp4')) {
        HistoryModel model = HistoryModel(
          path: values.path,
          name: values.uri.pathSegments.last,
          icon: Icon(Icons.play_arrow),
        );
        _historyValues.add(model);
      }
    }
    _historyLoading = false;
    notifyListeners();
  }

  void setSelectedItem({required int value}) {
    _selectedItem = value;
    notifyListeners();
  }

  void setDownloaderNil() {
    _downloadProgress = 0;
    notifyListeners();
  }

  void setMsg({required String msg}) {
    _downloadedMsg = msg;
    notifyListeners();
  }

  void setCancelToken() {
    _cancelToken.cancel('Canceled By User');
    _cancelToken = CancelToken();
  }

  void setDownloading({required bool value}) {
    _downloading = value;
    notifyListeners();
  }

  void setDownloadProgress({required double value}) {
    _downloadProgress = value;
    notifyListeners();
  }

  void setDownloadLink({required String link}) {
    _downloadLink = link;
    notifyListeners();
  }
}
