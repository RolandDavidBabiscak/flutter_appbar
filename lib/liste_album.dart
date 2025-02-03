import 'package:flutter/material.dart';
import 'Custom_Icons.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'main.dart';


class ListeAlbum extends StatefulWidget {
  @override
  _ListeAlbumState createState() => _ListeAlbumState();
}



class _ListeAlbumState extends State<ListeAlbum> {
  int currentPageIndex = 1;
  bool _isHomePage = false;

  final List<Map<String, String>> albums = [
    {
      "nomAlbum": "Metallica",
      "description": "L'album marque une évolution importante dans le style du groupe. Les tempos sont plus lents, les morceaux plus courts et leurs structures beaucoup plus simples, aspirant ainsi à du simple rock. C'est principalement un album de heavy metal, et il n'y a plus beaucoup de traces de thrash metal.",
      "nomGroupe": "Metallica",
      "image": "Metallica.jpg"
    },
    {
      "nomAlbum": "Hardwired... to Self-Destruct",
      "description": "Hardwired... to Self-Destruct est le dixième album studio du groupe de thrash metal américain Metallica, sorti le 18 novembre 2016. Il s'agit du premier album studio du groupe en huit ans, depuis Death Magnetic.",
      "nomGroupe": "Metallica",
      "image": "Hardwired.jpg"
    },
    {
      "nomAlbum": "Master of Puppets",
      "description": "Master of Puppets est le troisième album studio du groupe de thrash metal américain Metallica. Il est sorti le 3 mars 1986 chez Elektra Records. L'album a été enregistré entre septembre et décembre 1985 aux Sweet Silence Studios de Copenhague, au Danemark.",
      "nomGroupe": "Metallica",
      "image": "MasterOfPuppets.jpg"
    },
    {
      "nomAlbum": "Ride the Lightning",
      "description": "Ride the Lightning est le deuxième album studio du groupe de thrash metal américain Metallica. Il est sorti le 27 juillet 1984 chez Megaforce Records. L'album a été enregistré en seulement deux semaines aux studios Sweet Silence de Copenhague, au Danemark.",
      "nomGroupe": "Metallica",
      "image": "RideTheLightning.jpg"
    },
    {
      "nomAlbum": "Kill 'Em All",
      "description": "Kill 'Em All est le premier album studio du groupe de thrash metal américain Metallica. Il est sorti le 25 juillet 1983 chez Megaforce Records. L'album a été enregistré en seulement deux semaines aux studios Music America de Rochester, dans l'État de New York.",
      "nomGroupe": "Metallica",
      "image": "KillEmAll.jpg"
    },
    {
      "nomAlbum": "And Justice for All",
      "description": "And Justice for All est le quatrième album studio du groupe de thrash metal américain Metallica. Il est sorti le 25 août 1988 chez Elektra Records. L'album a été enregistré entre janvier et mai 1988 aux studios One on One de Los Angeles, en Californie.",
      "nomGroupe": "Metallica",
      "image": "AndJusticeForAll.jpg"
    }

    ];


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
                  Container(
                    color: const Color.fromARGB(255, 214, 168, 246),
                    alignment: Alignment.center,
                    child: ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
                      children: albums.map((album) {
                        return Album(
                          nomAlbum: album["nomAlbum"]!,
                          description: album["description"]!,
                          nomGroupe: album["nomGroupe"]!,
                          image: album["image"]!,
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
            ),

      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListeAlbum()),
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
class Album extends StatelessWidget {
    Album({Key? key, this.nomAlbum, this.description, this.nomGroupe, this.image}) 
      : super(key: key); 
   final String? nomAlbum; 
   final String? description; 
   final String? nomGroupe; 
   final String? image; 

   Widget build(BuildContext context) {
      return Container(
         padding: EdgeInsets.all(2), height: 120,  child: Card( 
            child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly, children:    <Widget>[
                  Image.asset("img/" +image!), Expanded(
                     child: Container(
                        padding: EdgeInsets.all(5), child: Column(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                              children: <Widget>[ 
                              
                              Text(this.nomAlbum!, style: TextStyle(fontWeight: 
                                 FontWeight.bold)), Text(this.description!), 
                              Text("Valeur: " + this.nomGroupe.toString()), 
                           ], 
                        )
                     )
                  )
               ]
            )
         )
      );
   }
}
