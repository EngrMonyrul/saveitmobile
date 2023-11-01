import 'package:flutter/material.dart';
import 'package:saveitmobile/views/homePage/provider/home_page_provider.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

Future<void> startDownload({required BuildContext context, required HomePageProvider homePageProvider}) async {
  final response = await http.get(Uri.parse(homePageProvider.downloadLink));

  if (response.statusCode == 200) {
    String files = response.body.toString();
    print(files);
  } else {
    print('Someting Went Wrong');
  }

  final document = parse(response.body);
  // print(document);
}
