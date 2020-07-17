import 'package:flutter/material.dart';
import 'package:men/loadingScreen.dart';
import 'package:men/services_ui.dart';
import 'reports.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: reports.id,
        routes:(
          {
            loadingScreen.id:(context)=>loadingScreen(),
            services_ui.id:(context)=>services_ui(),
            reports.id:(context)=>reports(),
          }
        ),
    );
  }
}