import 'package:english_words/english_words.dart';
import 'package:first_app/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    TextStyle? textStyleTitle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.bold
    );
    TextStyle? textStyleWords = Theme.of(context).textTheme.bodyMedium;

    IconData typeOfIcon(WordPair pair) {
      if (appState.favorites.contains(pair)) {
        return Icons.favorite;
      } else {
        return Icons.favorite_border;
      }
    }

    if (appState.favorites.isEmpty) {
      return Center(
          child: Text('No favorites yet.',
            style: textStyleTitle
          )
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0,),
            child: Text('You have ''${appState.favorites.length} favorites:',
              style: textStyleTitle,),
          ),
          Expanded(
            child: GridView.extent(
              childAspectRatio: 5,
              maxCrossAxisExtent: 300,
              children:
              appState.favorites.map(
                      (pair) =>
                      Row(
                        children: [
                          SizedBox(width: 20,),
                          Text(pair.asLowerCase, style: textStyleWords),
                          SizedBox(width: 10,),
                          IconButton(
                              onPressed: () => appState.toggleFavorite(pair),
                              icon: Icon(typeOfIcon(pair)))
                        ],
                      )
              ).toList(),
            ),
          )
        ],
      );
    }
  }
}