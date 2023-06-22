import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/word_card.dart';

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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var favorites = List<WordPair>.empty(growable: true);

  void generateNewRandomWord() {
    current = WordPair.random();
    notifyListeners();
  }

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  bool isFavorite() => favorites.contains(current);
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    return Scaffold(
      appBar: AppBar(
        title: Text('Random Word Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WordCard(pair: pair),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                appState.generateNewRandomWord();
              },
              child: Text('Generate word'),
            ),
            IconButton(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(
                    appState.isFavorite()
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: appState.isFavorite() ? Colors.red : null))
          ],
        ),
      ),
    );
  }
}
