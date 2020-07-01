import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';

class services_ui extends StatefulWidget {

  static const id='services_ui';

  @override
  _services_uiState createState() => _services_uiState();
}

class _services_uiState extends State<services_ui> {

  CameraController camera;
  bool isDetecting=false;

  @override
  void initState() {
    super.initState();
    startServices();
  }

void startServices()async {
  await loadModel();
}
  Future<void> loadModel() async{
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
      );
    await startCamera();
  }

  Future<void> startCamera() async{
    print("in startCamera");
    camera=CameraController(await getFrontCamera(),ResolutionPreset.low);
    await camera.initialize();
    camera.startImageStream((image){ 
      if(isDetecting==false){
       isDetecting=true;
       runModel(image);
      }
    });
  }

  Future<void> runModel(CameraImage img)async{
    var output=await Tflite.runModelOnFrame(
      bytesList: img.planes.map((plane) {return plane.bytes;}).toList(),
      imageHeight: img.height,
      imageWidth: img.width,
      imageMean: 127.5,   
      imageStd: 127.5,    
      rotation: 90,       
      numResults: 2,      
      threshold: 0.1,     
      asynch: true        
      );
      print('Status is ${output[0]["label"]}');
      isDetecting=false;
  }

  Future<CameraDescription> getFrontCamera ()async{
    return await availableCameras().then((cameras)=>cameras.firstWhere((name)=>name.lensDirection==CameraLensDirection.front));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Container(
          color:Colors.red,
        ),
      ),
    );
  }
}