import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'services.dart';

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  CameraController camera;
  bool isDetecting = false;
  bool serviceStatus = false;
  
class services_ui extends StatefulWidget {
  static const id = 'services_ui';

  @override
  _services_uiState createState() => _services_uiState();
}

class _services_uiState extends State<services_ui> {

  String buttonName="Start";

  @override
  void initState() {
    super.initState();
    var initializeSettingsAndroid=AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializeSettingsIOS=IOSInitializationSettings();
    var initializeSettings=InitializationSettings(initializeSettingsAndroid, initializeSettingsIOS);
    flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializeSettings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: GestureDetector(
            onTap: () {
              if (serviceStatus == false) {
                startServices();
                serviceStatus = true;
                setState(() {
                  buttonName="Stop";
                });
              }
              else{
                stopServices();
                serviceStatus=false;
                setState(() {
                  buttonName="Start";
                });
              }
            },
            child: Container(
              height: 0.2  * MediaQuery.of(context).size.height,
              width: 0.8 * MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: FittedBox(
                child: Text(buttonName,style: TextStyle(color: Colors.white),),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
