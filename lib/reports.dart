import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class reports extends StatelessWidget {
  static const id = "reports";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: FittedBox(
                child: CircularPercentIndicator(
                  radius: MediaQuery.of(context).size.width * .75,
                  percent: .820,
                  animation: true,
                  animationDuration: 2000,
                  progressColor: Colors.green,
                  center: Text(
                    "85%",//TODO: Show percentage indicator
                    style: TextStyle(
                      fontSize: 40
                    ),
                    ),
                  lineWidth: 15,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Container(
                              height: double.infinity,
                              width: MediaQuery.of(context).size.width * 0.7,
                              color: Colors.redAccent,
                              child: Center(
                                child: FittedBox(
                                  child: Text(
                                    'Alert!', //TODO
                                    style: TextStyle(
                                      fontSize: 5000,
                                      fontWeight: FontWeight.w200,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: (){
                                    //TODO: Show me reports
                                  },
                                  child: Container(
                                    height: double.infinity,
                                    color: Colors.blue,
                                    child: Center(
                                      child: FractionallySizedBox(
                                        heightFactor: 0.5,
                                        widthFactor: 0.4,
                                        child: FittedBox(
                                          child: Text(
                                            'Reports',
                                            style: TextStyle(
                                              fontSize: 4000,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w200
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
