import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/pokemon/pokemon.dart';

class PokemonPage extends StatefulWidget {
  const PokemonPage({Key? key}) : super(key: key);

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  PokeHub? pokeHub;
  String url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  @override
  void initState() {
    super.initState();
    // print('object');
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Pokemon')),
        backgroundColor: Colors.cyan,
        body: pokeHub == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GridView.count(
                crossAxisCount: 2,
                children: pokeHub!.pokemon!
                    .map(
                      (poke) => Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height * 0.4,
                              width: MediaQuery.of(context).size.width * 0.2,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(poke.img!))),
                            ),
                            Text(
                              poke.name!,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ));
  }

  void fetchData() async {
    var res = await http.get(Uri.parse(url));
    var decodedJson = jsonDecode(res.body);
    pokeHub = PokeHub.fromJson(decodedJson);
    debugPrint(pokeHub.toString());
    setState(() {});
  }
}
