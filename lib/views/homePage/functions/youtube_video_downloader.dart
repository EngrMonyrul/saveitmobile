import 'dart:io';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:saveitmobile/views/homePage/provider/home_page_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

youtubeDownloader({required HomePageProvider provider, required String path}) async {
  Uri uri = Uri.parse(provider.downloadLink);
  String videoId = '';
  if (uri.host.contains('youtube')) {
    videoId = uri.queryParameters['v']!;
  }
  if (uri.host.contains('youtu.be')) {
    videoId = uri.pathSegments.first;
  }

  print(videoId);

  YoutubeExplode youtubeExplode = YoutubeExplode();
  Dio dio = Dio();
  if (videoId != null) {
    var manifest = await youtubeExplode.videos.streamsClient.getManifest(videoId);
    var streamInfo = await manifest.muxed.withHighestBitrate();
    if (streamInfo != null) {
      final name = basename(provider.downloadLink);
      var downloadPath = '$path$name.mp4';
      Response response = await dio.download(
        streamInfo.url.toString(),
        downloadPath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = (received / total * 100).toStringAsFixed(2);
            print('Download Progress: $progress%');
          }
        },
      );

      if (response.statusCode == 200) {
        print('Download Completed');
      }
    }
  }
}
