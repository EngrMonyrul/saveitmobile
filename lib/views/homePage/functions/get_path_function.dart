import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> getPath() async {
  final dir = await getExternalStorageDirectory();
  final dirList = dir!.path.split('/');
  String downloadDir = '';
  for (int i = 0; i < dirList.length; i++) {
    final String cuttedDir = dirList[i];
    if (cuttedDir == 'Android') {
      break;
    } else {
      downloadDir += '$cuttedDir/';
    }
  }
  downloadDir += 'SAVEiT/';
  Directory directory = Directory(downloadDir);
  if (!await directory.exists()) {
    await directory.create(recursive: true);
  }
  return directory.path;
}
