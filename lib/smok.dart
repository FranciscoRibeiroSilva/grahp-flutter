import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/smoke.dart';
import 'package:httpapp/widget/navigator.dart';

class Smok extends StatelessWidget {
  List<Smoke> temps = [];

  // get teams
  Future getTeams() async {
    var response = await http.get(Uri.https('estacao7c.onrender.com', 'smoke'));
    var jsonData = jsonDecode(response.body);
    List<dynamic> data = jsonData as List<dynamic>;

    for (var eachTemp in data) {
      final temp = Smoke(
        id: eachTemp['id'],
        smoke: eachTemp['smoke'],
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
        title: Text('CO²'),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: getTeams(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: temps.length,
                  padding: EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          title: Text(temps[index].smoke.toString()),
                          subtitle: Text(temps[index].dateTime),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
