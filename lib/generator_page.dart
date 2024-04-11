import 'package:english_words/english_words.dart';
import 'package:first_app/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite_rounded;
    } else {
      icon = Icons.favorite_border_rounded;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: HistoryListView(),
          ),
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(onPressed: () => appState.toggleFavorite(pair), icon: Icon(icon), label: Text("Like"),),
              SizedBox(width: 10,),
              ElevatedButton(onPressed: () => appState.getNext(), child: Text("Next")),
            ],
          ),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: AnimatedSize(
          duration: Duration(milliseconds: 50),
          child: Text(
            pair.asLowerCase,
            style: style,
            semanticsLabel: "${pair.first} ${pair.second}",
          ),
        ),
      ),
    );
  }
}

class HistoryListView extends StatefulWidget {
  const HistoryListView({super.key});

  @override
  State<StatefulWidget> createState() => _HistoryListViewState();
}

class _HistoryListViewState extends State<HistoryListView> {
  final _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    appState.historyListKey = _key;

    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          colors: <Color> [Colors.transparent, Colors.black],
          stops: [0.07, 0.5],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstIn,
      child: AnimatedList(
        key: _key,
        padding: EdgeInsets.only(top: 100),
        initialItemCount: appState.history.length,
        reverse: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index, animation) {
          var pair = appState.history[index];
          return SizeTransition(
            sizeFactor: animation,
            child: Center(
              child: TextButton.icon(
                onPressed: () => appState.toggleFavorite(pair),
                icon: appState.favorites.contains(pair) ? Icon(Icons.favorite_rounded) : SizedBox.shrink(),
                label: Text(
                  pair.asLowerCase,
                  semanticsLabel: "${pair.first} ${pair.second}",
                ),
              ),
            ),
          );
        }
        ),
    );
  }
}