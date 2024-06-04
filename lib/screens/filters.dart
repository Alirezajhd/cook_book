import 'package:flutter/material.dart';
import 'package:flutter_proj5/provider/filters_provider.dart'; // Importing the filters provider.
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Importing Riverpod for state management.

class FiltersScreen extends ConsumerWidget {
  // Constructor for FiltersScreen.
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watching the current state of filters using Riverpod.
    final activeFilters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'), // AppBar title.
      ),
      body: Column(
        // Column widget to arrange filter options vertically.
        children: [
          // Each SwitchListTile represents a filter option.
          // Gluten-free filter switch.
          SwitchListTile(
            value: activeFilters[Filter.glutenFree]!, // Current state of the Gluten-free filter.
            onChanged: (isChanged) {
              // Update the filter state when switched.
              ref.read(filtersProvider.notifier).setFilter(Filter.glutenFree, isChanged);
            },
            title: Text(
              'Gluten-free',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: const Text('Only include Gluten-free meals.'),
            activeColor: Theme.of(context).colorScheme.tertiary, // Color when the switch is active.
            contentPadding: const EdgeInsets.only(left: 34, right: 22), // Padding inside the ListTile.
          ),
          // Repeating the same structure for other dietary filters.
          // Lactose-free filter switch.
          SwitchListTile(
            value: activeFilters[Filter.lactoseFree]!,
            onChanged: (isChanged) {
              ref.read(filtersProvider.notifier).setFilter(Filter.lactoseFree, isChanged);
            },
            title: Text(
              'Lactose-free',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'Only include Lactose-free meals.',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: activeFilters[Filter.vegetarian]!,
            onChanged: (isChanged) {
              ref.read(filtersProvider.notifier).setFilter(Filter.vegetarian, isChanged);
            },
            title: Text(
              'Vegeterian',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'Only include Vegeterian meals.',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: activeFilters[Filter.vegan]!,
            onChanged: (isChanged) {
              ref.read(filtersProvider.notifier).setFilter(Filter.vegan, isChanged);
            },
            title: Text(
              'Vegan',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'Only include Vegan meals.',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
        ],
      ),
    );
  }
}
