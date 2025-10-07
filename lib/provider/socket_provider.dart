// import 'package:flutter/material.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class SocketProvider with ChangeNotifier {
//   IO.Socket? socket;
//   // String url = 'https://gb.zto.mn';
//   String url = 'https://gerbook.com';
//   int notificationCount = 0;
//   bool isConnected = false;
//   String payment = '';
//   initSocket(String myToken) {
//     socket = IO.io(
//       url,
//       IO.OptionBuilder()
//           .setTransports(['websocket'])
//           .setQuery({
//             'token': myToken,
//           })
//           .enableForceNew()
//           .enableReconnection()
//           .build(),
//     );

//     socket!.on('connect', (_) {
//       isConnected = true;
//       print('Socket Connected');
//       // notificationCount += 1;
//       notifyListeners();
//     });

//     socket!.onAny((event, data) {
//       print('📢 Received Event: $event');
//     });

//     socket!.onAny((event, data) {
//       print('🔵 Received Event: $event');
//       print('🔹 Data: $data');
//     });

//     socket!.on('action', (data) {
//       print('Received Event: $data');
//       if (data is Map<String, dynamic> &&
//           data['type'] == 'notification.count.changed') {
//         var payload = data['payload'];
//         if (payload is Map<String, dynamic> &&
//             payload.containsKey('notificationCount')) {
//           notificationCount = payload['notificationCount'];
//         } else {
//           notificationCount = 0;
//         }
//         print('====test===count===');
//         print(notificationCount);
//         notifyListeners();
//       }
//     });
//     socket!.on('action', (data) {
//       print('Received Event: $data');
//       if (data is Map<String, dynamic> && data['type'] == 'payment.confirmed') {
//         var payload = data['payload'];
//         if (payload is Map<String, dynamic> && payload.containsKey('payment')) {
//           payment = payload['payment'];
//         } else {
//           payment = '';
//         }
//         print('====test===payment===');
//         print(payment);
//         notifyListeners();
//       }
//     });

//     socket!.on('disconnect', (_) {
//       isConnected = false;
//       print('Socket Disconnected');
//       notifyListeners();
//     });
//     socket!.connect();
//   }

//   sendStep(num amount, num latitude, num longitude) async {
//     print('===Check socket===');
//     print(socket!.connected);
//     print(isConnected);
//     if (socket!.connected) {
//       socket!.emit('action', {
//         'type': 'walk',
//         'payload': {
//           'amount': amount,
//           'latitude': latitude,
//           'longitude': longitude,
//         }
//       });
//       print('===SOCKET SENT===');
//     } else {
//       print('Socket not connected');
//     }
//   }
// }
