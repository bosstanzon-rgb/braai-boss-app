import 'package:flutter/material.dart';

import '../data/fake_recipes.dart';
import '../models/braai_recipe.dart';
import '../widgets/braai_card.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  static const String routeName = '/recipes';

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  String _query = '';
  bool _useAfrikaans = false;

  @override
  Widget build(BuildContext context) {
    final List<BraaiRecipe> braaiRecipes = fakeBraaiRecipes;
    final String queryLower = _query.trim().toLowerCase();

    final List<BraaiRecipe> filteredRecipes = queryLower.isEmpty
        ? braaiRecipes
        : braaiRecipes
            .where((BraaiRecipe recipe) {
              final String name = _useAfrikaans
                  ? recipe.nameAf
                  : recipe.nameEn;
              final String desc = _useAfrikaans
                  ? recipe.descriptionAf
                  : recipe.descriptionEn;
              return name.toLowerCase().contains(queryLower) ||
                  desc.toLowerCase().contains(queryLower) ||
                  recipe.tags.any(
                    (String t) => t.toLowerCase().contains(queryLower),
                  );
            })
            .toList(growable: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(_useAfrikaans ? 'Resepte' : 'Recipes'),
        actions: <Widget>[
          IconButton(
            tooltip: _useAfrikaans ? 'English' : 'Afrikaans',
            onPressed: () {
              setState(() {
                _useAfrikaans = !_useAfrikaans;
              });
            },
            icon: const Icon(Icons.translate),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (String value) {
                setState(() {
                  _query = value;
                });
              },
              decoration: InputDecoration(
                labelText: _useAfrikaans ? 'Soek' : 'Search',
                hintText: _useAfrikaans
                    ? 'Boerie, kotelette...'
                    : 'Boerie, chops...',
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: Builder(
              builder: (BuildContext context) {
                if (filteredRecipes.isEmpty) {
                  return _EmptyState(
                    title: _useAfrikaans
                        ? 'Geen resepte gevind nie'
                        : 'No recipes found',
                    subtitle: _useAfrikaans
                        ? 'Probeer ’n ander soekterm.'
                        : 'Try a different search.',
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                  itemCount: filteredRecipes.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12.0),
                  itemBuilder: (BuildContext context, int index) {
                    final BraaiRecipe recipe = filteredRecipes[index];
                    final String title = _useAfrikaans
                        ? recipe.nameAf
                        : recipe.nameEn;
                    final String subtitle = _useAfrikaans
                        ? recipe.descriptionAf
                        : recipe.descriptionEn;

                    return BraaiCard(
                      title: title,
                      subtitle: subtitle,
                      chips: <String>[
                        '${recipe.minutes} min',
                        _heatLabel(recipe.heatLevel, _useAfrikaans),
                        ...recipe.tags,
                      ],
                      leading: _HeatIcon(heatLevel: recipe.heatLevel),
                      onTap: () => _showRecipeSheet(
                        context: context,
                        recipe: recipe,
                        useAfrikaans: _useAfrikaans,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _heatLabel(BraaiHeatLevel level, bool af) {
    switch (level) {
      case BraaiHeatLevel.low:
        return af ? 'Lae hitte' : 'Low heat';
      case BraaiHeatLevel.medium:
        return af ? 'Medium hitte' : 'Medium heat';
      case BraaiHeatLevel.high:
        return af ? 'Hoë hitte' : 'High heat';
    }
  }

  Future<void> _showRecipeSheet({
    required BuildContext context,
    required BraaiRecipe recipe,
    required bool useAfrikaans,
  }) async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        final ThemeData theme = Theme.of(context);
        final String title = useAfrikaans ? recipe.nameAf : recipe.nameEn;
        final String desc = useAfrikaans
            ? recipe.descriptionAf
            : recipe.descriptionEn;
        final List<String> tips = useAfrikaans ? recipe.tipsAf : recipe.tipsEn;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(title, style: theme.textTheme.headlineSmall),
                const SizedBox(height: 8.0),
                Text(desc),
                const SizedBox(height: 12.0),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: <Widget>[
                    Chip(label: Text('${recipe.minutes} min')),
                    Chip(
                      label: Text(_heatLabel(recipe.heatLevel, useAfrikaans)),
                    ),
                    ...recipe.tags.map((String t) => Chip(label: Text(t))),
                  ],
                ),
                const SizedBox(height: 12.0),
                Text(
                  useAfrikaans ? 'Wenke' : 'Tips',
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 8.0),
                if (tips.isEmpty)
                  Text(
                    useAfrikaans
                        ? 'Geen wenke vir nou nie.'
                        : 'No tips for now.',
                  )
                else
                  ...tips.map(
                    (String tip) => Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text('•  '),
                          Expanded(child: Text(tip)),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 8.0),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(useAfrikaans ? 'Reg so' : 'Done'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _HeatIcon extends StatelessWidget {
  const _HeatIcon({required this.heatLevel});

  final BraaiHeatLevel heatLevel;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final IconData icon;
    final Color color;

    switch (heatLevel) {
      case BraaiHeatLevel.low:
        icon = Icons.local_fire_department_outlined;
        color = scheme.secondary;
      case BraaiHeatLevel.medium:
        icon = Icons.local_fire_department;
        color = scheme.primary;
      case BraaiHeatLevel.high:
        icon = Icons.whatshot;
        color = scheme.error;
    }

    return Icon(icon, color: color);
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.search_off,
              size: 48.0,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 12.0),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 6.0),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

