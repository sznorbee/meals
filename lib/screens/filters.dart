import 'package:flutter/material.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegan,
  vegetarian,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _isGlutenFree = false;
  bool _isLactoseFree = false;
  bool _isVegan = false;
  bool _isVegetarian = false;

  @override
  void initState() {
    super.initState();
    _isGlutenFree = widget.currentFilters[Filter.glutenFree]!;
    _isLactoseFree = widget.currentFilters[Filter.lactoseFree]!;
    _isVegan = widget.currentFilters[Filter.vegan]!;
    _isVegetarian = widget.currentFilters[Filter.vegetarian]!;
  }

  void _setGlutenFree(bool value) {
    setState(() {
      _isGlutenFree = value;
    });
  }

  void _setLactoseFree(bool value) {
    setState(() {
      _isLactoseFree = value;
    });
  }

  void _setVegan(bool value) {
    setState(() {
      _isVegan = value;
    });
  }

  void _setVegetarian(bool value) {
    setState(() {
      _isVegetarian = value;
    });
  }

  SwitchListTile _buildSwitchListTile(
    String title,
    String subtitle,
    bool value,
    void Function(bool) onChanged,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.save),
        //     onPressed: () {
        //       final selectedFilters = {
        //         'gluten': _isGlutenFree,
        //         'lactose': _isLactoseFree,
        //         'vegan': _isVegan,
        //         'vegetarian': _isVegetarian,
        //       };
        //       Navigator.of(context).pop(selectedFilters);
        //     },
        //   ),
        // ],
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) return;
          Navigator.of(context).pop({
            Filter.glutenFree: _isGlutenFree,
            Filter.lactoseFree: _isLactoseFree,
            Filter.vegan: _isVegan,
            Filter.vegetarian: _isVegetarian,
          });
        },
        child: Column(
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
                  _buildSwitchListTile(
                    'Gluten-free',
                    'Only include gluten-free meals',
                    _isGlutenFree,
                    _setGlutenFree,
                  ),
                  _buildSwitchListTile(
                    'Lactose-free',
                    'Only include lactose-free meals',
                    _isLactoseFree,
                    _setLactoseFree,
                  ),
                  _buildSwitchListTile(
                    'Vegan',
                    'Only include vegan meals',
                    _isVegan,
                    _setVegan,
                  ),
                  _buildSwitchListTile(
                    'Vegetarian',
                    'Only include vegetarian meals',
                    _isVegetarian,
                    _setVegetarian,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
