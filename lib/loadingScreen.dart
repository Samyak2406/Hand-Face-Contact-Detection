import 'package:flutter/material.dart';


class loadingScreen extends StatefulWidget {
  static const id="loadingScreen";
  @override
  _loadingScreenState createState() => _loadingScreenState();
}

class _loadingScreenState extends State<loadingScreen> {

  @override
  void initState() {
    super.initState();
    //check internet connectivity
    //allow access to camera
    //get device id
    //check validity with firebase
    //if alright proceed
    //else pop up payment screen
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