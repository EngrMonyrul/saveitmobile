import 'dart:io';

import 'package:dio/dio.dart';
import 'package:saveitmobile/views/homePage/provider/home_page_provider.dart';

Future<void> facebookVideoDownload({required HomePageProvider homePageProvider, required String path}) async {
  final dio = Dio();
  final name = DateTime.now().millisecondsSinceEpoch;
  final file = File('$path/$name.mp4');
  // print(homePageProvider.downloadLink);
  // String postUrl = homePageProvider.downloadLink ?? '';
  // RegExp regExp = RegExp(r"videos/(\d+)");
  // String videoId = regExp.firstMatch(postUrl)!.group(1)!;
  // print(videoId);
  // print(file.path);
  await dio.download(
    'https://www.facebook.com/v2.3/plugins/video.php?href=https://www.facebook.com/video.php?v=1368382874115164?mibextid=NnVzG8',
    file.path,
    onReceiveProgress: (count, total) {
      if (total != -1) {
        final progress = (count / total * 100);
        print(progress);
        homePageProvider.setDownloadProgress(value: progress);
      }
    },
  );
  print('Downloaded');

  homePageProvider.setDownloading(value: false);
  homePageProvider.setDownloaderNil();
  homePageProvider.setMsg(msg: 'File Saved In\nFolder - SAVEiT\nFile - $name.mp4');
}
