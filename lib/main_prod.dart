import 'package:flutter/material.dart';
import 'package:spinning_fishing_app/app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: "assets/.env.prod");
  runApp(const App());
}
