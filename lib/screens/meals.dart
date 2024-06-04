import 'package:flutter/material.dart';
import 'package:flutter_proj5/models/meal.dart';
import 'package:flutter_proj5/screens/meal_details.dart';
import 'package:flutter_proj5/widgets/meal_item.dart';

// Defining a stateless widget named MealsScreen.
class MealsScreen extends StatelessWidget {
  // Constructor with optional title and required meals list.
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });
  final String? title; // An optional title for the screen.
  final List<Meal> meals; // A required list of Meal objects.

  // Function to navigate to the MealDetailsScreen when a meal is selected.
  void selectedMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => MealDeatailsScreen(
        meal: meal,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    // Creating the main content widget, which is a ListView.
    Widget content = ListView.builder(
      itemCount: meals.length, // The number of items in the list.
      itemBuilder: (context, index) => MealItem(
        meal: meals[index],
        //in Flutter, context usually refers to the build context, 
        //which provides information about where the widget is within the widget tree. 
        onSlectedMeal: (context, meal) {
          selectedMeal(context, meal); // Function to handle meal selection.
        },
      ),
    );

    // If the meals list is empty, display a message.
    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh oh ... nothing here',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Try select a diffrent category!',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ],
        ),
      );
    }

    // If a title is provided, wrap the content in a Scaffold with an AppBar.
    if (title != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(title!), // Displaying the title in the AppBar.
        ),
        body: content, // The main content of the screen.
      );
    }

    // If no title is provided, just return the content.
    return content;
  }
}
