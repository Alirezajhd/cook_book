import 'package:flutter/material.dart';
import 'package:flutter_proj5/models/meal.dart';
import 'package:flutter_proj5/widgets/meal_item_train.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  // Constructor for MealItem widget with required parameters.
  const MealItem({super.key, required this.meal, required this.onSlectedMeal});

  // Callback function to handle meal selection.
  final void Function(BuildContext context, Meal meal) onSlectedMeal;
  // Meal object containing details about the meal.
  final Meal meal;

  // Getter to format the complexity text.
  String get ComplexityMeal {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  // Getter to format the affordability text.
  String get Affordabilitymeal {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    // Building the widget.
    return Card(
      // Margin around the card.
      margin: const EdgeInsets.all(8),
      // Shape of the card.
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(8)),
      // Clip behavior for the card.
      clipBehavior: Clip.hardEdge, 
      // Elevation for 3D effect.
      elevation: 2,
      // InkWell widget to handle tap.
      child: InkWell(
        onTap: () {
          onSlectedMeal(context, meal);
        },
        child: Stack(
          // Stack to overlay widgets on top of each other.
          children: [
            // Hero widget for animation.
            Hero(
              tag: meal.id,
              child: FadeInImage(
                // Placeholder for image loading.
                placeholder: MemoryImage(kTransparentImage),
                // Network image of the meal.
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            // Positioned widget to position its child.
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                // Background color of the container.
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  // Column widget for vertical alignment.
                  children: [
                    // Text widget for meal title.
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    // Row widget for horizontal alignment.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Custom widget for displaying meal duration.
                        MealItemTrain(
                            icon: Icons.schedule,
                            label: '${meal.duration} min'),
                        const SizedBox(
                          width: 12,
                        ),
                        // Custom widget for displaying complexity.
                        MealItemTrain(icon: Icons.work, label: ComplexityMeal),
                        const SizedBox(
                          width: 12,
                        ),
                        // Custom widget for displaying affordability.
                        MealItemTrain(
                            icon: Icons.attach_money, label: Affordabilitymeal),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
