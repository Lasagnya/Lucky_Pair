import 'package:first_app/favorites_page.dart';
import 'package:first_app/generator_page.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
      case 1:
        page = FavoritesPage();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    var mainArea = ColoredBox(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 100),
        child: page,
      ),
    );


    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 550) {
          return Scaffold(
            bottomNavigationBar: NavigationBar(
              destinations: [
                NavigationDestination(selectedIcon: Icon(Icons.home_rounded), icon: Icon(Icons.home_outlined), label: "Home"),
                NavigationDestination(selectedIcon: Icon(Icons.favorite_rounded), icon: Icon(Icons.favorite_border_rounded), label: "Favorites",)
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) {
                setState(() => selectedIndex = value);
              },
            ),
            body: mainArea,
          );
        } else {
          return Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: constraints.maxWidth >= 700,
                  minWidth: 70,
                  minExtendedWidth: 160,
                  destinations: [
                    NavigationRailDestination(
                      selectedIcon: Icon(Icons.home_rounded),
                      icon: Icon(Icons.home_outlined),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      selectedIcon: Icon(Icons.favorite_rounded),
                      icon: Icon(Icons.favorite_border_rounded),
                      label: Text('Favorites'),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() => selectedIndex = value);
                  },
                ),
              ),
              Expanded(
                child: mainArea,
              ),
            ],
          );
        }
      }
    );
  }
}