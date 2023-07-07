import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/temperature.dart';
import 'widget/navigator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage2 extends StatefulWidget {
  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  final List<Temperature> temps = [];

  @override
  void initState() {
    super.initState();
    getTeams();
  }

  // get teams
  Future getTeams() async {
    var response = await http.get(Uri.https('estacao7c.onrender.com', 'temp'));
    var jsonData = jsonDecode(response.body);
    List<dynamic> data = jsonData as List<dynamic>;

    for (var eachTemp in data) {
      final temp = Temperature(
        id: eachTemp['id'],
        temperature: eachTemp['temperature'],
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
        title: Text('Temperatura'),
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
                    LineSeries<Temperature, String>(
                      dataSource: temps,
                      xValueMapper: (Temperature umid1, _) => umid1.dateTime,
                      yValueMapper: (Temperature umid1, _) => umid1.temperature,
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
