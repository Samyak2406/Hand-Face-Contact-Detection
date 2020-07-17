import 'package:flutter/material.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:connectivity/connectivity.dart';
import 'package:men/services_ui.dart';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String deviceName="Your-ID";
class loadingScreen extends StatefulWidget {
  static const id="loadingScreen";
  @override
  _loadingScreenState createState() => _loadingScreenState();
}

class _loadingScreenState extends State<loadingScreen> {

  @override
  void initState() {
    super.initState();   
    tester();
    //check validity with firebase
    //if alright proceed
    //else pop up payment screen
  }
  
void tester()async{
      print("Internet Status is ${await checkInternetStatus()}");
      await deviceId();
	await authenticate();
      Navigator.pushNamed(context, services_ui.id);
}

Future<void> authenticate() async{
  Firestore _store=Firestore.instance;
  //check if id already exists
  final snapshot =await Firestore.instance.collection('Ids').where('sm0301',isEqualTo:true).limit(1).getDocuments();
  final length = snapshot.documents.length;//if length==1 exists
  print("length is  $length");
  _store.collection("Ids").document("list").setData({
    deviceName:true,
    deviceName+"stamp":DateTime.now().millisecondsSinceEpoch,
  },
  merge: true
  );
  //Todo
  // _store.collection('Ids').document('list');
  // if exists: 
  // check validity
  // else
  // make an entry
}

  Future<void> deviceId()async{
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if(Platform.isAndroid){
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      String deviceId=androidInfo.fingerprint;
      print('device id is $deviceId');
    }
    else if(Platform.isIOS){
      IosDeviceInfo iosInfo= await deviceInfo.iosInfo;
      String deviceId = iosInfo.identifierForVendor.toString();//TODO
    }
    else{
      //TODO Invalid platform
    }
  }

  Future<bool> checkInternetStatus() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      if (await DataConnectionChecker().hasConnection) {
        return true;
      } else {
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      if (await DataConnectionChecker().hasConnection) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(        
        title:Text(
          'M.E.N',
          style: TextStyle(
            fontWeight:FontWeight.w400,
            fontStyle: FontStyle.italic,
          ),
          ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children:<Widget>[

        ],
      ),
    );
  }
}