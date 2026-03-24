import 'package:flutter/material.dart';

import '../widgets/countdown_timer.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  static const String routeName = '/timer';

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int _minutes = 10;
  bool _showFinished = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Timer')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          Text(
            'Coal check',
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 6.0),
          Text(
            'Set a countdown for resting meat, warming rolls, or '
            'keeping an eye on the grid.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.70),
            ),
          ),
          const SizedBox(height: 16.0),
          CountdownTimer(
            duration: Duration(minutes: _minutes),
            onFinished: () {
              if (!mounted) {
                return;
              }
              setState(() {
                _showFinished = true;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Time! Lekker braai.')),
              );
            },
          ),
          const SizedBox(height: 16.0),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Minutes',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Slider(
                          min: 1,
                          max: 60,
                          divisions: 59,
                          value: _minutes.toDouble(),
                          label: '$_minutes',
                          onChanged: (double value) {
                            setState(() {
                              _minutes = value.round();
                              _showFinished = false;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      SizedBox(
                        width: 52.0,
                        child: Text(
                          '$_minutes',
                          textAlign: TextAlign.end,
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                  if (_showFinished) ...<Widget>[
                    const SizedBox(height: 8.0),
                    Text(
                      'Done. Flip, rest, or serve.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.secondary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

