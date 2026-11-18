import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/announcements_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/favorites_provider.dart';
import 'screens/home_shell.dart';
import 'screens/login_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const SchoolBoardApp());
}

class SchoolBoardApp extends StatelessWidget {
  const SchoolBoardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AnnouncementsProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: MaterialApp(
        title: 'School Board',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: Consumer<AuthProvider>(
          builder: (_, auth, _) =>
              auth.isLoggedIn ? const HomeShell() : const LoginScreen(),
        ),
      ),
    );
  }
}