import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:camera/camera.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tflite/tflite.dart';
import 'services_ui.dart';

void showNotification()async{
    var androidChannelSpecifics=AndroidNotificationDetails('channelId', 'channelName', 'channelDescription',importance: Importance.Max,priority: Priority.High);
    var IOSChannelSpecifics=IOSNotificationDetails();
    var platformChannelSpecifics=NotificationDetails(androidChannelSpecifics,IOSChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, 'Alert', 'Face touch detected!', platformChannelSpecifics);
  }

  void startServices() async {
    await AndroidAlarmManager.initialize();
    await AndroidAlarmManager.oneShot(const Duration(seconds: 1), 0, printer);
    // await loadModel();
  }

  void printer(){
    for(int i=0;i<100;i++)
      print("i");
  }

  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
    await startCamera();
  }

  Future<void> startCamera() async {
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
    var outputStatus=output[0]["label"];
    print('Status is ${output[0]["label"]}');
    // if(outputStatus=="0 Touches")
      showNotification();
    isDetecting = false;
  }

  Future<CameraDescription> getFrontCamera() async {
    return await availableCameras().then((cameras) => cameras
        .firstWhere((name) => name.lensDirection == CameraLensDirection.front));
  }


  void stopServices(){
    // camera.stopImageStream();//TODO
    AndroidAlarmManager.cancel(0);
  }