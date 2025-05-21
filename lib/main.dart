import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:workbond/app.dart';
import 'package:workbond/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await di.init();
  // runApp(MyApp());

  runApp(DevicePreview(enabled: !kReleaseMode, builder: (context) => MyApp()));
}
