import 'package:flutter/material.dart';
import 'package:flutter_proj5/data/dummy_data.dart'; // Importing dummy data for categories.
import 'package:flutter_proj5/models/meal.dart'; // Importing the Meal model.
import 'package:flutter_proj5/screens/meals.dart'; // Importing the MealsScreen.
import 'package:flutter_proj5/widgets/category_grid_item.dart'; // Importing the CategoryGridItem widget.
import 'package:flutter_proj5/models/category.dart'; // Importing the Category model.

class CategoryScreen extends StatefulWidget {
  // Constructor with required availableMeals parameter.
  const CategoryScreen({super.key, required this.availableMeals});
  final List<Meal> availableMeals;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  // AnimationController for managing animations.
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    // Initializing the animation controller.
    _animationController = AnimationController(
      vsync: this, // Providing the TickerProvider for the animation.
      duration: const Duration(milliseconds: 300), // Animation duration.
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward(); // Start the animation.
  }

  @override
  void dispose() {
    // Dispose the animation controller when the widget is removed from the tree.
    _animationController.dispose();
    super.dispose();
  }

  // Function to handle category selection.
  void _selectedCategory(BuildContext context, Category category) {
    // Filtering meals based on the selected category.
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    // Navigating to the MealsScreen with the filtered meals.
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MealsScreen(
        title: category.title,
        meals: filteredMeals,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    // AnimatedBuilder widget to apply animations.
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        // GridView to display categories in a grid format.
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in the grid.
          crossAxisSpacing: 20, // Spacing between columns.
          mainAxisSpacing: 20, // Spacing between rows.
          childAspectRatio: 3 / 2, // Aspect ratio of each grid item.
        ),
        children: [
          // Creating a grid item for each category.
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelected: () {
                _selectedCategory(context, category);
              },
            ),
        ],
      ),
      builder: (context, child) => SlideTransition(
        // SlideTransition for the animation effect.
        position: Tween(
          begin: const Offset(0, 0.3), // Starting position of the slide.
          end: const Offset(0, 0), // Ending position of the slide.
        ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)),
        child: child,
      ),
    );
  }
}
