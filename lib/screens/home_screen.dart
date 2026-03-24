import 'package:flutter/material.dart';

import '../services/ad_service.dart';
import '../widgets/braai_card.dart';
import 'checklist_screen.dart';
import 'recipes_screen.dart';
import 'timer_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Braai Boss'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          Text(
            'Lekker braai!',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 6.0),
          Text(
            'Offline-first. No ads or purchases required to start.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: scheme.onSurface.withOpacity(0.70),
            ),
          ),
          const SizedBox(height: 16.0),
          BraaiCard(
            title: 'Recipes',
            subtitle: 'Boerie, chops, and braai broodjies.',
            leading: Icon(Icons.menu_book, color: scheme.primary),
            trailing: Icon(Icons.chevron_right, color: scheme.outline),
            onTap: () => Navigator.of(context).pushNamed(
              RecipesScreen.routeName,
            ),
          ),
          BraaiCard(
            title: 'Timer',
            subtitle: 'Set coals + cook times. Keep it sharp.',
            leading: Icon(Icons.timer, color: scheme.secondary),
            trailing: Icon(Icons.chevron_right, color: scheme.outline),
            onTap: () => Navigator.of(context).pushNamed(
              TimerScreen.routeName,
            ),
          ),
          BraaiCard(
            title: 'Checklist',
            subtitle: 'Tongs, charcoal, salt, and the vibes.',
            leading: Icon(Icons.checklist, color: scheme.tertiary),
            trailing: Icon(Icons.chevron_right, color: scheme.outline),
            onTap: () => Navigator.of(context).pushNamed(
              ChecklistScreen.routeName,
            ),
          ),
          const SizedBox(height: 16.0),
          _AdStatusCard(
            isInitialized: AdService.instance.isInitialized,
            lastError: AdService.instance.lastError,
          ),
        ],
      ),
    );
  }
}

class _AdStatusCard extends StatelessWidget {
  const _AdStatusCard({
    required this.isInitialized,
    required this.lastError,
  });

  final bool isInitialized;
  final String? lastError;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;

    final String statusText = isInitialized
        ? 'Ads ready (test mode recommended during dev).'
        : 'Ads not initialized yet.';

    final List<String> chips = <String>[
      isInitialized ? 'Initialized' : 'Not ready',
      if (lastError != null) 'Error',
    ];

    return BraaiCard(
      title: 'AdMob status',
      subtitle: lastError == null ? statusText : '$statusText\n$lastError',
      leading: Icon(Icons.campaign, color: scheme.primary),
      chips: chips,
      onTap: null,
    );
  }
}

