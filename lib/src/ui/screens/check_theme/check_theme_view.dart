import 'package:flutter/material.dart';

class ThemePreviewView extends StatelessWidget {
  const ThemePreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Theme Preview')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Display large', style: theme.textTheme.displayLarge),
          Text('Headline small', style: theme.textTheme.headlineSmall),
          Text('Title medium', style: theme.textTheme.titleMedium),
          Text('Body medium text', style: theme.textTheme.bodyMedium),
          Text('Label small', style: theme.textTheme.labelSmall),

          const SizedBox(height: 24),

          FilledButton(
            onPressed: () {},
            child: const Text('Filled button'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Elevated button'),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () {},
            child: const Text('Outlined button'),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {},
            child: const Text('Text button'),
          ),

          const SizedBox(height: 24),

          TextField(
            decoration: const InputDecoration(
              labelText: 'Input label',
              hintText: 'Type something',
            ),
          ),

          const SizedBox(height: 24),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Card using your CardTheme',
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ),

          const SizedBox(height: 24),

          Wrap(
            spacing: 8,
            children: [
              Chip(label: Text('Primary')),
              Chip(
                label: Text('Secondary'),
                backgroundColor: colors.secondaryContainer,
              ),
            ],
          ),
        ],
      ),
    );
  }
}