// Importing necessary packages and modules.
import 'package:flutter_proj5/provider/meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Enum defining different filter types for meals.
enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

// A notifier for managing the state of filters.
class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  // Constructor initializes the filter state with all filters set to false.
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  // Method to set multiple filters at once.
  void setFilters(Map<Filter, bool> filters) {
    state = filters;
  }

  // Method to set or update a single filter's state.
  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

// Provider for the FiltersNotifier.
final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());

// Provider to obtain the list of filtered meals based on active filters.
final filteredMealsProvider = Provider((ref) {
  // Watching for changes in the meals list and active filters.
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  
  // Filtering the meals based on active filters and returning the filtered list.
  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
