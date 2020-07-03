import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class services_ui extends StatefulWidget {
  static const id = 'services_ui';

  @override
  _services_uiState createState() => _services_uiState();
}

class _services_uiState extends State<services_ui> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  CameraController camera;
  bool isDetecting = false;
  bool serviceStatus = false;

  @override
  void initState() {
    super.initState();
    var initializeSettingsAndroid=AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializeSettingsIOS=IOSInitializationSettings();
    var initializeSettings=InitializationSettings(initializeSettingsAndroid, initializeSettingsIOS);
    flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializeSettings);
    startServices();//Key to start
  }

  void showNotification()async{
    var androidChannelSpecifics=AndroidNotificationDetails('channelId', 'channelName', 'channelDescription',importance: Importance.Max,priority: Priority.High);
    var IOSChannelSpecifics=IOSNotificationDetails();
    var platformChannelSpecifics=NotificationDetails(androidChannelSpecifics,IOSChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, 'Alert', 'Face touch detected!', platformChannelSpecifics);
  }

  void startServices() async {
    await loadModel();
  }

  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
    await startCamera();
  }

  Future<void> startCamera() async {
    print("in startCamera");
    camera = CameraController(await getFrontCamera(), ResolutionPreset.low);
    await camera.initialize();
    camera.startImageStream((image) {
      if (isDetecting == false) {
        isDetecting = true;
        runModel(image);
      }
    });
  }

  Future<void> runModel(CameraImage img) async {
    var output = await Tflite.runModelOnFrame(
        bytesList: img.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: img.height,
        imageWidth: img.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 2,
        threshold: 0.1,
        asynch: true);
    print('Status is ${output[0]["label"]}');
    //TODO show notification
    // showNotification();
    isDetecting = false;
  }

  Future<CameraDescription> getFrontCamera() async {
    return await availableCameras().then((cameras) => cameras
        .firstWhere((name) => name.lensDirection == CameraLensDirection.front));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: GestureDetector(
            onTap: () {
              if (serviceStatus == false) {
                serviceStatus = true;
                startServices();
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
                child: Text('Start Services',style: TextStyle(color: Colors.white),),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
