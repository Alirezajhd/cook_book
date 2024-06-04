import 'package:flutter/material.dart';

// MainDrawer is a stateless widget, meaning its properties can't change over time.
class MainDrawer extends StatelessWidget {
  // Constructor for this widget with a required callback function 'onSelectScreen'.
  const MainDrawer({super.key, required this.onSelectScreen});
  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    // The build method describes the part of the user interface this widget represents.
    return Drawer(
      // Drawer widget provides a sliding panel from the side of the screen.
      child: Column(
        // Column widget to arrange its children vertically.
        children: [
          // DrawerHeader provides a header for the Drawer.
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            // Decoration for the DrawerHeader with a linear gradient.
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  // Using the primary container color from the theme.
                  Theme.of(context).colorScheme.primaryContainer,
                  // Making the primary container color slightly transparent.
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              // Row widget to arrange its children horizontally.
              children: [
                // Icon widget for a fast food icon.
                Icon(
                  Icons.fastfood,
                  color: Theme.of(context).colorScheme.primary,
                  size: 48,
                ),
                const SizedBox(
                  width: 18,
                ),
                // Text widget for the title 'Cookin up'.
                Text(
                  'Cookin up',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                )
              ],
            ),
          ),
          // ListTile for navigation to 'Meal'.
          ListTile(
            leading: Icon(
              Icons.restaurant,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'Meal',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              onSelectScreen('Meal');
            },
          ),
          // ListTile for navigation to 'Filters'.
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'Filters',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              onSelectScreen('Filters');
            },
          ),
        ],
      ),
    );
  }
}
