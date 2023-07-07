import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/moisture.dart';
import 'widget/navigator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Umid extends StatefulWidget {
  @override
  _UmidState createState() => _UmidState();
}

class _UmidState extends State<Umid> {
  List<Moisture> temps = [];

  @override
  void initState() {
    super.initState();
    getTeams();
  }

  // get teams
  Future getTeams() async {
    var response = await http.get(Uri.https('estacao7c.onrender.com', 'umi'));
    var jsonData = jsonDecode(response.body);
    List<dynamic> data = jsonData as List<dynamic>;

    for (var eachTemp in data) {
      final temp = Moisture(
        id: eachTemp['id'],
        moisture: eachTemp['moisture'],
        dateTime: eachTemp['date_time'],
      );
      temps.add(temp);
    }

    print(temps.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(
        title: Text('Umidade'),
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: getTeams(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Container(
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  series: <ChartSeries>[
                    LineSeries<Moisture, String>(
                      dataSource: temps,
                      xValueMapper: (Moisture umid1, _) => umid1.dateTime,
                      yValueMapper: (Moisture umid1, _) => umid1.moisture,
                    )
                  ],
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
