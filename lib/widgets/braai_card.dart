import 'package:flutter/material.dart';

class BraaiCard extends StatelessWidget {
  const BraaiCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.chips = const <String>[],
  });

  final String title;
  final String subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final List<String> chips;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16.0),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (leading != null) ...<Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 12.0, top: 2.0),
                  child: leading!,
                ),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            title,
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                        if (trailing != null) trailing!,
                      ],
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color:
                            theme.colorScheme.onSurface.withOpacity(0.70),
                      ),
                    ),
                    if (chips.isNotEmpty) ...<Widget>[
                      const SizedBox(height: 12.0),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: chips
                            .take(4)
                            .map(
                              (String label) => Chip(
                                label: Text(label),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                visualDensity: VisualDensity.compact,
                              ),
                            )
                            .toList(growable: false),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

