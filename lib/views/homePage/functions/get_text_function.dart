import 'package:flutter/services.dart';
import 'package:saveitmobile/views/homePage/provider/home_page_provider.dart';

getText({required HomePageProvider provider}) async {
  ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
  if (data != null) {
    String copiedText = data.text ?? '';
    provider.setDownloadLink(link: copiedText);
  }
}
