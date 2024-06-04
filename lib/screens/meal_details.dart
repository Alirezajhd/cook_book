import 'package:flutter/material.dart';
import 'package:flutter_proj5/main.dart'; // Importing main.dart for theme access
import 'package:flutter_proj5/models/meal.dart'; // Importing the Meal model
import 'package:flutter_proj5/provider/favorit_providers.dart'; // Importing the provider for favorites
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Importing Riverpod package for state management

class MealDeatailsScreen extends ConsumerWidget {
  // Constructor with a required Meal object.
  const MealDeatailsScreen({
    super.key,
    required this.meal,
  });

  final Meal meal; // The Meal object to be displayed.

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Accessing the favorite meals state using Riverpod
    final favoriteMeals = ref.watch(favoriteMealsProvider);

    // Checking if the current meal is a favorite.
    final isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor, // Using the theme's app bar background color.
        actions: [
          IconButton(
            onPressed: () {
              // Toggling the favorite status of the meal.
              final wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavoriteStatus(meal);

              // Showing a SnackBar message to indicate the change.
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      wasAdded ? 'Meal added as a favorite.' : 'Meal removed'),
                ),
              );
            },
            // AnimatedSwitcher for smooth transition of the favorite icon.
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween(begin: 0.8, end: 1.0).animate(animation),
                  child: child,
                );
              },
              // Displaying either a filled or an outlined star based on the favorite status.
              child: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                key: ValueKey(isFavorite),
              ),
            ),
          ),
        ],
        title: Text(
          meal.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      // Using SingleChildScrollView to allow scrolling through content.
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Displaying the meal image.
            Hero(
              tag: meal.id,
              child: Image.network(
                meal.imageUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            // Heading for ingredients.
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 14),
            // Listing all ingredients.
            for (final ingredient in meal.ingredients)
              Text(
                ingredient,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            const SizedBox(height: 16),
            // Heading for steps.
            Text(
              'Steps',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 14),
            // Listing all cooking steps.
            for (final step in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
