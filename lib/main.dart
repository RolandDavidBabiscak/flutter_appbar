import 'package:flutter/material.dart';
import 'Custom_Icons.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart';
import 'dart:convert';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeStr = await rootBundle.loadString('assets/ThemeAlbum.json');
  
  final themeJson = jsonDecode(themeStr);
  
  final theme = ThemeDecoder.decodeThemeData(themeJson);
  
  runApp(MyApp(theme : theme));
}

class MyApp extends StatelessWidget {
  final ThemeData? theme;
  
    const MyApp({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const MyHomePage(title: 'Gestion des albums'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int currentPageIndex = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: <Widget>[
          Icon(
            Icons.search_sharp,
            color: Colors.white,
          ),
          SizedBox(width: 10),
          Icon(
            Icons.lightbulb_sharp,
            color: Colors.white,
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
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
            selectedIcon: const Icon(Icons.bookmark),
            icon: const Icon(Icons.gamepad_sharp),
            label: "Parametre",
          ),
        ],
      ),
    );
  }
}
