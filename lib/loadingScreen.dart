import 'package:flutter/material.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:connectivity/connectivity.dart';
import 'package:men/services_ui.dart';


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
    //get device id
    //check validity with firebase
    //if alright proceed
    //else pop up payment screen
  }
void tester()async{
      print("Internet Status is ${await checkInternetStatus()}");  
      Navigator.pushNamed(context, services_ui.id);
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