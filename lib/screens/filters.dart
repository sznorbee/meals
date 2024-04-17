import 'package:flutter/material.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text('Adjust your meal selection',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    )),
          ),
          Expanded(
            child: ListView(
              children: [
                SwitchListTile(
                  title: const Text('Gluten-free'),
                  subtitle: const Text('Only include gluten-free meals.'),
                  value: activeFilters[Filter.glutenFree]!,
                  onChanged: (newValue) {
                    ref
                        .read(filtersProvider.notifier)
                        .setFilter(Filter.glutenFree, newValue);
                  },
                ),
                SwitchListTile(
                  title: const Text('Lactose-free'),
                  subtitle: const Text('Only include lactose-free meals.'),
                  value: activeFilters[Filter.lactoseFree]!,
                  onChanged: (newValue) {
                    ref
                        .read(filtersProvider.notifier)
                        .setFilter(Filter.lactoseFree, newValue);
                  },
                ),
                SwitchListTile(
                  title: const Text('Vegetarian'),
                  subtitle: const Text('Only include vegetarian meals.'),
                  value: activeFilters[Filter.vegetarian]!,
                  onChanged: (newValue) {
                    ref
                        .read(filtersProvider.notifier)
                        .setFilter(Filter.vegetarian, newValue);
                  },
                ),
                SwitchListTile(
                  title: const Text('Vegan'),
                  subtitle: const Text('Only include vegan meals.'),
                  value: activeFilters[Filter.vegan]!,
                  onChanged: (newValue) {
                    ref
                        .read(filtersProvider.notifier)
                        .setFilter(Filter.vegan, newValue);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
