import 'dart:io';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:saveitmobile/views/homePage/provider/home_page_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

youtubeDownloader({required HomePageProvider provider, required String path}) async {
  Uri uri = Uri.parse(provider.downloadLink);
  dynamic streamInfo;
  dynamic downloadPath;
  print(uri.path);
  String videoId = '';
  if (uri.host.contains('youtube')) {
    videoId = uri.queryParameters['v']!;
  }
  if (uri.host.contains('youtu.be')) {
    videoId = uri.pathSegments.first;
  }

  YoutubeExplode youtubeExplode = YoutubeExplode();
  Dio dio = Dio();
  var videoFile = await youtubeExplode.videos.get(videoId);
  final name = videoFile.title;
  if (videoId != null) {
    var manifest = await youtubeExplode.videos.streamsClient.getManifest(videoId);
    if (provider.selectedItem == 1) {
      streamInfo = await manifest.muxed.withHighestBitrate();
      downloadPath = '$path$name.mp4';
    } else {
      streamInfo = await manifest.audioOnly.withHighestBitrate();
      downloadPath = '$path$name.mp3';
    }
    if (streamInfo != null) {
      Response response = await dio.download(
        streamInfo.url.toString(),
        downloadPath,
        cancelToken: provider.cancelToken,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = (received / total * 100);
            print(progress);
            provider.setDownloadProgress(value: progress);
          }
        },
      );

      if (response.statusCode == 200) {
        provider.setDownloading(value: false);
        provider.setDownloaderNil();
        if (provider.selectedItem == 1) {
          provider.setMsg(msg: 'File Saved In\nFolder - SAVEiT\nFile - $name.mp4');
        } else {
          provider.setMsg(msg: 'File Saved In\nFolder - SAVEiT\nFile - $name.mp3');
        }
      }
    }
  }
}
