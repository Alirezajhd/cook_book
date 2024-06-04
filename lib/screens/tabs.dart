import 'package:flutter/material.dart';
import 'package:flutter_proj5/screens/categories.dart';
import 'package:flutter_proj5/screens/filters.dart';
import 'package:flutter_proj5/screens/meals.dart';
import 'package:flutter_proj5/widgets/main_drawer.dart';

import '../provider/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_proj5/provider/favorit_providers.dart';

// A map of initial filter settings (gluten-free, lactose-free, vegetarian, vegan).
const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

// TabsScreen is a ConsumerStatefulWidget, which is a part of the Riverpod package.
// It allows the widget to listen to changes in provided states.
class TabsScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenstaee();
  }
}

// The state class for TabsScreen.
class _TabsScreenstaee extends ConsumerState<TabsScreen> {
  // Index to keep track of the selected page/tab.
  int _selectedPageIndex = 0;

  // Function to handle screen selection from the drawer.
  void _selctedScreen(String identifier) async {
    Navigator.of(context).pop(); // Close the drawer.
    if (identifier == 'Filters') {
      // Navigate to the FiltersScreen if 'Filters' is selected.
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  // Function to update the selected page/tab index.
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Watching the filteredMealsProvider state using Riverpod.
    final availabeMeals = ref.watch(filteredMealsProvider);

    // Determining the active screen based on the selected page/tab index.
    Widget activeScreen = CategoryScreen(
      availableMeals: availabeMeals,
    );
    var activeScreenTitle = 'Categories';
    if (_selectedPageIndex == 1) {
      // If the Favorites tab is selected.
      final favoritMeals = ref.watch(favoriteMealsProvider);
      activeScreen = MealsScreen(
        meals: favoritMeals,
      );
      activeScreenTitle = 'Favorites';
    }

    return Scaffold(
      drawer: MainDrawer(onSelectScreen: _selctedScreen), // Drawer for navigation.
      appBar: AppBar(
        title: Text(activeScreenTitle), // Title of the current screen.
      ),
      body: activeScreen, // Display the active screen.
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
        onTap: _selectPage, // Function to handle tab selection.
        currentIndex: _selectedPageIndex, // Current selected index for the BottomNavigationBar.
      ),
    );
  }
}
