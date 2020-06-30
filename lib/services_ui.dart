import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class services_ui extends StatefulWidget {

  static const id='services_ui';

  @override
  _services_uiState createState() => _services_uiState();
}

class _services_uiState extends State<services_ui> {

  CameraController camera;

  @override
  void initState() {
    super.initState();
    startCamera();
  }

  void startCamera() async{
    camera=CameraController(await getFrontCamera(),ResolutionPreset.low);
    await camera.initialize();
    camera.startImageStream((image){
      //Heres the image  TODO
    });
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