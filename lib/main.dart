import 'package:flutter/material.dart';
import 'Custom_Icons.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'settings.dart';
import 'liste_album.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final lightThemeStr = await rootBundle.loadString('assets/appainter_theme_light.json');
  final darkThemeStr = await rootBundle.loadString('assets/appainter_theme_night.json');

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
  bool _isHomePage = true;

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
          IconButton(
            icon: Icon(Icons.lightbulb, color: Colors.white),
          onPressed:((){
            themeController.toggleTheme();
          }),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Card(
              color: const Color.fromARGB(255, 100, 170, 102),
              child: Row(
                children: <Widget>[
                  Image(image: AssetImage('assets/img/imgAccueil/vinyltransp.webp'), height: 100,width: 100),
                    Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Bienvenue sur l\'application\n',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          TextSpan(
                            text: 'de gestion des albums',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ),
            Padding(
              padding: EdgeInsets.all(1),
              child: Card(
                color: const Color.fromARGB(255, 255, 255, 255),
                child: ListTile(
                  title: Text(
                    'News',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 16,
                      fontFamily: 'Arial',
                    ),
                  ),
                  subtitle: Text(
                    'Dernières actualités',
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
                color: const Color.fromARGB(255, 255, 255, 255),
                child: ListTile(
                  title: Text(
                    'Version 1 en cours de développement',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 16,
                      fontFamily: 'Arial',
                    ),
                  ),
                  subtitle: Text(
                    'Wait and see',
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
      
      floatingActionButton: _isHomePage ? null : FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
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
            }
            else if (index == 1) {
              
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListeAlbum()),
              );
            }
            else if (index == 0) {
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


