import 'package:chat/core/services/notification/chat_notification_service.dart';
import 'package:chat/pages/auth_or_app_page.dart';
import 'package:chat/pages/notification_page.dart';
import 'package:chat/utils/app_create_route.dart';
import 'package:chat/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ChatNotificationService(),
        )
      ],
      child: MaterialApp(
        title: 'Chat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
                color: Colors.blue,
                foregroundColor: Colors.white,
                toolbarHeight: 75,
                centerTitle: true)),
        initialRoute: AppRoutes.initial,
        onGenerateRoute: (settings) {
          if (settings.name == AppRoutes.initial) {
            return AppCreateRoute.createRoute(const AuthOrAppPage());
          } else if (settings.name == AppRoutes.notifications) {
            return AppCreateRoute.createRoute(const NotificationPage());
          }
          return AppCreateRoute.createRoute(const AuthOrAppPage());
        },
      ),
    );
  }
}
