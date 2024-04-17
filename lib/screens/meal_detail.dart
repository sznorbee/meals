import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favorites_provider.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(favoriteMealsProvider).contains(meal);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
              icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) => RotationTransition(
                      turns: Tween(begin: 0.7, end: 1.0).animate(animation),
                      child: child),
                  child: Icon(isFavorite ? Icons.star : Icons.star_border,
                      key: ValueKey(isFavorite))),
              color: isFavorite ? Colors.orange : null,
              onPressed: () {
                final wasAdded = ref
                    .read(favoriteMealsProvider.notifier)
                    .toggleMealFavoriteStatus(meal);

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      wasAdded
                          ? 'Added to Favorites'
                          : 'Removed from favorites',
                      textAlign: TextAlign.center),
                  duration: const Duration(seconds: 2),
                ));
              }),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Image.network(meal.imageUrl,
              fit: BoxFit.cover, height: 200, width: double.infinity),
          const SizedBox(height: 10),
          Text(
            'Ingredients',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          for (final ingredient in meal.ingredients)
            Text(ingredient,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    )),
          const SizedBox(height: 10),
          Text(
            'Steps',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          for (final step in meal.steps)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(step,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      )),
            ),
        ],
      ),
    );
  }
}
