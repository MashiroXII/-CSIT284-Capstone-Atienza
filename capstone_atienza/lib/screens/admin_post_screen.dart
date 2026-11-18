import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/announcements_provider.dart';


class AdminPostScreen extends StatefulWidget {
  const AdminPostScreen({super.key});

  @override
  State<AdminPostScreen> createState() => _AdminPostScreenState();
}

class _AdminPostScreenState extends State<AdminPostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _body = TextEditingController();
  String _categoryId = 'general';
  bool _urgent = false;

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AnnouncementsProvider>().add(
          title: _title.text.trim(),
          body: _body.text.trim(),
          categoryId: _categoryId,
          isUrgent: _urgent,
        );
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Announcement posted')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = context.read<AnnouncementsProvider>().categories;

    return Scaffold(
      appBar: AppBar(title: const Text('New announcement')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _title,
              decoration: const InputDecoration(hintText: 'Title'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Enter a title' : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _categoryId,
              decoration: const InputDecoration(),
              items: [
                for (final c in categories)
                  DropdownMenuItem(value: c.id, child: Text(c.name)),
              ],
              onChanged: (v) => setState(() => _categoryId = v ?? _categoryId),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _body,
              maxLines: 8,
              decoration: const InputDecoration(hintText: 'Write the announcement...'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Enter a message' : null,
            ),
            const SizedBox(height: 8),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Mark as urgent'),
              value: _urgent,
              onChanged: (v) => setState(() => _urgent = v),
            ),
            const SizedBox(height: 16),
            FilledButton(onPressed: _submit, child: const Text('Post')),
          ],
        ),
      ),
    );
  }
}
