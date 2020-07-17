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
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            color: Colors.redAccent,
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
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                color: Colors.red,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.blue,
                              ),
                            ),
                          ],
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
