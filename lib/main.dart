import 'package:flutter/material.dart';
import 'Custom_Icons.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart';
import 'dart:convert';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final lightThemeStr = await rootBundle.loadString('assets/ThemeLight.json');
  final darkThemeStr = await rootBundle.loadString('assets/ThemeDark.json');

  final lightThemeJson = jsonDecode(lightThemeStr);
  final darkThemeJson = jsonDecode(darkThemeStr);

  final lightTheme = ThemeDecoder.decodeThemeData(lightThemeJson)!;
  final darkTheme = ThemeDecoder.decodeThemeData(darkThemeJson)!;

  runApp(MyApp(lightTheme: lightTheme, darkTheme: darkTheme));
}

class MyApp extends StatelessWidget {
  final ThemeData lightTheme;
  final ThemeData darkTheme;

  const MyApp({Key? key, required this.lightTheme, required this.darkTheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeController,
      builder: (context, themeMode, _) {
        return MaterialApp(
          title: 'Gestion des albums',
          debugShowMaterialGrid: false,
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          home: const MyHomePage(title: 'Gestion des albums'),
        );
      },
    );
  }
}

class ThemeController extends ValueNotifier<ThemeMode> {
  ThemeController() : super(ThemeMode.light);

  void toggleTheme() {
    value = value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    
  }
}

final themeController = ThemeController();


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
