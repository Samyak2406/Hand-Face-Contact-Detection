import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';

class weeklyReport extends StatefulWidget {
  static const id = "weeklyReport";

  @override
  _weeklyReportState createState() => _weeklyReportState();
}

class _weeklyReportState extends State<weeklyReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints(
          minHeight: 500,
          minWidth: 400,
        ),
        color: Colors.white,
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height*3/4,
              width: double.infinity,
              child: BarChart(
                [
                  Series(
                    domainFn: (chartData, _) => chartData.day,
                    measureFn: (chartData, _) => chartData.times,
                    data: [
                      chartData("1", 7),
                      chartData("2", 50),
                      chartData("3", 50),
                      chartData("4", 50),
                      chartData("5", 50),
                      chartData("6", 333),
                      chartData("7", 50),
                    ],
                    id: "chart",
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width/4,
              child: Center(
                child: Text(
                  'Report'
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class chartData {
  String day;
  int times;
  chartData(this.day, this.times);
}
