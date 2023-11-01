import 'package:flutter/cupertino.dart';
import 'package:saveitmobile/views/homePage/functions/facebook_video_download.dart';
import 'package:saveitmobile/views/homePage/functions/flutter_downloader_functions.dart';
import 'package:saveitmobile/views/homePage/functions/get_path_function.dart';
import 'package:saveitmobile/views/homePage/functions/get_permission_function.dart';
import 'package:saveitmobile/views/homePage/functions/youtube_video_downloader.dart';
import 'package:saveitmobile/views/homePage/provider/home_page_provider.dart';
import 'package:dio/dio.dart';

downloadMethod({required BuildContext context, required HomePageProvider provider}) async {
  Dio dio = Dio();
  bool permission = await getPermission();
  final path = await getPath();
  if (provider.downloadLink.contains('youtube') || provider.downloadLink.contains('youtu.be')) {
    youtubeDownloader(provider: provider, path: path);
  } else {
    // facebookVideoDownload(homePageProvider: provider, path: path);
    startDownload(context: context, homePageProvider: provider);
  }
}
