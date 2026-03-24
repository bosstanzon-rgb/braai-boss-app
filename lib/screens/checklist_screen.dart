import 'package:flutter/material.dart';

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});

  static const String routeName = '/checklist';

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  final Map<String, bool> _items = <String, bool>{
    'Tongs': false,
    'Charcoal / wood': false,
    'Firelighters': false,
    'Salt + pepper': false,
    'Braai spice': false,
    'Paper towels': false,
    'Cooler + ice': false,
    'Chakalaka / salads': false,
    'Cold drinks': false,
    'Music': false,
  };

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final int doneCount = _items.values.where((bool v) => v).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checklist'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Reset',
            onPressed: () {
              setState(() {
                for (final String key in _items.keys) {
                  _items[key] = false;
                }
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Reset. Let’s go again.')),
              );
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _items.isEmpty
          ? const _EmptyChecklist()
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: <Widget>[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Ready count',
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                        Text(
                          '$doneCount / ${_items.length}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                ..._items.entries.map(
                  (MapEntry<String, bool> entry) => Card(
                    child: CheckboxListTile(
                      value: entry.value,
                      onChanged: (bool? value) {
                        setState(() {
                          _items[entry.key] = value ?? false;
                        });
                      },
                      title: Text(entry.key),
                      subtitle: entry.key == 'Music'
                          ? const Text('Optional, but… lekker vibes.')
                          : null,
                      secondary: Icon(
                        entry.value ? Icons.check_circle : Icons.circle_outlined,
                        color: entry.value
                            ? theme.colorScheme.secondary
                            : theme.colorScheme.outline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class _EmptyChecklist extends StatelessWidget {
  const _EmptyChecklist();

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
              Icons.checklist_outlined,
              size: 48.0,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 12.0),
            Text(
              'No items yet',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 6.0),
            Text(
              'Add a few essentials and you’re sorted.',
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

