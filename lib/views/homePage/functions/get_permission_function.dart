import 'package:permission_handler/permission_handler.dart';

Future<bool> getPermission() async {
  try {
    PermissionStatus storagePermission = await Permission.storage.request();
    if (storagePermission.isGranted) {
      return true;
    } else if (storagePermission.isPermanentlyDenied) {
      openAppSettings();
    } else {
      return false;
    }
  } catch (e) {
    print(e.toString());
  }
  return false;
}
