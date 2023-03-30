import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var favorites = appState.favorites;

    if (favorites.isEmpty){
      return Center(
        child: Text("No favorites yet"),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text("You have ${favorites.length} favorite${favorites.length > 1 ? "s:" : ":"}"),
        for(var favorite in favorites)
          ListTile(
            title: Text(favorite.asLowerCase),
            leading: Icon(Icons.favorite, color: Theme.of(context).colorScheme.secondary),
            onTap: () {
              appState.removeFavorite(favorite);
            },
          )
      ],
    );
  }
}