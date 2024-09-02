import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

//SHA1: CF:23:94:52:52:AA:9B:7D:59:00:5D:87:75:56:BF:C9:55:7E:C0:CE

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  // Stream que va a estar escuchando las notificaciones
  static StreamController<String> _messageStream = StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;

  // Manejador de mensajes cuando la aplicación esta terminada
  static Future _backgroundHandler(RemoteMessage message) async {
    // Agregar notificación al stream
    _messageStream.add(message.data['producto'] ?? 'No data');
  }

  // Manejador de mensajes cuando la aplicación esta abierta
  static Future _onMessageHandler(RemoteMessage message) async {
    // Agregar notificación al stream
    _messageStream.add(message.data['producto'] ?? 'No data');
  }

  // Manejador de mensajes cuando la aplicación esta minimizada
  static Future _onMessageOpenApp(RemoteMessage message) async {
    // Agregar notificación al stream
    _messageStream.add(message.data['producto'] ?? 'No data');
  }

  static Future initializeApp() async {
    // Push notifications
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('Token: $token');

    // Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    // Local notifications
  }

  static closeStreams() {
    _messageStream.close();
  }
}