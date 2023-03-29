import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'BigCard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var currentPair = WordPair.random();
  var currentPairList = <WordPair>[];
  var favorites = <WordPair>[];

  void getNext() {
    currentPairList.add(currentPair);
    currentPair = WordPair.random();
    notifyListeners();
  }

  void getPrevious() {
    currentPair = currentPairList[currentPairList.length-1];
    currentPairList.removeAt(currentPairList.length-1);
    notifyListeners();
  }

  void toggleFavorite() {
    if (favorites.contains(currentPair)) {
      favorites.remove(currentPair);
    } else {
      favorites.add(currentPair);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.currentPair;
    var pairList = appState.currentPairList;
    var favoriteList = appState.favorites;
    
    var disableButton = false;
    IconData icon;

    if (pairList.isEmpty){
      disableButton = true;
    }
    else{
      disableButton = false;
    }

    if (favoriteList.contains(pair)){
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigCard(pair: pair),
            SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  icon: Icon(icon),
                  label: Text("Like"),
                  onPressed: () {
                    appState.toggleFavorite();
                  },
                ),
                SizedBox(width: 20),
                FilledButton(
                  onPressed: () {
                    appState.getNext();
                  },
                  child: Text('Next'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: disableButton ? null : () => {
                    appState.getPrevious()
                  },
                  child: Text('Previous'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}