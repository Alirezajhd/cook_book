import 'package:flutter/material.dart';
import 'package:flutter_proj5/models/category.dart'; // Importing necessary packages and models.

class CategoryGridItem extends StatelessWidget {
  // A stateless widget named CategoryGridItem. It doesn't hold any state of its own.

  // Constructor for this widget. It requires a Category object and an onSelected function.
  const CategoryGridItem({super.key, required this.category, required this.onSelected});

  // A function that will be called when this widget is tapped.
  final void Function() onSelected;
  // The Category object that holds data for this widget.
  final Category category;

  @override
  Widget build(BuildContext context) {
    // The build method, where the UI of the widget is defined.
    return InkWell(
      // InkWell is a widget that responds to touch actions.
      onTap: onSelected, // Specifies the function to call on a tap event.
      splashColor: Theme.of(context).primaryColor, // The color of the ripple effect on tap.
      borderRadius: BorderRadius.circular(16), // The radius of the border corners.
      child: Container(
        // Container widget to hold the content.
        padding: const EdgeInsets.all(16), // Padding inside the container.
        decoration: BoxDecoration(
          // Decoration for the container.
          borderRadius: BorderRadius.circular(16), // Border radius for the container.
          gradient: LinearGradient(
            // A linear gradient for the background color.
            colors: [
              // Gradient colors are taken from the category's color with different opacities.
              category.color.withOpacity(0.55),
              category.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft, // Gradient starts from top left...
            end: Alignment.bottomRight, // ...and ends at bottom right.
          ),
        ),
        child: Text(
          // Text widget to display the category's title.
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground, // Styling the text.
              ),
        ),
      ),
    );
  }
}
