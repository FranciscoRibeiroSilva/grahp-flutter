import 'package:flutter/material.dart';
import 'package:httpapp/home2.dart';
import 'package:httpapp/umid.dart';
import 'package:httpapp/smok.dart';
import 'package:httpapp/voltagem.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Estação'),
            accountEmail: Text('tempo@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://images.unsplash.com/photo-1517594422361-5eeb8ae275a9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: NetworkImage(
                  'https://climate.nasa.gov/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBakFuIiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--f5d8431b1e7ea75603df0503ed45c78d7b0efe3b/wildfire_768_60.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
              leading: Icon(Icons.thermostat),
              title: Text('Temperatura'),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomePage2()))),
          Divider(),
          ListTile(
              leading: Icon(Icons.cloud),
              title: Text('Umidade'),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Umid()))),
          Divider(),
          ListTile(
              leading: Icon(Icons.fireplace),
              title: Text('CO²'),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Smok()))),
          Divider(),
          ListTile(
              leading: Icon(Icons.energy_savings_leaf),
              title: Text('Voltage da placa'),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Voltagem()))),
        ],
      ),
    );
  }
}
