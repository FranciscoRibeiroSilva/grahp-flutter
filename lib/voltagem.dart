import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/voltage.dart';
import 'widget/navigator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Voltagem extends StatefulWidget {
  @override
  _VoltagemState createState() => _VoltagemState();
}

class _VoltagemState extends State<Voltagem> {
  List<Voltage> temps = [];

  @override
  void initState() {
    super.initState();
    getTeams();
  }

  // get teams
  Future getTeams() async {
    var response =
        await http.get(Uri.https('estacao7c.onrender.com', 'platevolta'));
    var jsonData = jsonDecode(response.body);
    List<dynamic> data = jsonData as List<dynamic>;

    for (var eachTemp in data) {
      final temp = Voltage(
        id: eachTemp['id'],
        voltage: eachTemp['plate_voltage'],
        dateTime: eachTemp['date_time'],
      );
      temps.add(temp);
    }

    print(temps.length);
  }

  @override
  Widget build(BuildContext context) {
    getTeams();
    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(
        title: Text('Voltagem'),
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
                    LineSeries<Voltage, String>(
                      dataSource: temps,
                      xValueMapper: (Voltage umid1, _) => umid1.dateTime,
                      yValueMapper: (Voltage umid1, _) => umid1.voltage,
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
