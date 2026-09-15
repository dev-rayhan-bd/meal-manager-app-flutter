import 'package:flutter/material.dart';
import 'app/config/app_router.dart';
import 'app/config/app_theme.dart';
import 'app/constants/app_strings.dart';
import 'core/providers/app_state_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MessManagerApp());
}

/// Root Application Widget
class MessManagerApp extends StatelessWidget {
  const MessManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppState.instance,
      builder: (context, _) {
        return MaterialApp(
          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: AppState.instance.themeMode,
          initialRoute: AppRouter.initialRoute,
          onGenerateRoute: AppRouter.generateRoute,
        );
      },
    );
  }
}
