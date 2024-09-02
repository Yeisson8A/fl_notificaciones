import 'package:fl_notificaciones/services/push_notifications_service.dart';
import 'package:fl_notificaciones/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Inicializar notificación push Firebase
  await PushNotificationsService.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Key para navegación
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  // Key para snackBar
  final GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    // Suscribirse al stream de notificaciones
    PushNotificationsService.messagesStream.listen((message) {
      // Navegar a la pantalla "Message"
      navigatorKey.currentState?.pushNamed('message', arguments: message);

      final snackBar = SnackBar(content: Text(message));
      // Mostrar snackBar
      messengerKey.currentState?.showSnackBar(snackBar);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: messengerKey,
      initialRoute: 'home',
      routes: {
        'home': ( _ ) => const HomeScreen(),
        'message': ( _ ) => const MessageScreen()
      },
    );
  }
}
