// Importing necessary packages and the Meal model.
import 'package:flutter_proj5/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// StateNotifier class for managing a list of favorite meals.
class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  // Constructor initializes the favorite meals list as empty.
  FavoriteMealsNotifier() : super([]);

  // Method to toggle the favorite status of a meal.
  bool toggleMealFavoriteStatus(Meal meal) {
    // Checking if the meal is already in the favorites list.
    final mealIsFavorite = state.contains(meal);

    // If the meal is already a favorite, remove it from the list.
    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      // If the meal is not a favorite, add it to the list.
      state = [...state, meal];
      return true;
    }
  }
}

// Provider for the FavoriteMealsNotifier.
final favoriteMealsProvider = //StateNotifierProvider is a type of provider in the Riverpod package designed for state management.
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
