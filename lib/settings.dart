import 'package:flutter/material.dart';
import 'Custom_Icons.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'main.dart';


class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}



class _SettingsPageState extends State<SettingsPage> {
  int currentPageIndex = 2;
  bool _isHomePage = false;

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      backgroundColor: const Color.fromARGB(255, 235, 244, 232),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(1),
              child: Card(
                color: const Color.fromARGB(255, 231, 241, 207),
                child: ListTile(
                  title: Text(
                    'Configurer les paramètres de l\'application',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 16,
                      fontFamily: 'Arial',
                    ),
                  ),
                  subtitle: Text(
                    'Personnalisez votre expérience utilisateur',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 14,
                      fontFamily: 'Arial',
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(1),
              child: Card(
                color: const Color.fromARGB(255, 231, 241, 207),
                child: ListTile(
                  title: Text(
                    'Params 2',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 16,
                      fontFamily: 'Arial',
                    ),
                  ),
                  subtitle: Text(
                    'Work in progress',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 14,
                      fontFamily: 'Arial',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
            if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            } else if (index == 0) {
              Navigator.pop(context);
            }
          });
        },
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            icon: const Icon(Icons.house_sharp),
            label: "Acceuil",
          ),
          NavigationDestination(
            icon: Icon(MyFlutterApp.music),
            label: "Liste des albums",
          ),
          NavigationDestination(

            icon: Icon(MyFlutterApp.cog),
            label: "Paramètres",
          ),
        ],
      ),
    );
  }
}