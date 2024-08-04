import 'package:flutter/material.dart';
import 'package:my_phone_tool/views/screens/sms_fetcher_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SmsFetcherScreen(),
    );
  }
}


