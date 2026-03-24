import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({
    super.key,
    required this.duration,
    this.onFinished,
  });

  final Duration duration;
  final VoidCallback? onFinished;

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Timer? _timer;
  late Duration _remaining;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _remaining = widget.duration;
  }

  @override
  void didUpdateWidget(covariant CountdownTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _stop();
      setState(() {
        _remaining = widget.duration;
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _start() {
    if (_isRunning) {
      return;
    }

    setState(() {
      _isRunning = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) {
        return;
      }

      if (_remaining.inSeconds <= 1) {
        _timer?.cancel();
        setState(() {
          _remaining = Duration.zero;
          _isRunning = false;
        });
        widget.onFinished?.call();
        return;
      }

      setState(() {
        _remaining -= const Duration(seconds: 1);
      });
    });
  }

  void _stop() {
    _timer?.cancel();
    _timer = null;
    if (!_isRunning) {
      return;
    }
    setState(() {
      _isRunning = false;
    });
  }

  void _reset() {
    _stop();
    setState(() {
      _remaining = widget.duration;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String mm = _remaining.inMinutes.toString().padLeft(2, '0');
    final String ss = (_remaining.inSeconds % 60).toString().padLeft(2, '0');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              '$mm:$ss',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontFeatures: const <FontFeature>[
                  FontFeature.tabularFigures(),
                ],
              ),
            ),
            const SizedBox(height: 12.0),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12.0,
              runSpacing: 12.0,
              children: <Widget>[
                FilledButton(
                  onPressed: _isRunning ? null : _start,
                  child: Text(_isRunning ? 'Running' : 'Start'),
                ),
                OutlinedButton(
                  onPressed: _isRunning ? _stop : null,
                  child: const Text('Stop'),
                ),
                TextButton(
                  onPressed: _reset,
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

