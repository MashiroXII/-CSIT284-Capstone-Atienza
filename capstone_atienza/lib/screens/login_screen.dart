import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../theme/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final ok = context.read<AuthProvider>().login(_controller.text);
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your student ID')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Icon(Icons.campaign_outlined,
                    size: 40, color: AppColors.navy),
              ),
              const SizedBox(height: 24),
              Text(
                'School Announcements,\nAll in One Place',
                style: textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your student ID to see the latest news from school.',
                style: textTheme.bodyLarge?.copyWith(color: AppColors.muted),
              ),
              const SizedBox(height: 28),
              TextField(
                controller: _controller,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _submit(),
                decoration: const InputDecoration(
                  hintText: 'Student ID',
                  prefixIcon: Icon(Icons.badge_outlined),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tip: type "admin" to unlock the post form.',
                style: textTheme.bodySmall?.copyWith(color: AppColors.muted),
              ),
              const Spacer(),
              FilledButton(onPressed: _submit, child: const Text('Continue')),
            ],
          ),
        ),
      ),
    );
  }
}
